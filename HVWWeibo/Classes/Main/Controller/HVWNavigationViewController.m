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

@end
