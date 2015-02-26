//
//  HVWStatusFrame.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWStatus.h"
#import "HVWStatusContentFrame.h"
#import "HVWStatusToolbarFrame.h"

@interface HVWStatusFrame : NSObject

#pragma mark - 数据模型
/** cell内微博数据 */
@property(nonatomic, strong) HVWStatus *status;

#pragma mark - frame模型
/** 微博内容frame */
@property(nonatomic, strong) HVWStatusContentFrame *contentFrame;

/** 工具条frame */
@property(nonatomic, strong) HVWStatusToolbarFrame *toolbarFrame;

/** cell高度 */
@property(nonatomic, assign) CGFloat cellHeight;

#pragma mark - 方法
/** 使用status数组包装一个statusFrame数组 */
+ (NSArray *) statusFramesWithStatuses:(NSArray *)statuses;

@end
