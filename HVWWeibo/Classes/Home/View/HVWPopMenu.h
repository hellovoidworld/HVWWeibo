//
//  HVWPopMenu.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/2.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PopMenuArrowDirectionLeft,
    PopMenuArrowDirectionMid,
    PopMenuArrowDirectionRight
} PopMenuArrowDirection;

@class HVWPopMenu;
@protocol HVWPopMenuDelegate <NSObject>

@optional
- (void) popMenuDidHideMenu:(HVWPopMenu *) popMenu;

@end

@interface HVWPopMenu : UIView

/** 背景兼内容容器 */
@property(nonatomic, strong) UIImageView *backgroundContainer;

#pragma mark - 成员属性
/** 遮盖夹层 */
@property(nonatomic, strong) UIButton *coverLayer;

/** 内容控件 */
@property(nonatomic, strong) UIView *contentView;

/** 箭头位置 */
@property(nonatomic, assign) PopMenuArrowDirection popMenuArrowDirection;

/** 遮盖夹层透明标识 */
@property(nonatomic, assign, getter=isDimCoverLayer) BOOL dimCoverLayer;

/** 代理 */
@property(nonatomic, weak) id<HVWPopMenuDelegate> delegate;


#pragma mark - 初始化方法
- (instancetype) initWithContentView:(UIView *) contentView;
+ (instancetype) popMenuWithContentView:(UIView *) contentView;

#pragma mark - 使用方法
/** 弹出 */
- (void) showMenuInRect:(CGRect) rect;

/** 隐藏 */
- (void) hideMenu;


@end
