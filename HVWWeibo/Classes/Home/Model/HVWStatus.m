//
//  HVWStatus.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatus.h"
#import "HVWPic.h"
#import "NSDate+Extension.h"
#import "RegexKitLite.h"
#import "HVWRegexResult.h"
#import "HVWEmotion.h"
#import "HVWEmotionTool.h"
#import "HVWComposeEmotionAttachment.h"
#import "HVWRegexTool.h"

// 注意引入框架
#import "MJExtension.h"

@implementation HVWStatus

- (NSDictionary *)objectClassInArray {
    // 返回一个字典，创建数组子元素和包装类的映射关系
    return @{@"pic_urls": [HVWPic class]};
}

/** 重写create_at的getter */
- (NSString *)created_at {
    //_create_at: Mon Feb 16 15:11:15 +0800 2015
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 设置日期设置语言样式，因为微博API返回的是英文样式!
    NSLocale *en_locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.locale = en_locale;
    
    // 读取日期格式
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 解析日期
    NSDate *createdDate = [formatter dateFromString:_created_at];
    
    if ([createdDate isThisYear]) { // 如果在今年内
        if ([createdDate isThisMonth]) { // 如果在今个月内
            if ([createdDate isToday]) { // 如果在今日内
                if ([createdDate isThisHour]) { // 如果在一个小时内
                    if ([createdDate isThisMinutes]) { // 如果在1分钟内
                        return @"刚刚";
                    } else {
                        return [NSString stringWithFormat:@"%d分钟前", [createdDate dateComponentsToNow].minute];
                    }
                } else {
                    return [NSString stringWithFormat:@"%d小时前", [createdDate dateComponentsToNow].hour];
                }
            } else {
                return [NSString stringWithFormat:@"%d天前", [createdDate dateComponentsToNow].day];
            }
        }
    }
    
    // 一个月之前的都使用详细日期
    return [createdDate dateWithFormatYMD];
}

/** 重写来源source的getter */
- (NSString *)source {
    NSRange startRange = [_source rangeOfString:@">"];
    NSRange endRange = [_source rangeOfString:@"</"];
    
    if (startRange.length && endRange.length) {
        NSRange sourceRange = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - 1);
        return [NSString stringWithFormat:@"来自 %@", [_source substringWithRange:sourceRange]];
    } else {
        return @"来源未知";
    }
}

/** 根据文本创建富文本 */
- (NSAttributedString *) attributeStringWithText:(NSString *)text {
    NSMutableAttributedString *resultAttrStr = [[NSMutableAttributedString alloc] init];
    
    // 组织富文本形式的内容
    NSArray *regexResults = [self groupEmotionNText:text];
    [regexResults enumerateObjectsUsingBlock:^(HVWRegexResult *regexResult, NSUInteger idx, BOOL *stop) {
        if (regexResult.isEmotion) { // 表情
            // 创建带图片附件
            HVWComposeEmotionAttachment *attach = [[HVWComposeEmotionAttachment alloc] init];
            attach.emotion = [HVWEmotionTool emotionWithDesc:regexResult.str];
            
            // 设置格式
            attach.bounds = CGRectMake(0, -3, HVWStatusOriginalTextFont.lineHeight, HVWStatusOriginalTextFont.lineHeight);
            // 包装成富文本
            NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attach];
            
            // 添加到总的富文本上
            [resultAttrStr appendAttributedString:attrStr];
            
        } else { // 文本
            NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc] initWithString:regexResult.str];
            
            // 如果是@xxx
            NSString *mentionRegex = [HVWRegexTool mentionRegex];
            [regexResult.str enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                
                [subStr addAttribute:NSForegroundColorAttributeName value:HVWStatusHighlightedTextColor range:*capturedRanges];
                // 可点击链接属性标识
                [subStr addAttribute:HVWStatusLinkAttributeKey value:*capturedStrings range:*capturedRanges];
            }];
            
            // 如果是话题#xxx#
            NSString *subjectRegex = [HVWRegexTool subjectRegex];
            [subStr.string enumerateStringsMatchedByRegex:subjectRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                
                [subStr addAttribute:NSForegroundColorAttributeName value:HVWStatusHighlightedTextColor range:*capturedRanges];
                // 可点击链接属性标识
                [subStr addAttribute:HVWStatusLinkAttributeKey value:*capturedStrings range:*capturedRanges];
            }];
            
            // 如果是话题超链接 httpxxx
            NSString *hrefRegex = [HVWRegexTool hrefRegex];
            [subStr.string enumerateStringsMatchedByRegex:hrefRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                
                [subStr addAttribute:NSForegroundColorAttributeName value:HVWStatusHighlightedTextColor range:*capturedRanges];
                // 可点击链接属性标识
                [subStr addAttribute:HVWStatusLinkAttributeKey value:*capturedStrings range:*capturedRanges];
            }];
            
            [resultAttrStr appendAttributedString:subStr];
        }
    }];
    
    // 设置字体
    [resultAttrStr addAttributes:@{NSFontAttributeName:HVWStatusRichTextFont} range:NSMakeRange(0, resultAttrStr.length)];
    
    return resultAttrStr;
}

/** 给返回的纯文本微博内容按普通文本和表情关键字分组 */
- (NSArray *) groupEmotionNText:(NSString *)text {
    NSMutableArray *group = [NSMutableArray array];
    
    // [xxx]的模式匹配
    NSString *regex = @"\\[[1-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    // 匹配到的字符串数组（表情数组）
    [text enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        HVWRegexResult *regexResult = [[HVWRegexResult alloc] init];
        regexResult.str = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = YES;
        
        [group addObject:regexResult];
    }];
    
    // 被匹配到字符串分割的字符串数组（文本数组）
    [text enumerateStringsSeparatedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        HVWRegexResult *regexResult = [[HVWRegexResult alloc] init];
        regexResult.str = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = NO;
        
        [group addObject:regexResult];
    }];
    
    // 返回再进行了排序处理的数组
    return [self sortRexgexResults:group];
}

/** 给分割富文本信息而来的数组按照原来的显示顺序排序 */
- (NSArray *) sortRexgexResults:(NSArray *)regexResults {
    return [regexResults sortedArrayUsingComparator:^NSComparisonResult(HVWRegexResult *r1, HVWRegexResult *r2) {
        int loc1 = r1.range.location;
        int loc2 = r2.range.location;
        return [@(loc1) compare:@(loc2)];
    }];
}

/** 设置转发微博 */
- (void)setRetweeted_status:(HVWStatus *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    // 标记微博是否为转发微博
    self.retweeted = NO; // 转发了别人微博的此条微博是原创
    // 其中转发的微博
    self.retweeted_status.retweeted = YES;
}

/** 合成带昵称的富文本正文 */
- (void) createAttributeText {
    if (nil == self.user || nil == self.text) return;
    
    if (self.retweeted) {
        NSString *totalText= [NSString stringWithFormat:@"@%@: %@", self.user.name, self.text];
        self.attrText = [self attributeStringWithText:totalText];
    } else {
        self.attrText = [self attributeStringWithText:self.text];
    }
}

- (void)setUser:(HVWUser *)user {
    _user = user;
    
    // 更新富文本
    [self createAttributeText];
}

/** 微博内容 */
- (void) setText:(NSString *)text {
    _text = text;
    
    // 更新富文本
    [self createAttributeText];
}

/** 本事是否被转发的微博 */
- (void) setRetweeted:(BOOL)retweeted {
    _retweeted = retweeted;
    
    // 如果是被转发的微博，正文要加上用户昵称
    [self createAttributeText];
}

@end
