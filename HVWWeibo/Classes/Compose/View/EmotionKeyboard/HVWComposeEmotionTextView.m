//
//  HVWComposeEmotionTextView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionTextView.h"
#import "HVWComposeEmotionAttachment.h"

@implementation HVWComposeEmotionTextView

/** 拼接表情 */
- (void) appendEmotion:(HVWEmotion *)emotion {
    if (emotion.type == EmotionTypeEmoji) { // emoji
        [self insertText:emotion.emoji];
    } else { // 图片表情
        // 准备图片表情attachment
        HVWComposeEmotionAttachment *attach = [[HVWComposeEmotionAttachment alloc] init];
        // 设置图片大小
        attach.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        attach.emotion = emotion;
        
        // 新的富文本
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
        
        // 获取输入光标
        int insertIndex = self.selectedRange.location;
        
        // 原来的富文本
        NSAttributedString *originalStr = self.attributedText;
        // 插入图片表情到特定位置
        NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] initWithAttributedString:originalStr];
        [resultStr insertAttributedString:imageStr atIndex:insertIndex];
        
        // 设置富文本字体，不然会出现差异
        [resultStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, resultStr.length)];
        
        // 赋值到textView上
        self.attributedText = resultStr;
        
        // 让光标回到表情后
        self.selectedRange = NSMakeRange(insertIndex + 1, 0);
    }
}

/** 纯文本格式输出 */
- (NSString *)plainText {
    NSMutableString *resultStr = [NSMutableString string];
    
    // 遍历富文本里面所有内容，区分开普通文本和图片
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        HVWComposeEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) { // 图片
            [resultStr appendString:attach.emotion.chs];
        } else { // 普通文本
            NSString *subStr = [self.attributedText attributedSubstringFromRange:range].string;
            [resultStr appendString:subStr];
        }
    }];
    
    return resultStr;
}

@end
