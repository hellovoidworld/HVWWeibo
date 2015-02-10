//
//  HVWBaseTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWBaseTool : NSObject

/** GET请求 */
+ (void) getWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/** POST请求(不带文件参数) */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/** POST请求(带文件参数) */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters filesData:(NSArray *)filesData resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
