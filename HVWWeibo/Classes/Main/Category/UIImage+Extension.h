//
//  UIImage+Extension.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/** 自动给iOS7或以上系统使用带_os7结尾的图片 */
+ (UIImage *) imageWithNamed:(NSString *) imageName;

/** 保护性拉伸图片，通常用来使用小图做背景 */
+ (UIImage *) resizedImage:(NSString *) imageName;

@end
