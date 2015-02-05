//
//  HVWStatus.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWUser.h"

@interface HVWStatus : NSObject

/** 微博信息内容 */
@property(nonatomic, strong) NSString *text;

/** 微博作者的用户信息字段 详细 */
@property(nonatomic, strong) HVWUser *user;

/** 微博配图地址数组，里面装载的时HVWPic模型 */
@property(nonatomic, strong) NSArray *pic_urls;

@end
