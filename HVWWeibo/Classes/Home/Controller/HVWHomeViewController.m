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
#import "AFNetworking.h"
#import "HVWAccountInfoTool.h"
#import "HVWAccountInfo.h"
#import "HVWStatus.h"
#import "HVWUser.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

@interface HVWHomeViewController () <HVWPopMenuDelegate, UITableViewDataSource, UITableViewDelegate>

/** 导航栏标题按钮展开标识 */
@property(nonatomic, assign, getter=isTitleButtonExtended) BOOL titleButtonExtended;

/** 微博数据 */
@property(nonatomic, strong) NSArray *statuses;

@end

@implementation HVWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 加载微博数据
    [self loadWeiboData];
}

/** 设置导航栏 */
- (void) setupNavigationBar {
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

/** 加载微博数据 */
- (void) loadWeiboData {
    // 创建AFNetworking的http操作中管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [HVWAccountInfoTool accountInfo].access_token;
    
    // 发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        HVWLog(@"获取微博数据成功-------%@", responseObject);
        
        // 保存数据到内存
        NSArray *dataArray = responseObject[@"statuses"];
        
        // 使用MJExtension直接进行字典-模型转换
        self.statuses = [HVWStatus objectArrayWithKeyValuesArray:dataArray];
        
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HVWLog(@"获取微博数据失败------%@", error);
    }];
}

#pragma mark - UITableVidwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    HVWStatus *status = self.statuses[indexPath.row];
    HVWUser *user = status.user;
    
    // 加载内容
    cell.textLabel.text = status.text;
    // 作者
    cell.detailTextLabel.text = user.name;
    // 作者头像
    NSString *imageUrlStr = user.profile_image_url;
    [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageWithNamed:@"avatar_default_small"]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
/** 测试方法，点击cell创建一个UIViewController并push出来 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/** 左边导航栏按钮事件 */
- (void) searchFriend {
    HVWLog(@"searchFriend");
}

/** 右边导航栏按钮事件 */
- (void) pop {
    HVWLog(@"pop");
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
