//
//  HVWStatusFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusFrame.h"
#import "HVWStatusContentFrame.h"
#import "HVWStatusToolbarFrame.h"

@implementation HVWStatusFrame

/** 使用status数组包装一个statusFrame数组 */
+ (NSArray *) statusFramesWithStatuses:(NSArray *)statuses {
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    for (HVWStatus *status in statuses) {
        HVWStatusFrame *statusFrame = [[HVWStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrameArray addObject:statusFrame];
    }
    return statusFrameArray;
}

/** 加载数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // 设置子控件frame
    // 微博内容frame
    HVWStatusContentFrame *contentFrame = [[HVWStatusContentFrame alloc] init];
    self.contentFrame = contentFrame;
    contentFrame.status = status;
    
    // 工具条frame
    HVWStatusToolbarFrame *toolbarFrame = [[HVWStatusToolbarFrame alloc] init];
    self.toolbarFrame = toolbarFrame;
    toolbarFrame.status = status;
    CGRect tbFrame = toolbarFrame.frame;
    tbFrame.origin.y = CGRectGetMaxY(contentFrame.frame);
    toolbarFrame.frame = tbFrame;
    
    // cell高度
    self.cellHeight = CGRectGetMaxY(tbFrame);
}

@end
