//
//  HVWStatusTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWBaseTool.h"
#import "HVWHomeStatusParam.h"
#import "HVWHomeStatusResult.h"
#import "HVWComposeStatusParam.h"
#import "HVWComposeStatusResult.h"

@interface HVWStatusTool : HVWBaseTool

/** 获取首页微博数据 */
+ (void) statusWithParameters:(HVWHomeStatusParam *)parameters success:(void (^)(HVWHomeStatusResult *statusResult))success failure:(void (^)(NSError *error))failure;

/** 发送微博 */
+ (void) composeStatusWithParameters:(HVWComposeStatusParam *)parameters imagesData:(NSArray *)imagesData success:(void (^)(HVWComposeStatusResult *result))success failure:(void (^)(NSError *error))failure;

@end
