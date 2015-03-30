//
//  HVWComposeEmotionKeyboard.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionKeyboard.h"
#import "HVWComposeEmotionKeyboardToolBar.h"
#import "HVWComposeEmotionGridView.h"
#import "HVWEmotionTool.h"
#import "HVWEmotion.h"

@interface HVWComposeEmotionKeyboard() <HVWComposeEmotionKeyboardToolBarDelegate>

/** 工具条 */
@property(nonatomic, weak) HVWComposeEmotionKeyboardToolBar *toolbar;

/** 装载表情view */
@property(nonatomic, weak) HVWComposeEmotionGridView *gridView;

/** 默认表情 */
@property(nonatomic, strong) NSArray *defaultEmotions;

/** emoji表情 */
@property(nonatomic, strong) NSArray *emojiEmotions;

/** 浪小花表情 */
@property(nonatomic, strong) NSArray *lxhEmotions;

/** 最近表情 */
@property(nonatomic, strong) NSMutableArray *recentEmotions;

@end

@implementation HVWComposeEmotionKeyboard

/** 加载默认表情 */
- (NSArray *)defaultEmotions {
    if (nil == _defaultEmotions) {
        _defaultEmotions = [HVWEmotionTool defaultEmotions];
    }
    return _defaultEmotions;
}

/** 加载emoji表情 */
- (NSArray *)emojiEmotions {
    if (nil == _emojiEmotions) {
        _emojiEmotions = [HVWEmotionTool emojiEmotions];
    }
    return _emojiEmotions;
}

/** 加载浪小花表情 */
- (NSArray *)lxhEmotions {
    if (nil == _lxhEmotions) {
        _lxhEmotions = [HVWEmotionTool lxhEmotions];
    }
    return _lxhEmotions;
}

/** 最近表情 */
- (NSMutableArray *)recentEmotions {
    if (nil == _recentEmotions) {
        _recentEmotions = [HVWEmotionTool recentEmotions];
    }
    return _recentEmotions;
}

/** 实例化 */
+ (instancetype) keyboard {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 配置toolbar
        [self setupToolbar];
        
        // 配置gridView
        [self setupGridView];
    }
    return self;
}

/** 配置toolbar */
- (void) setupToolbar {
    HVWComposeEmotionKeyboardToolBar *toolbar = [HVWComposeEmotionKeyboardToolBar toolBar];
    toolbar.delegate = self;
    [self addSubview:toolbar];
    self.toolbar = toolbar;
}

/** 配置gridView */
- (void) setupGridView {
    HVWComposeEmotionGridView *gridView = [[HVWComposeEmotionGridView alloc] init];
    [self addSubview:gridView];
    self.gridView = gridView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 工具条
    CGFloat toolbarWidth = self.width;
    CGFloat toolbarHeight = 35;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.height - toolbarHeight;
    self.toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarWidth, toolbarHeight);
    
    // gridView
    CGFloat gridViewWidth = self.width;
    CGFloat gridViewHeight = self.height - toolbarHeight;
    CGFloat gridViewX = 0;
    CGFloat gridViewY = 0;
    self.gridView.frame = CGRectMake(gridViewX, gridViewY, gridViewWidth, gridViewHeight);
    
    // 默认选择“默认“表情
    self.gridView.emotions = self.defaultEmotions;
}

#pragma mark - HVWComposeEmotionKeyboardToolBarDelegate
- (void)emotionKeyboardToolbarDidButtonClicked:(HVWComposeEmotionKeyboardToolBar *)toolbar emotionType:(HVWEmotionType)emotionType {
        switch (emotionType) {
            case HVWEmotionTypeRecent:
                self.gridView.emotions = self.recentEmotions;
                break;
    
            case HVWEmotionTypeDefault:
                self.gridView.emotions = self.defaultEmotions;
                break;
    
            case HVWEmotionTypeEmoji:
                self.gridView.emotions = self.emojiEmotions;
                break;
    
            case HVWEmotionTypeLxh:
                self.gridView.emotions = self.lxhEmotions;
                break;
                
            default:
                break;
        }
}

@end
