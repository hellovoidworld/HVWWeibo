//
//  HVWLoadMoreWeiboFooterView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/6.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWLoadMoreWeiboFooterView.h"

@interface HVWLoadMoreWeiboFooterView()

/** 加载更多微博文本 */
@property(nonatomic, strong) UILabel *label;

/** 加载中活动指示器 */
@property(nonatomic, strong) UIActivityIndicatorView *actIndicator;

@end

@implementation HVWLoadMoreWeiboFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_new_status_background"]];
    
    // 设置加载文本
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"上拉加载更多微博";
    self.label = label;
    [self addSubview:label];
    
    // 设置加载活动指示器
    // 不同类型的活动指示器大小是不一样的，要注意
    UIActivityIndicatorView *actIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.actIndicator = actIndicator;
    [self addSubview:actIndicator];
    
    return self;
}

/** 设置位置尺寸 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置本身frame
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = 35;
    
    // 设置文本frame
    self.label.frame = self.bounds;
    
    // 设置活动指示器frame
    CGFloat marginX = 50;
    self.actIndicator.x = self.width - self.actIndicator.width - marginX;
    self.actIndicator.y = (self.height - self.actIndicator.height) * 0.5;
}

/** 开始刷新 */
- (void) beginRefresh {
    self.label.text = @"正在努力加载更多微博...";
    [self.actIndicator startAnimating];
    self.refreshing = YES;
}

/** 停止刷新 */
- (void) endRefresh {
    self.label.text = @"上拉加载更多微博";
    [self.actIndicator stopAnimating];
    self.refreshing = NO;
}

@end
