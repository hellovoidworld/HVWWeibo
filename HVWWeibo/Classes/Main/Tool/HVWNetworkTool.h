//
//  HVWNetworkTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWNetworkTool : NSObject

/** get方法发送请求 */
+ (void) get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error)) failure;

/** post方法发送请求 */
+ (void) post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/** post方法发送请求（带文件数据) */
+ (void) post:(NSString *)url parameters:(NSDictionary *) parameters filesData:(NSArray *)filesData success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
