//
//  HVWComposeEmotionPopView.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVWComposeEmotionButton.h"

@interface HVWComposeEmotionPopView : UIView

/** 实例化 */
+ (instancetype) popView;

/** 弹出表情 */
- (void) popEmotion:(HVWComposeEmotionButton *)emotionButton;

/** 隐藏 */
- (void) dismiss;

@end
