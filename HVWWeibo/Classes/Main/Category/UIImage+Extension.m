//
//  UIImage+Extension.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/** 自动给iOS7或以上系统使用带_os7结尾的图片 */
+ (UIImage *) imageWithNamed:(NSString *) imageName {
    UIImage *image = nil;
    
    // 如果是iOS7或以上版本
    if (iOS7) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_os7", imageName]];
    }
    
    // 如果是iOS6
    if (nil == image) {
        image = [UIImage imageNamed:imageName];
    }
    
    return image;
}

/** 保护性拉伸图片，通常用来使用小图做背景 */
+ (UIImage *) resizedImage:(NSString *) imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
