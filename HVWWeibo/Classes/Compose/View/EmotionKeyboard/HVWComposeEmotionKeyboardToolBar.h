//
//  HVWComposeEmotionKeyboardToolBar.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HVWEmotionTypeRecent,
    HVWEmotionTypeDefault,
    HVWEmotionTypeEmoji,
    HVWEmotionTypeLxh
} HVWEmotionType;

@class HVWComposeEmotionKeyboardToolBar;
@protocol HVWComposeEmotionKeyboardToolBarDelegate <NSObject>

/** 点击tabToolBar */
@optional
- (void) emotionKeyboardToolbarDidButtonClicked:(HVWComposeEmotionKeyboardToolBar *) toolbar emotionType:(HVWEmotionType)emotionType;

@end

@interface HVWComposeEmotionKeyboardToolBar : UIView

/** 代理 */
@property(nonatomic, weak) id<HVWComposeEmotionKeyboardToolBarDelegate> delegate;

/** 实例化 */
+ (instancetype) toolBar;

@end
