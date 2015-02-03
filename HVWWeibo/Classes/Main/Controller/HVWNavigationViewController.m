//
//  HVWNavigationViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWNavigationViewController.h"

@interface HVWNavigationViewController ()

@end

@implementation HVWNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 重写push方法 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果不是根控制器，隐藏TabBar
    if (self.viewControllers.count > 0) {
        // 注意这里不是self（navigationController），是push出来的ViewContoller隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 加上“返回上一层”按钮和“直接回到根控制器”按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" hightlightedImage:@"navigationbar_back_highlighted" target:self selector:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" hightlightedImage:@"navigationbar_more_highlighted" target:self selector:@selector(more)];
    }
    
    // 最后一定要调用父类的方法
    [super pushViewController:viewController animated:animated];
}

/** 返回上一层 */
- (void) back {
    [self popViewControllerAnimated:YES];
}

/** 返回根控制器 */
- (void) more {
    [self popToRootViewControllerAnimated:YES];
}

/** 类初始化的时候调用 */
+ (void)initialize {
    // 初始化导航栏样式
    [self initNavigationBarTheme];
    
    // 初始化导航栏item样式
    [self initBarButtonItemTheme];
}

/** 统一设置导航栏样式 */
+ (void) initNavigationBarTheme {
    // 使用appearence（主题）设置，统一修改所有导航栏样式
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 为了统一iOS6和iOS7，iOS6需要设置导航栏背景来模拟iOS7的效果
    if (!iOS7) {
        [appearance setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // 设置属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    // 设置字体
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    // 消去文字阴影，设置阴影偏移为0
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    attr[NSShadowAttributeName] = shadow;
    
    [appearance setTitleTextAttributes:attr];
}

/** 统一设置导航栏item的样式 
 * 因为是通过主题appearence统一修改所有NavivationBar的样式，可以使用类方法
 */
+ (void) initBarButtonItemTheme {
    // 设置导航栏，修改所有UINavigationBar的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    // 设置noraml状态下的样式
    NSMutableDictionary *normalTextAttr = [NSMutableDictionary dictionary];
    // 字体大小
    normalTextAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    // 字体颜色
    normalTextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 设置为normal样式
    [appearance setTitleTextAttributes:normalTextAttr forState:UIControlStateNormal];
    
    // 设置highlighted状态下的样式
    NSMutableDictionary *highlightedTextAttr = [NSMutableDictionary dictionaryWithDictionary:normalTextAttr];
    // 字体颜色
    highlightedTextAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    // 设置为normal样式
    [appearance setTitleTextAttributes:highlightedTextAttr forState:UIControlStateHighlighted];
    
    // 设置disabled状态下的样式
    NSMutableDictionary *disabledTextAttr = [NSMutableDictionary dictionaryWithDictionary:normalTextAttr];
    // 字体颜色
    disabledTextAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    // 设置为normal样式
    [appearance setTitleTextAttributes:disabledTextAttr forState:UIControlStateDisabled];
    
}

@end
