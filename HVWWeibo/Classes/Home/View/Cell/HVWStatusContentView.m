//
//  HVWStatusContentView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusContentView.h"
#import "HVWStatusOriginalView.h"
#import "HVWStatusRetweetedView.h"

@interface HVWStatusContentView()

/** 原创内容 */
@property(nonatomic, weak) HVWStatusOriginalView *originalView;

/** 转发内容 */
@property(nonatomic, weak) HVWStatusRetweetedView *retweetedView;

@end

@implementation HVWStatusContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) { // 初始化子控件开始
        self.userInteractionEnabled = YES;
        
        // 设置背景图片
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImage:@"timeline_card_top_background_highlighted"];
        
        // 初始化原创内容控件
        [self setupOriginalView];
        
        // 初始化转发内容控件
        [self setupRetweetedView];
    }
    
    return self;
}

/** 初始化原创内容控件 */
- (void) setupOriginalView {
    HVWStatusOriginalView *originalView = [[HVWStatusOriginalView alloc] init];
    self.originalView = originalView;
    [self addSubview:originalView];
}

/** 初始化转发内容控件 */
- (void) setupRetweetedView {
    HVWStatusRetweetedView *retweetedView = [[HVWStatusRetweetedView alloc] init];
    self.retweetedView = retweetedView;
    [self addSubview:retweetedView];
}

/** 设置frame */
- (void)setContentFrame:(HVWStatusContentFrame *)contentFrame {
    _contentFrame = contentFrame;
    
    // 原创微博frame
    self.originalView.originalFrame = self.contentFrame.originalFrame;
    
    // 转发微博frame
    self.retweetedView.retweetedFrame = self.contentFrame.retweetedFrame;
    
    // 设置自己的frame
    self.frame = contentFrame.frame;
}

@end
