//
//  HVWTabBar.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWTabBar.h"

@implementation HVWTabBar

- (void)layoutSubviews {
    // 切记一定要调用父类的方法!!!
    [super layoutSubviews];
    
    // 设置文本属性
    [self initTextAttr];
    
    // 设置BarButton的位置
    [self initBarButtonPosition];

    // 添加"+"按钮
    [self addComposeButton];
}

/** 设置文本属性 */
- (void) initTextAttr {
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    for (UITabBarItem *item in self.items) {
        // 设置字体颜色
        [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    }
}

/** 设置BarButton的位置 */
- (void) initBarButtonPosition {
    
    // 创建一个位置所以，用来定位
    int index = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 计算尺寸，预留一个“+”号空间
            CGFloat width = self.width / (self.items.count + 1);
            tabBarButton.width = width;
            
            // 计算位置
            if (index < (int)(self.items.count / 2)) {
                tabBarButton.x = width * index;
            } else {
                tabBarButton.x = width * (index + 1);
            }
            
            index++;
        }
    }
}

/** 添加"+"按钮 */
- (void) addComposeButton {
    // 初始化按钮
    UIButton *composeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [composeButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [composeButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [composeButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [composeButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    // 设置位置尺寸
    CGFloat width = self.width / (self.items.count + 1);
    CGFloat height = self.height;
    CGFloat x = (self.items.count / 2) * width;
    CGFloat y = 0;
    composeButton.frame = CGRectMake(x, y, width, height);
    
    // 监听事件
    [composeButton addTarget:self action:@selector(composeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到tabBar上
    [self addSubview:composeButton];
}

/** “+"按钮点击事件 */
- (void) composeButtonClicked {
    if ([self.hvwTabBarDelegate respondsToSelector:@selector(tabBarDidComposeButtonClick:)]) {
        [self.hvwTabBarDelegate tabBarDidComposeButtonClick:self];
    }
}

@end
