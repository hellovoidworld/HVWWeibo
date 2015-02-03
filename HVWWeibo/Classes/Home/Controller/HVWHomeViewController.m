//
//  HVWHomeViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWHomeViewController.h"
#import "HVWNavigationBarTitleButton.h"
#import "HVWPopMenu.h"

@interface HVWHomeViewController () <HVWPopMenuDelegate>

@property(nonatomic, assign, getter=isTitleButtonExtended) BOOL titleButtonExtended;

@end

@implementation HVWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加导航控制器按钮
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" hightlightedImage:@"navigationbar_friendsearch_highlighted" target:self selector:@selector(searchFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" hightlightedImage:@"navigationbar_pop_highlighted" target:self selector:@selector(pop)];
    
    // 设置标题按钮
    HVWNavigationBarTitleButton *titleButton = [[HVWNavigationBarTitleButton alloc] init];
    titleButton.height = 35;
    titleButton.width = 100;
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 设置背景图片
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 监听按钮点击事件，替换图标
    [titleButton addTarget:self action:@selector(titleButtonClickd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
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
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    HVWLog(@"-----%@", [defaults objectForKey:@"test"]);
//    [defaults setObject:@"kkkkkkk" forKey:@"test"];
//    [defaults synchronize];
}

/** 标题栏按钮点击事件 */
- (void) titleButtonClickd:(UIButton *) button {
    self.titleButtonExtended = !self.titleButtonExtended;
    
    if (self.isTitleButtonExtended) {
        [button setImage:[UIImage imageWithNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        
        // 添加弹出菜单
        UITableView *tableView = [[UITableView alloc] init];
        HVWPopMenu *popMenu = [HVWPopMenu popMenuWithContentView:tableView];
        popMenu.delegate = self;
        popMenu.dimCoverLayer = YES; // 模糊遮盖
        popMenu.popMenuArrowDirection = PopMenuArrowDirectionMid; // 中部箭头
        
        // 弹出
        [popMenu showMenuInRect:CGRectMake(50, 55, 200, 300)];
        
    } else {
        [button setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}

#pragma mark - HVWPopMenuDelegate
- (void)popMenuDidHideMenu:(HVWPopMenu *)popMenu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [self titleButtonClickd:titleButton];
}

@end
