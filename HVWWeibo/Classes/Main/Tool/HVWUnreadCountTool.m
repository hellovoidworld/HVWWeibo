//
//  HVWUnreadCountTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWUnreadCountTool.h"

@implementation HVWUnreadCountTool

/** 获取未读消息数 */
+ (void) unreadCountWithParameters:(HVWUnreadCountParam *)parameters success:(void (^)(HVWUnreadCountResult *result))success failure:(void (^)(NSError *error))failure {
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters resultClass:[HVWUnreadCountResult class] success:success failure:failure];
}

@end
