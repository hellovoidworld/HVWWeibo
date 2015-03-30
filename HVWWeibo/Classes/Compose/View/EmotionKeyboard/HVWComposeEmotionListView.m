//
//  HVWComposeEmotionListView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionListView.h"
#import "HVWComposeEmotionButton.h"
#import "HVWEmotionTool.h"
#import "HVWComposeEmotionPopView.h"

@interface HVWComposeEmotionListView()

/** 删除按钮 */
@property(nonatomic, weak) UIButton *deleteButton;

/** 所有表情按钮 */
@property(nonatomic, strong) NSArray *emotionButtons;

/** 表情弹窗 */
@property(nonatomic, strong) HVWComposeEmotionPopView *popView;

@end

@implementation HVWComposeEmotionListView

- (HVWComposeEmotionPopView *)popView {
    if (nil == _popView) {
        _popView = [HVWComposeEmotionPopView popView];
    }
    return _popView;
}

/** 配置表情 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    // 添加删除按钮
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setImage:[UIImage imageWithNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [deleteButton setImage:[UIImage imageWithNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    self.deleteButton = deleteButton;
    
    // 初始化所有表情按钮
    NSMutableArray *emotionButtons = [NSMutableArray array];
    for (int i=0; i<emotions.count; i++) {
        HVWComposeEmotionButton *emotionButton = [[HVWComposeEmotionButton alloc] init];
        
        // 点击事件
        [emotionButton addTarget:self action:@selector(emotionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        HVWEmotion *emotion = emotions[i];
        emotionButton.emotion = emotion;
        
        [self addSubview:emotionButton];
        [emotionButtons addObject:emotionButton];
    }
    self.emotionButtons = emotionButtons;
    
    // 长按手势
    UILongPressGestureRecognizer *rec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(emotionButtonLongPressed:)];
    // 注意是添加到listView上，不是button
    [self addGestureRecognizer:rec];
    
    // 刷新布局
    [self setNeedsLayout];
}

/** 布局子控件 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 布局所有表情按钮
    CGFloat emotionButtonWidth = self.width / ComposeEmotionColumnCount;
    CGFloat emotionButtonHeight = self.height / ComposeEmotionRowCount;
    for (int i=0; i<self.emotionButtons.count; i++) {
        UIButton *emotionButton = self.emotionButtons[i];
        CGFloat emotionButtonX = (i % ComposeEmotionColumnCount) * emotionButtonWidth;
        CGFloat emotionButtonY = (i / ComposeEmotionColumnCount) * emotionButtonHeight;
        emotionButton.frame = CGRectMake(emotionButtonX, emotionButtonY, emotionButtonWidth, emotionButtonHeight);
    }
    
    // 删除按钮
    CGFloat deleteButtonWidth = emotionButtonWidth;
    CGFloat deleteButtonHeight = deleteButtonWidth;
    CGFloat deleteButtonX = self.width - deleteButtonWidth;
    CGFloat deleteButtonY = self.height - deleteButtonHeight;
    self.deleteButton.frame = CGRectMake(deleteButtonX, deleteButtonY, deleteButtonWidth, deleteButtonHeight);
}

/** 选择一个表情 */
- (void) selectAnEmotion:(HVWComposeEmotionButton *)button {
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:HVWComposeEmotionSelectedNotification object:nil userInfo:@{@"emotion":button.emotion}];
}

/** 表情按钮点击事件 */
- (void) emotionButtonClicked:(HVWComposeEmotionButton *)button {
    // 添加到“最近“表情面板
    [HVWEmotionTool addRecentEmotions:button.emotion];
    
    // 弹出弹窗
    [self.popView popEmotion:button];
    
    // 选择一个表情
    [self selectAnEmotion:button];
    
    // 延迟一定时间后，隐蔽弹窗
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
}

/** 表情被长按手势事件 */
- (void) emotionButtonLongPressed:(UIGestureRecognizer *)rec {
    // 捕获触摸点
    CGPoint touchedPoint = [rec locationInView:rec.view];
    // 点击到的表情按钮
    HVWComposeEmotionButton *emotionButton = [self emotionButtonInPoint:touchedPoint];
    
    // 判断状态
    if (emotionButton && emotionButton.hidden == NO) {
        if (rec.state == UIGestureRecognizerStateEnded) { // 结束触摸
            [self selectAnEmotion:emotionButton];
            // 隐藏弹窗
            [self.popView dismiss];
            
        } else { // 弹出弹窗
            [self.popView popEmotion:emotionButton];
        }
    } else {
        if (rec.state == UIGestureRecognizerStateEnded) {
            [self.popView dismiss];
        }
    }
}

/** 在某个点上的表情按钮 */
- (HVWComposeEmotionButton *) emotionButtonInPoint:(CGPoint)point {
    for (HVWComposeEmotionButton *emotionButton in self.emotionButtons) {
        if (CGRectContainsPoint(emotionButton.frame, point)) {
            return emotionButton;
        }
    }
    return nil;
}

/** 点击“删除”按钮 */
- (void) deleteButtonClicked:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:HVWComposeEmotionDeletedNotification object:nil];
}

@end
