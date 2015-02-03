//
//  HVWNavigationBarTitleButton.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/2.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWNavigationBarTitleButton.h"

@implementation HVWNavigationBarTitleButton

/** 重写initWithFrame, 统一设置按钮的样式 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置字体
        self.titleLabel.font = HVWNavigationTitleFont;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 文本右对齐
        [self.titleLabel setTextAlignment:NSTextAlignmentRight];
        
        // 取消图标高亮效果
        [self setAdjustsImageWhenDisabled:NO];
        
        // 图片居中
        [self.imageView setContentMode:UIViewContentModeCenter];
    }
    
    return self;
}

/** 重写iamge的绘图方法 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat height = contentRect.size.height;
    CGFloat width = height;
    CGFloat x = self.size.width - width;
    CGFloat y = 0;
    return CGRectMake(x, y, width, height);
}

/** 重写title的绘图方法 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat height = contentRect.size.height;
    // 文本宽度 = 按钮整体宽度 - 图片宽度
    CGFloat width = self.width - height;
    CGFloat x = 0;
    CGFloat y = 0;
    return CGRectMake(x, y, width, height);
}

@end
