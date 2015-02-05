//
//  HVWAccountInfo.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

// 注意遵守NSCoding协议
@interface HVWAccountInfo : NSObject <NSCoding>

/** 访问令牌 */
@property(nonatomic, strong) NSString *access_token;

/** access_token的有效期，单位：秒 */
@property(nonatomic, strong) NSString *expires_in;

/** 过期时间，自己计算存储 */
@property(nonatomic, strong) NSDate *expires_time;

/**  当前授权用户的UID */
@property(nonatomic, strong) NSString *uid;

/** 自定义初始化方法,这里是用来初始化服务器发来的json数据的 */
+ (instancetype) accountInfoWithDictionary:(NSDictionary *) dict;

@end
