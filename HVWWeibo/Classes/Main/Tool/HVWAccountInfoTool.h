//
//  HVWAccountInfoTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWAccountInfo.h"

@interface HVWAccountInfoTool : NSObject

/** 从文件获取accountInfo */
+ (HVWAccountInfo *) accountInfo;

/** 存储accountInfo到文件 */
+ (void) saveAccountInfo:(HVWAccountInfo *) accountInfo;

@end
