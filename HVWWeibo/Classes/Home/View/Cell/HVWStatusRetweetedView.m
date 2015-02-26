//
//  HVWStatusRetweetedView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusRetweetedView.h"
#import "HVWStatus.h"
#import "HVWUser.h"

@interface HVWStatusRetweetedView()

/** 昵称 */
@property(nonatomic, weak) UILabel *nameLabel;

/** 微博文本内容 */
@property(nonatomic, weak) UILabel *textLabel;

@end

@implementation HVWStatusRetweetedView

/** 代码初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) { // 初始化子控件开始
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HVWStatusOriginalNameFont;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        // 正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = HVWStatusRetweetedTextFont;
        textLabel.numberOfLines = 0; // 设置自动换行
        self.textLabel = textLabel;
        [self addSubview:textLabel];
        
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
}

/** 设置frame */
- (void)setRetweetedFrame:(HVWStatusRetweetedFrame *)retweetedFrame {
    _retweetedFrame = retweetedFrame;
    
    HVWStatus *status = retweetedFrame.status;
    
    // 设置控件frame
    // 昵称
    self.nameLabel.frame = retweetedFrame.nameFrame;
    self.nameLabel.text = [status retweetedName];
    
    // 正文
    self.textLabel.frame = retweetedFrame.textFrame;
    self.textLabel.text = status.text;
    
    // 设置自己的frame
    self.frame = retweetedFrame.frame;
}

@end
