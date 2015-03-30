//
//  HVWComposeEmotionKeyboardToolBar.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionKeyboardToolBar.h"

#define HVWEmotionToolbarButtonMaxCount 4

@interface HVWComposeEmotionKeyboardToolBar()

/** 按钮数组 */
@property(nonatomic, strong) NSMutableArray *buttons;

@end


@implementation HVWComposeEmotionKeyboardToolBar

- (NSMutableArray *)buttons {
    if (_buttons == nil ) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

/** 实例化 */
+ (instancetype) toolBar {
    return [[self alloc] init];
}

/** 通过代码创建的初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 配置按钮
        [self setupButtons];
    }
    return self;
}

/** 配置按钮 */
- (void) setupButtons {
    // “最近"
    [self setupButton:@"最近" tag:HVWEmotionTypeRecent];
    
    // “默认”
    [self setupButton:@"默认" tag:HVWEmotionTypeDefault];
    
    // “Emoji”
    [self setupButton:@"Emoji" tag:HVWEmotionTypeEmoji];
    
    // “浪小花”
    [self setupButton:@"浪小花" tag:HVWEmotionTypeLxh];
}

/** 配置单个按钮 */
- (void) setupButton:(NSString *)title tag:(HVWEmotionType)tag {
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    
    // 点击事件
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    // 背景图
    int count = self.subviews.count;
    if (count == 1) { // 第一个
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
        
    } else if (count == HVWEmotionToolbarButtonMaxCount) { // 最后一个
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
        
    } else { // 中间的
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
}

/** 点击按钮 */
- (void) buttonClicked:(UIButton *)button {
    HVWEmotionType emotionType = button.tag;
    
    if ([self.delegate respondsToSelector:@selector(emotionKeyboardToolbarDidButtonClicked:emotionType:)]) {
        [self.delegate emotionKeyboardToolbarDidButtonClicked:self emotionType:emotionType];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonWidth = self.width / HVWEmotionToolbarButtonMaxCount;
        CGFloat buttonHeight = self.height;
        CGFloat buttonX = buttonWidth * i;
        CGFloat buttonY = 0;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
}

@end
