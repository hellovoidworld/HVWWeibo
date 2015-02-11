//
//  HVWUnreadCountTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseTool.h"
#import "HVWUnreadCountParam.h"
#import "HVWUnreadCountResult.h"

@interface HVWUnreadCountTool : HVWBaseTool

/** 获取未读消息数 */
+ (void) unreadCountWithParameters:(HVWUnreadCountParam *)parameters success:(void (^)(HVWUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
