//
//  HVWHomeViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWHomeViewController.h"

@interface HVWHomeViewController ()

@end

@implementation HVWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加导航控制器按钮
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" hightlightedImage:@"navigationbar_friendsearch_highlighted" target:self selector:@selector(searchFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" hightlightedImage:@"navigationbar_pop_highlighted" target:self selector:@selector(pop)];
}

#pragma mark - UITableVidwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"首页cell - %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
/** 测试方法，点击cell创建一个UIViewController并push出来 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = RandomColor;
    vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    // 特别定制第0行
    if (0 == indexPath.row) {
        NSString *jumpTitle = @"跳转到另一个界面";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 100, 200, 40);
        [button setTitle:jumpTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
        [vc.view addSubview:button];
    }

    [self.navigationController pushViewController:vc animated:YES];
}

/** 测试用跳转 */
- (void) jump {
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = RandomColor;
    vc2.title = @"跳转到的界面";
    [self.navigationController pushViewController:vc2 animated:YES];
}

/** 左边导航栏按钮事件 */
- (void) searchFriend {
    HVWLog(@"searchFriend");
}

/** 右边导航栏按钮事件 */
- (void) pop {
    HVWLog(@"pop");
}

@end
