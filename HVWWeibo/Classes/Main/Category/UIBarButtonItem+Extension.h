//
//  UIBarButtonItem+Extension.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype) itemWithImage:(NSString *) imageName hightlightedImage:(NSString *) highlightedImageName target:(id)target selector:(SEL)selector;

@end
