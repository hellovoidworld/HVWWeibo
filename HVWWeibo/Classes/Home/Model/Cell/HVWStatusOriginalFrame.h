//
//  HVWStatusOriginalFrame.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWStatus.h"

@interface HVWStatusOriginalFrame : NSObject

#pragma mark - frame模型
/** 自己的frame */
@property(nonatomic, assign) CGRect frame;

/** 昵称 */
@property(nonatomic, assign) CGRect nameFrame;

/** vip会员标识 */
@property(nonatomic, assign) CGRect vipFrame;

/** 正文 */
@property(nonatomic, assign) CGRect textFrame;

/** 来源 */
@property(nonatomic, assign) CGRect sourceFrame;

/** 发表时间 */
@property(nonatomic, assign) CGRect timeFrame;

/** 头像 */
@property(nonatomic, assign) CGRect iconFrame;

/** 配图相册 */
@property(nonatomic, assign) CGRect photosFrame;

#pragma mark - 数据模型
/** 微博数据 */
@property(nonatomic, strong) HVWStatus *status;

@end
