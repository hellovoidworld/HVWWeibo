//
//  HVWComposeViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeViewController.h"

@interface HVWComposeViewController ()

@end

@implementation HVWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化一些功能按钮
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"+号弹出控制器";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
