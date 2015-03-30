//
//  HVWComposeEmotionPopView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionPopView.h"
#import "HVWEmotion.h"

@interface HVWComposeEmotionPopView()

/** 表情按钮 */
@property (weak, nonatomic) IBOutlet HVWComposeEmotionButton *emotionButton;

@end

@implementation HVWComposeEmotionPopView

/** 实例化 */
+ (instancetype) popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HVWComposeEmotionPopView" owner:nil options:nil] lastObject];
}

/** 弹出表情 */
- (void) popEmotion:(HVWComposeEmotionButton *)emotionButton {
    if (nil == emotionButton) return; // 如果选中区域在表情按钮之外
    
    // 显示表情
    self.emotionButton.emotion = emotionButton.emotion;
    
    // 添加最前窗口显示
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
    
    // 配置位置信息
    CGFloat popViewCenterX = emotionButton.centerX;
    CGFloat popViweCenterY = emotionButton.centerY - self.height * 0.5;
    CGPoint popViewCenter = CGPointMake(popViewCenterX, popViweCenterY);
    self.center = [window convertPoint:popViewCenter fromView:emotionButton.superview];
}

/** 隐藏 */
- (void) dismiss {
    [self removeFromSuperview];
}

@end
