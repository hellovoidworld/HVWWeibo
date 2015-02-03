//
//  HVWPopMenu.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/2.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWPopMenu.h"

@implementation HVWPopMenu

#pragma mark - 初始化方法
- (instancetype) initWithContentView:(UIView *) contentView {
    if (self = [super init]) {
        self.contentView = contentView;
    }
    
    return self;
}

+ (instancetype) popMenuWithContentView:(UIView *) contentView {
    return [[self alloc] initWithContentView:contentView];
}

/** 初始化子控件 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 中间辅助覆盖层（帮助隐藏弹出框）
        UIButton *coverLayer = [UIButton buttonWithType:UIButtonTypeCustom];
        self.coverLayer = coverLayer;
        [self setDimCoverLayer:YES];
        [coverLayer addTarget:self action:@selector(coverLayerClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverLayer];
        
        // 添加背景容器
        UIImageView *backgroundContainer = [[UIImageView alloc] init];
        self.backgroundContainer = backgroundContainer;
        backgroundContainer.userInteractionEnabled = YES;
        [self setPopMenuArrowDirection:PopMenuArrowDirectionMid];
        [self addSubview:backgroundContainer];
    }
    
    return self;
}

/** 遮盖夹层点击事件 */
- (void) coverLayerClicked {
    [self hideMenu];
}

#pragma mark - 使用方法
/** 弹出 */
- (void) showMenuInRect:(CGRect) rect {
    // 准备添加到当前主窗口上
    UIView *window = [[UIApplication sharedApplication] keyWindow];
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.coverLayer.frame = window.bounds;
    self.backgroundContainer.frame = rect;
    
    // 添加内容控件
    if (self.contentView) {
        CGFloat topMargin = 12;
        CGFloat leftMargin = 5;
        CGFloat bottomMargin = 8;
        CGFloat rightMargin = 5;
        
        self.contentView.x = leftMargin;
        self.contentView.y = topMargin;
        self.contentView.width = self.backgroundContainer.width - leftMargin - rightMargin;
        self.contentView.height = self.backgroundContainer.height - topMargin - bottomMargin;
        
        [self.backgroundContainer addSubview:self.contentView];
    }
}

/** 隐藏 */
- (void) hideMenu {
    if ([self.delegate respondsToSelector:@selector(popMenuDidHideMenu:)]) {
        [self.delegate popMenuDidHideMenu:self];
    }
    
    [self removeFromSuperview];
}

#pragma mark - 特性设置
/** 设置遮盖夹层是否透明 */
- (void)setDimCoverLayer:(BOOL)dimCoverLayer {
    if (dimCoverLayer) { // 需要半透明模糊效果的
        self.coverLayer.backgroundColor = [UIColor blackColor];
        self.coverLayer.alpha = 0.2;
    } else { // 全透明
        self.coverLayer.backgroundColor = [UIColor clearColor];
        self.coverLayer.alpha = 1.0;
    }
}


/** 设置弹出菜单顶部箭头位置：左、中、右 */
- (void)setPopMenuArrowDirection:(PopMenuArrowDirection) popMenuArrowDirection {
    _popMenuArrowDirection = popMenuArrowDirection;
    
    switch (popMenuArrowDirection) {
        case PopMenuArrowDirectionLeft:
            self.backgroundContainer.image = [UIImage resizedImage:@"popover_background_left"];
            break;
        case PopMenuArrowDirectionMid:
            self.backgroundContainer.image = [UIImage resizedImage:@"popover_background"];
            break;
        case PopMenuArrowDirectionRight:
            self.backgroundContainer.image = [UIImage resizedImage:@"popover_background_right"];
            break;
        default:
            break;
    }
}

@end
