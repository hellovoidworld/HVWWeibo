//
//  UIImage+Extension.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

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

@end
