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
        return [NSString stringWithFormat:@"来自%@", [_source substringWithRange:sourceRange]];
    } else {
        return @"来源未知";
    }
}

/** 转发昵称 */
- (NSString *) retweetedName {
    return [NSString stringWithFormat:@"@%@:", self.user.name];
}

@end
