//
//  HVWComposeEmotionPageControl.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionPageControl.h"

@implementation HVWComposeEmotionPageControl

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 当前页页码样式
        UIImage *currentImage = [UIImage imageWithNamed:@"compose_keyboard_dot_selected"];
        [self setValue:currentImage forKeyPath:@"_currentPageImage"];
        
        // 其他页页码样式
        UIImage *normalImage = [UIImage imageWithNamed:@"compose_keyboard_dot_normal"];
        [self setValue:normalImage forKeyPath:@"_pageImage"];
    }
    return self;
}

@end
