//
//  HVWStatusContentFrame.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWStatusOriginalFrame.h"
#import "HVWStatusRetweetedFrame.h"
#import "HVWStatus.h"

@interface HVWStatusContentFrame : NSObject

#pragma mark - frame模型
/** 原创微博frame */
@property(nonatomic, strong) HVWStatusOriginalFrame *originalFrame;

/** 转发微博frame */
@property(nonatomic, strong) HVWStatusRetweetedFrame *retweetedFrame;

/** 自己的frame */
@property(nonatomic, assign) CGRect frame;

#pragma mark - 数据模型
/** 微博数据 */
@property(nonatomic, strong) HVWStatus *status;

@end
