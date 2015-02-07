//
//  HVWComposeToolBar.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/7.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeToolBar.h"

@implementation HVWComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 背景色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"compose_toolbar_background"]];
        
        // 添加按钮
        [self addButtonWithIcon:@"compose_camerabutton_background" highlightedIcon:@"compose_camerabutton_background_highlighted" tag:HVWComposeToolBarButtonTagCamera];
        
        [self addButtonWithIcon:@"compose_toolbar_picture" highlightedIcon:@"compose_toolbar_picture_highlighted" tag:HVWComposeToolBarButtonTagPhotoLib];
        
        [self addButtonWithIcon:@"compose_mentionbutton_background" highlightedIcon:@"compose_mentionbutton_background_highlighted" tag:HVWComposeToolBarButtonTagMention];
        
        [self addButtonWithIcon:@"compose_trendbutton_background" highlightedIcon:@"compose_trendbutton_background_highlighted" tag:HVWComposeToolBarButtonTagTrend];
        
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highlightedIcon:@"compose_emoticonbutton_background_highlighted" tag:HVWComposeToolBarButtonTagEmotion];
    }
    
    
    return self;
}

/** 添加一个按钮 */
- (void) addButtonWithIcon:(NSString *) icon highlightedIcon:(NSString *) highlightedIcon tag:(HVWComposeToolBarButtonTag) tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithNamed:highlightedIcon] forState:UIControlStateHighlighted];
    button.tag = tag;
    
    // 按钮点击事件
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

/** 设置frame */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonWidth = self.width / self.subviews.count;
    
    // 设置每个按钮
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        
        CGFloat buttonHeight = buttonWidth;
        CGFloat buttonX = i * buttonWidth;
        CGFloat buttonY = (self.height - buttonHeight) * 0.5;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
}

/** 按钮点击 */
- (void) buttonClicked:(UIButton *) button {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didButtonClicked:)]) {
        [self.delegate composeToolBar:self didButtonClicked:button.tag];
    }
}

@end
