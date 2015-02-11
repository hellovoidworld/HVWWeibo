//
//  HVWTabBarViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWTabBarViewController.h"
#import "HVWHomeViewController.h"
#import "HVWMessageViewController.h"
#import "HVWDiscoverViewController.h"
#import "HVWProfileViewController.h"
#import "HVWNavigationViewController.h"
#import "HVWTabBar.h"
#import "HVWComposeViewController.h"
#import "HVWUnreadCountTool.h"
#import "HVWUnreadCountParam.h"
#import "HVWAccountInfoTool.h"
#import "HVWAccountInfo.h"

@interface HVWTabBarViewController () <HVWTabBarDelegate>

/** 首页控制器 */
@property(nonatomic, strong) HVWHomeViewController *homeVC;

/** 消息控制器 */
@property(nonatomic, strong) HVWMessageViewController *messageVC;

/** 发现控制器 */
@property(nonatomic, strong) HVWDiscoverViewController *discoverVC;

/** 我控制器 */
@property(nonatomic, strong) HVWProfileViewController *profileVC;

/** 上一次选择的tabBarItem */
@property(nonatomic, strong) UITabBarItem *lastSelectedTabBarItem;

@end

@implementation HVWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 使用自定义的TabBar
    HVWTabBar *hvwTabBar = [[HVWTabBar alloc] init];
    hvwTabBar.hvwTabBarDelegate = self;
    // 重设tabBar，由于tabBar是只读成员，使用KVC相当于直接修改_tabBar
    [self setValue:hvwTabBar forKey:@"tabBar"];
    
    // 添加子控制器
    [self addAllChildViewControllers];
    
    // 设置未读消息获取
    [self setupUnreadCount];
}

/** 添加所有子控制器 */
- (void) addAllChildViewControllers {
    // 首页
    HVWHomeViewController *homeVC = [[HVWHomeViewController alloc] init];
    [self addChildViewController:homeVC WithTitle:@"首页" image:@"tabbar_home" seletectedImage:@"tabbar_home_selected"];
    self.homeVC = homeVC;
    
    // 打开app，设置首页为上一次选择的tabBarItem
    self.lastSelectedTabBarItem = homeVC.tabBarItem;
    
    // 消息
    HVWMessageViewController *messageVC = [[HVWMessageViewController alloc] init];
    [self addChildViewController:messageVC WithTitle:@"消息" image:@"tabbar_message_center" seletectedImage:@"tabbar_message_center_selected"];
    self.messageVC = messageVC;
    
    // 发现
    HVWDiscoverViewController *discoverVC = [[HVWDiscoverViewController alloc] init];
    [self addChildViewController:discoverVC WithTitle:@"发现" image:@"tabbar_discover" seletectedImage:@"tabbar_discover_selected"];
    self.discoverVC = discoverVC;
    
    // 我
    HVWProfileViewController *profileVC = [[HVWProfileViewController alloc] init];
    [self addChildViewController:profileVC WithTitle:@"我" image:@"tabbar_profile" seletectedImage:@"tabbar_profile_selected"];
    self.profileVC = profileVC;
}

/** 添加tab子控制器 */
- (void) addChildViewController:(UIViewController *) viewController WithTitle:(NSString *) title image:(NSString *) imageName seletectedImage:(NSString *) selectedImageName {
    
    // 设置随机背景色
//    viewController.view.backgroundColor = RandomColor;
    
    // 设置标题，直接设置title可以同时设置tabBarItem和navigationItem的title
//    viewController.tabBarItem.title = title;
//    viewController.navigationItem.title = title;
    viewController.title = title;
    
    // 设置图标
    viewController.tabBarItem.image = [UIImage imageWithNamed:imageName];
    
    // 被选中时图标
    UIImage *selectedImage = [UIImage imageWithNamed:selectedImageName];
    // 如果是iOS7，不要渲染被选中的tab图标（iOS7中会自动渲染成为蓝色）
    if (iOS7) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    viewController.tabBarItem.selectedImage = selectedImage;
    
    // 添加子控制器
    HVWNavigationViewController *nav = [[HVWNavigationViewController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

#pragma mark - HVWTabBarDelegate
/** “+”按钮点击代理方法 */
- (void)tabBarDidComposeButtonClick:(HVWTabBar *)tabBar {
    HVWComposeViewController *composeView = [[HVWComposeViewController alloc] init];
  
    // tabBarController不是由navigationController弹出来的，没有navigationController
//    [self.navigationController pushViewController:vc animated:YES];
//    HVWLog(@"%@", self.navigationController); // null
    
    // 为了使用导航栏，使用NavigationController包装一下
    HVWNavigationViewController *nav = [[HVWNavigationViewController alloc] initWithRootViewController:composeView];
    // 使用modal方式弹出
    [self presentViewController:nav animated:YES completion:nil];
}

/** 选中了某个tabBarItem */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // 如果是首页
    UINavigationController *nav = (UINavigationController *)self.selectedViewController;
    
    if ([[nav.viewControllers firstObject] isKindOfClass:[HVWHomeViewController class]]) { // 如果是“首页”item被点击
        if (self.lastSelectedTabBarItem == item) { // 重复点击
            [self.homeVC refreshStatusFromAnother:NO];
        } else { // 跳转点击
            [self.homeVC refreshStatusFromAnother:YES];
        }
    } else {
//        item.badgeValue = nil;
    }
    
}

#pragma mark - unread count
/** 设置未读消息获取 */
- (void) setupUnreadCount {
    // 第一次要先获取一次
    [self fetchUnreadCount];
    
    // 设置定时器,每隔一段时间获取一次
    NSTimer *unreadTimer =  [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(fetchUnreadCount) userInfo:nil repeats:YES];
    
    // 要设置系统分配资源，不然用户操作的时候会阻塞
    [[NSRunLoop mainRunLoop] addTimer:unreadTimer forMode:NSRunLoopCommonModes];
}

/** 设置刷新未读消息定时任务 */
- (void) fetchUnreadCount {
    // 设置参数
    HVWUnreadCountParam *param = [[HVWUnreadCountParam alloc] init];
    param.uid = [HVWAccountInfoTool accountInfo].uid.intValue;
    
    
    // 发送请求
    [HVWUnreadCountTool unreadCountWithParameters:param success:^(HVWUnreadCountResult *result) {
//        HVWLog(@"现在有%d未读消息", [result totalUnreadCount]);
        // 未读"微博"数
        if (result.status) {
            self.homeVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        } else {
            self.homeVC.tabBarItem.badgeValue = nil;
        }
        
        // 未读"消息"数
        if ([result messageUnreadCount]) {
            self.messageVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [result messageUnreadCount]];
        } else {
            self.messageVC.tabBarItem.badgeValue = nil;
        }
        
        // 未读"发现"数
        if ([result discoverUnreadCount]) {
            self.discoverVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [result discoverUnreadCount]];
        } else {
            self.discoverVC.tabBarItem.badgeValue = nil;
        }
        
        // 未读“我”数
        if ([result profileUnreadCount]) {
            self.profileVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [result profileUnreadCount]];
        } else {
            self.profileVC.tabBarItem.badgeValue = nil;
        }
        
        // 设置app图标，(iOS8或以上要先获得授权,在AppDelegate里面做了) 
        [UIApplication sharedApplication].applicationIconBadgeNumber = [result totalUnreadCount];
    } failure:^(NSError *error) {
        HVWLog(@"获取未读消息数失败,error:%@", error);
    }];
}

@end
