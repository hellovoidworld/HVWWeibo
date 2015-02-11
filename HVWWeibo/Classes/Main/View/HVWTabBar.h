//
//  HVWTabBar.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HVWTabBar;
@protocol HVWTabBarDelegate <UITabBarDelegate>

@optional
- (void) tabBarDidComposeButtonClick:(HVWTabBar *) tabBar;

@end

@interface HVWTabBar : UITabBar

/** 代理，由于tabBar原来就有一个delegate，必须区分开来 */
@property(nonatomic, weak) id<HVWTabBarDelegate> hvwTabBarDelegate;

@end
