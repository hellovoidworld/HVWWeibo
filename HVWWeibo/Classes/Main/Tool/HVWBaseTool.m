//
//  HVWBaseTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseTool.h"
#import "HVWNetworkTool.h"
#import "MJExtension.h"

@implementation HVWBaseTool

/** GET请求 */
+ (void) getWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [HVWNetworkTool get:url parameters:param success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            if (failure) {
                failure(error);
            }
        }
    }];
}

/** POST请求(不带文件参数) */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [HVWNetworkTool post:url parameters:param success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            if (failure) {
                failure(error);
            }
        }
    }];
}

/** POST请求(带文件参数) */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters filesData:(NSArray *)filesData resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [HVWNetworkTool post:url parameters:param filesData:filesData success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            if (failure) {
                failure(error);
            }
        }
    }];
}

@end
