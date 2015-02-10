//
//  HVWUserTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseTool.h"
#import "HVWUserParam.h"
#import "HVWUserResult.h"

@interface HVWUserTool : HVWBaseTool

/** 获取用户信息 */
+ (void) userWithParameters:(HVWUserParam *)parameters success:(void (^)(HVWUserResult *))success failure:(void (^)(NSError *error))failure;

@end
