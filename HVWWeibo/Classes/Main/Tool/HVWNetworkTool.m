//
//  HVWNetworkTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWNetworkTool.h"
#import "AFNetworking.h"
#import "HVWFileDataParam.h"

@implementation HVWNetworkTool

/** get方法发送请求 */
+ (void) get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error)) failure {
    // 创建http操作管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/** post方法发送请求 */
+ (void) post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure {
    // 创建http操作管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/** post方法发送请求（带文件数据) */
+ (void) post:(NSString *)url parameters:(NSDictionary *) parameters filesData:(NSArray *)filesData success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // 创建http操作管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 读取文件参数
        for (HVWFileDataParam *fileDataParam in filesData) {
            [formData appendPartWithFileData:fileDataParam.fileData name:fileDataParam.name fileName:fileDataParam.fileName mimeType:fileDataParam.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
