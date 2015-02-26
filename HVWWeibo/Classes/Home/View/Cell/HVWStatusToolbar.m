//
//  HVWStatusToolbar.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusToolbar.h"

@implementation HVWStatusToolbar

/** 代码自定义初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

- (void)setToolbarFrame:(HVWStatusToolbarFrame *)toolbarFrame {
    _toolbarFrame = toolbarFrame;
    
    // 设置自己的frame
    self.frame = toolbarFrame.frame;
}

@end
