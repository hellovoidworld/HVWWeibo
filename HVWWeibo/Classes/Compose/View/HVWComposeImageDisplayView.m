//
//  HVWComposeImageDisplayView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/7.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeImageDisplayView.h"

#define MaxColumn 4

@implementation HVWComposeImageDisplayView

/** 添加图片 */
- (void) addImage:(UIImage *) image {
    HVWLog(@"addImage");
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:imageView];
    
    [self setNeedsDisplay];
}

/** 设置frame */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIImageView *imageView = [self.subviews lastObject];
    int index = self.subviews.count - 1;
    // 所在列
    int column = index % MaxColumn;
    // 所在行
    int row = index / MaxColumn;
    
    CGFloat margin = 10;
    CGFloat imageWidth = (self.width - (MaxColumn + 1) * margin) / MaxColumn;
    CGFloat imageHeight = imageWidth;
    CGFloat imageX = column * (imageWidth + margin) + margin;
    CGFloat imageY = row * (imageHeight + margin);
    
    imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

@end
