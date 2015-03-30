//
//  HVWComposeToolBar.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/7.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HVWComposeToolBarButtonTagCamera, // 照相机
    HVWComposeToolBarButtonTagPhotoLib, // 相册
    HVWComposeToolBarButtonTagMention, // 提到@
    HVWComposeToolBarButtonTagTrend, // 话题
    HVWComposeToolBarButtonTagEmotion // 表情
} HVWComposeToolBarButtonTag;

@class HVWComposeToolBar;
@protocol HVWComposeToolBarDelegate <NSObject>

@optional
- (void) composeToolBar:(HVWComposeToolBar *) composeToolBar didButtonClicked:(HVWComposeToolBarButtonTag) tag;

@end

@interface HVWComposeToolBar : UIView

/** 代理 */
@property(nonatomic, weak) id<HVWComposeToolBarDelegate> delegate;

/** 修改表情按钮配图 */
- (void) changeEmotionIcon:(BOOL)openEmotion;

@end
