//
//  HVWControllerTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWControllerTool.h"
#import "HVWOAuthViewController.h"
#import "HVWTabBarViewController.h"
#import "HVWNewFeatureViewController.h"
#import "HVWAccountInfoTool.h"
#import "HVWAccountInfo.h"

@implementation HVWControllerTool

+ (void) chooseRootViewController {
    // 获得主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 检查是否已有登陆账号
    HVWAccountInfo *accountInfo = [HVWAccountInfoTool accountInfo];
    
    if (!accountInfo) { // 如果不存在登陆账号，要先进行授权
        window.rootViewController = [[HVWOAuthViewController alloc] init];
    } else {
        /** 新版本特性 */
        // app现在的版本
        // 由于使用的时Core Foundation的东西，需要桥接
        NSString *versionKey = (__bridge NSString*) kCFBundleVersionKey;
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDic objectForKey:versionKey];
        
        // 上次使用的版本
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [defaults stringForKey:versionKey];
        
        // 如果版本变动了，存储新的版本号并启动新版本特性图
        if (![lastVersion isEqualToString:currentVersion]) {
            
            // 存储
            [defaults setObject:currentVersion forKey:versionKey];
            [defaults synchronize];
            
            // 开启app显示新特性
            HVWNewFeatureViewController *newFeatureVC = [[HVWNewFeatureViewController alloc] init];
            window.rootViewController = newFeatureVC;
        } else {
            // 创建根控制器
            HVWTabBarViewController *tabVC = [[HVWTabBarViewController alloc] init];
            window.rootViewController = tabVC;
        }
    }
}

@end
