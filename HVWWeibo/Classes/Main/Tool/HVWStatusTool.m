//
//  HVWStatusTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusTool.h"
#import "MJExtension.h"

@implementation HVWStatusTool

/** 获取首页微博数据 */
+ (void) statusWithParameters:(HVWHomeStatusParam *)parameters success:(void (^)(HVWHomeStatusResult *statusResult))success failure:(void (^)(NSError *error))failure {
    // 发送请求
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters resultClass:[HVWHomeStatusResult class] success:success failure:failure];
}

/** 发送微博 */
+ (void) composeStatusWithParameters:(HVWComposeStatusParam *)parameters imagesData:(NSArray *)imagesData success:(void (^)(HVWComposeStatusResult *result))success failure:(void (^)(NSError *error))failure {
    // 发送请求
    if (imagesData.count) { // 带图片微博
        [self postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters filesData:imagesData resultClass:[HVWComposeStatusResult class] success:success failure:failure];
    } else { // 纯文本微博
        [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters resultClass:[HVWComposeStatusResult class] success:success failure:failure];
    }
}

@end
