//
//  UIBarButtonItem+Extension.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype) itemWithImage:(NSString *) imageName hightlightedImage:(NSString *) highlightedImageName target:(id)target selector:(SEL)selector {
    UIBarButtonItem *item = [[self alloc] init];
    
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    
    // 一定要设置frame，才能显示
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 设置事件
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    item.customView = button;
    return item;
}

@end
