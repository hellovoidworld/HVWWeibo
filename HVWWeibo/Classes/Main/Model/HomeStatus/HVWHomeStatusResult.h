//
//  HVWHomeStatusResult.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWStatus.h"

@interface HVWHomeStatusResult : NSObject

/** 微博数组，里面装的HVWStatus模型 */
@property(nonatomic, strong) NSArray *statuses;

/** 近期微博总数 */
@property(nonatomic, assign) int total_number;

@end
