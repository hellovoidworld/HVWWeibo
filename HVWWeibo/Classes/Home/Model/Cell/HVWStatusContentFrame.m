//
//  HVWStatusContentFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusContentFrame.h"
#import "HVWStatusOriginalFrame.h"
#import "HVWStatusRetweetedFrame.h"

@implementation HVWStatusContentFrame

/** 加载微博数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // 设置控件frame
    // 原创微博
    HVWStatusOriginalFrame *originalFrame = [[HVWStatusOriginalFrame alloc] init];
    self.originalFrame = originalFrame;
    originalFrame.status = status;
    
    // 转发微博
    CGFloat contentHeight = 0;
    if (self.status.retweeted_status) { // 当转发了微博的时候
        HVWStatusRetweetedFrame *retweetedFrame = [[HVWStatusRetweetedFrame alloc] init];
        retweetedFrame.status = status.retweeted_status;
        
        // 设置frame
        CGRect retFrame = retweetedFrame.frame;
        retFrame.origin.y = CGRectGetMaxY(originalFrame.frame);
        
        retweetedFrame.frame = retFrame;
        self.retweetedFrame = retweetedFrame;
        
        contentHeight = CGRectGetMaxY(retFrame);
    } else {
        contentHeight = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat contentX = 0;
    CGFloat contentY = 0;
    CGFloat contentWidth = HVWScreenWidth;
    self.frame = CGRectMake(contentX, contentY, contentWidth, contentHeight);
}

@end
