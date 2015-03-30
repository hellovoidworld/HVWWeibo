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
#import "HVWStatusPhotosView.h"
#import "HVWStatusContentText.h"

@interface HVWStatusRetweetedView()

/** 昵称 */
//@property(nonatomic, weak) UILabel *nameLabel;

/** 微博文本内容 */
@property(nonatomic, weak) HVWStatusContentText *textLabel;

/** 微博配图控件 */
@property(nonatomic, weak) HVWStatusPhotosView *photosView;

@end

@implementation HVWStatusRetweetedView

/** 代码初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) { // 初始化子控件开始
        self.userInteractionEnabled = YES;
        
        // 正文
        HVWStatusContentText *textLabel = [[HVWStatusContentText alloc] init];
//        textLabel.font = HVWStatusRetweetedTextFont;
//        textLabel.numberOfLines = 0; // 设置自动换行
        self.textLabel = textLabel;
        [self addSubview:textLabel];
        
        // 设置背景图片
        [self setImage:[UIImage imageWithNamed:@"timeline_retweet_background"]];
        [self setHighlightedImage:[UIImage imageWithNamed:@"timeline_retweet_background_highlighted"]];
        
        // 配图
        HVWStatusPhotosView *photosView = [[HVWStatusPhotosView alloc] init];
        self.photosView = photosView;
        [self addSubview:photosView];
    }
    
    return self;
}

/** 设置frame */
- (void)setRetweetedFrame:(HVWStatusRetweetedFrame *)retweetedFrame {
    _retweetedFrame = retweetedFrame;
    
    HVWStatus *status = retweetedFrame.status;
    
    // 设置控件frame
    
    // 正文
    self.textLabel.frame = retweetedFrame.textFrame;
    // 使用富文本
    self.textLabel.attributedText = status.attrText;
    
    // 配图
    if (status.pic_urls.count) {
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 设置自己的frame
    self.frame = retweetedFrame.frame;
}

@end
