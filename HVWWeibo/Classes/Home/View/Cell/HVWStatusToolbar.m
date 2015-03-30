//
//  HVWStatusToolbar.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusToolbar.h"

@interface HVWStatusToolbar()

/** 按钮数组 */
@property(nonatomic, strong) NSMutableArray *buttons;

/** 分割线数组 */
@property(nonatomic, strong) NSMutableArray *divides;

/** 转发按钮 */
@property(nonatomic, strong) UIButton *repostButton;

/** 评论按钮 */
@property(nonatomic, strong) UIButton *commentButton;

/** 点赞按钮 */
@property(nonatomic, strong) UIButton *attitudeButton;

@end

@implementation HVWStatusToolbar

- (NSMutableArray *)buttons {
    if (nil == _buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)divides {
    if (nil == _divides) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

/** 代码自定义初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 设置toolbar背景
        self.image = [UIImage resizedImage:@"timeline_card_bottom_background"];
        
        // 为了按钮能够点击，设置父控件可交互
        self.userInteractionEnabled = YES;
        
        // 添加按钮
        self.repostButton = [self setupButtonWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentButton = [self setupButtonWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.attitudeButton = [self setupButtonWithIcon:@"timeline_icon_unlike" title:@"赞"];
        
        // 添加分割线
        [self setupDivides];
    }
    
    return self;
}

// 设置按钮
- (UIButton *) setupButtonWithIcon:(NSString *)icon title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 标题
    [button setTitle:title forState:UIControlStateNormal];
    // 图片
    [button setImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    // 字体颜色
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 字体大小
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    // 图标、文本之间间隙
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    // 高亮背景
    [button setBackgroundImage:[UIImage imageWithNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    // 取消高亮图片调整效果
    [button setAdjustsImageWhenHighlighted:NO];
    
    // 加入到view中
    [self addSubview:button];
    [self.buttons addObject:button];
    
    return button;
}

// 设置分割线
- (void) setupDivides {
    for (int i=1; i<self.buttons.count; i++) {
        UIImageView *divide = [[UIImageView alloc] init];
        divide.image = [UIImage imageWithNamed:@"timeline_card_bottom_line"];
        divide.contentMode = UIViewContentModeCenter;
        
        [self addSubview:divide];
        [self.divides addObject:divide];
    }
}

/** 设置Frame模型 */
- (void)setToolbarFrame:(HVWStatusToolbarFrame *)toolbarFrame {
    _toolbarFrame = toolbarFrame;
    
    // 设置自己的frame
    self.frame = toolbarFrame.frame;
    
    // 配置toolbar按钮数据
    [self setupToolBarButton];
}


// 设置子控件frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 配置按钮frame
    CGFloat buttonWidth = self.width / self.buttons.count;
    CGFloat buttonHeight = self.height;
    CGFloat buttonY = 0;
    for (int i=0; i<self.buttons.count; i++) {
        CGFloat buttonX = i * buttonWidth;
        UIButton *button = self.buttons[i];
        
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
    
    // 配置分割线frame
    CGFloat divideWidth = 4;
    CGFloat divideHeight = self.height;
    for (int i=0; i<self.divides.count; i++) {
        CGFloat divideX = (i + 1) * buttonWidth;
        UIImageView *imageView = self.divides[i];
        imageView.size = CGSizeMake(divideWidth, divideHeight);
        imageView.center = CGPointMake(divideX, self.height * 0.5);
    }
}

/** 设置toolbar按钮数据 */
- (void) setupToolBarButton {
    HVWStatus *status = self.toolbarFrame.status;
    
    // 转发
    [self setupButtonTitle:self.repostButton withOriginalTitle:@"转发" titleCount:status.reposts_count];
    
    // 评论
    [self setupButtonTitle:self.commentButton withOriginalTitle:@"评论" titleCount:status.comments_count];
    
    // 点赞
    [self setupButtonTitle:self.attitudeButton withOriginalTitle:@"赞" titleCount:status.attitudes_count];
}

/** 设置按钮标题 */
- (void) setupButtonTitle:(UIButton *) button withOriginalTitle:(NSString *)buttonTitle titleCount:(int)titleCount {
    // 当数量超过1万的时候，使用“万”作为单位
    if (titleCount >= 10000) {
        buttonTitle = [NSString stringWithFormat:@"%.1f万", (titleCount / 10000.0)];
        buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@".0" withString:@""]; // 去除".0"小数
    } else if (titleCount) {
        buttonTitle = [NSString stringWithFormat:@"%d", titleCount];
    }
    
    [button setTitle:buttonTitle forState:UIControlStateNormal];
}


@end
