//
//  HVWPic.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWPic.h"

@implementation HVWPic

/** 设置缩略图的同时，配置中等图片url */
- (void)setThumbnail_pic:(NSString *)thumbnail_pic {
    _thumbnail_pic = [thumbnail_pic copy]; // 待会要修改此url，所以使用copy
    
    // 修改路径地址
    _bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
