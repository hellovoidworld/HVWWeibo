//
//  HVWStatusToolbarFrame.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWStatus.h"

@interface HVWStatusToolbarFrame : NSObject

#pragma mark - frame模型
/** 自己的frame */
@property(nonatomic, assign) CGRect frame;

#pragma mark - 数据模型
/** 微博数据 */
@property(nonatomic, strong) HVWStatus *status;

@end
