//
//  HVWComposeEmotionButton.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HVWEmotion;
@interface HVWComposeEmotionButton : UIButton

/** 表情模型 */
@property(nonatomic, strong) HVWEmotion *emotion;

@end
