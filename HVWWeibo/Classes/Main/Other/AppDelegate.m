//
//  AppDelegate.m
//  UIWebViewdDemo
//
//  Created by hellovoidworld on 15/1/30.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "AppDelegate.h"
#import "HVWTabBarViewController.h"
#import "HVWNewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 启动后显示状态栏
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarHidden = NO;
    
    // 设置window
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
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
        self.window.rootViewController = newFeatureVC;
    } else {
        // 创建根控制器
        HVWTabBarViewController *tabVC = [[HVWTabBarViewController alloc] init];
        self.window.rootViewController = tabVC;
    }

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
