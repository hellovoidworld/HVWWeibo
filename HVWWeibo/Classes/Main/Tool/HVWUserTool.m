//
//  HVWUserTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWUserTool.h"

@implementation HVWUserTool

/** 获取用户信息 */
+ (void) userWithParameters:(HVWUserParam *)parameters success:(void (^)(HVWUserResult *))success failure:(void (^)(NSError *error))failure  {
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" parameters:parameters resultClass:[HVWUserResult class] success:success failure:failure];
}

@end
