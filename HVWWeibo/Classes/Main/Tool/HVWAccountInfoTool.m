//
//  HVWAccountInfoTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWAccountInfoTool.h"

#define accountInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountInfo.data"]

@implementation HVWAccountInfoTool

/** 从文件获取accountInfo */
+ (HVWAccountInfo *) accountInfo {
    HVWAccountInfo *accountInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:accountInfoPath]];
    
    // 需要判断是否过期
    NSDate *now = [NSDate date];
    if ([now compare:accountInfo.expires_time] != NSOrderedAscending) { // now->expires_data 非升序, 已经过期
        accountInfo = nil;
    }
    
    return accountInfo;
}

/** 存储accountInfo到文件 */
+ (void) saveAccountInfo:(HVWAccountInfo *) accountInfo {
    [NSKeyedArchiver archiveRootObject:accountInfo toFile:accountInfoPath];
}

@end
