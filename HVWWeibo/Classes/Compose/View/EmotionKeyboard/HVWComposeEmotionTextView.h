//
//  HVWComposeEmotionTextView.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeTextView.h"
#import "HVWEmotion.h"

@interface HVWComposeEmotionTextView : HVWComposeTextView

/** 拼接表情 */
- (void) appendEmotion:(HVWEmotion *)emotion;

/** 纯文本格式输出 */
- (NSString *)plainText;

@end
