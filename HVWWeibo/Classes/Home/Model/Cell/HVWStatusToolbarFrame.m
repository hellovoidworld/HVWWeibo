//
//  HVWStatusToolbarFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusToolbarFrame.h"

@implementation HVWStatusToolbarFrame

/** 加载数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // 设计自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = HVWScreenWidth;
    CGFloat height = 35;
    self.frame = CGRectMake(x, y, width, height);
}

@end
