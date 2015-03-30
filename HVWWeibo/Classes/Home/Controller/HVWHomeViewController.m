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
#import "HVWAccountInfoTool.h"
#import "HVWAccountInfo.h"
#import "HVWStatus.h"
#import "HVWUser.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "HVWLoadMoreWeiboFooterView.h"
#import "HVWStatusTool.h"
#import "HVWHomeStatusParam.h"
#import "HVWHomeStatusResult.h"
#import "HVWUserTool.h"
#import "HVWUserParam.h"
#import "HVWStatusCell.h"
#import "HVWStatusFrame.h"
#import "HVWRegexTool.h"
#import "HVWStatusLink.h"
#import "HVWRegexTool.h"

@interface HVWHomeViewController () <HVWPopMenuDelegate, UITableViewDataSource, UITableViewDelegate>

/** 导航栏标题按钮展开标识 */
@property(nonatomic, assign, getter=isTitleButtonExtended) BOOL titleButtonExtended;

/** 微博frame数组，包含所有微博的frame和数据 */
@property(nonatomic, strong) NSMutableArray *statusFrames;

/** 上拉刷新控件 */
@property(nonatomic, strong) HVWLoadMoreWeiboFooterView *loadMoreFooter;

/** 导航栏标题按钮 */
@property(nonatomic, strong) HVWNavigationBarTitleButton *titleButton;

@end

@implementation HVWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 获取用户信息
    [self setupUserInfo];
    
    // 添加刷新器
    [self addRefresh];
    
    // 设置tableView背景颜色
    self.tableView.backgroundColor = HVWColor(211, 211, 211);
    // 设置"不需要分割线"
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置通知接收
    [self setupNotification];
}

/** 初始化statusFrame */
- (NSMutableArray *)statusFrames {
    if (nil == _statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

/** 添加刷新器 */
- (void) addRefresh {
    // 下拉刷新最新微博
    // 添加刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [self.view addSubview:refreshControl];
    
    // 刷新控件下拉事件
    [refreshControl addTarget:self action:@selector(refreshLatestWeibo:) forControlEvents:UIControlEventValueChanged];
    
    // 添加上拉刷新器
    HVWLoadMoreWeiboFooterView *loadMoreFooter = [[HVWLoadMoreWeiboFooterView alloc] init];
    self.loadMoreFooter = loadMoreFooter;
    self.tableView.tableFooterView = loadMoreFooter;
    
    // 加载微博数据
    [self refreshLatestWeibo:refreshControl];
}

/** 刷新最新微博数据 */
- (void) refreshLatestWeibo:(UIRefreshControl *) refreshControl {
    // 把最新的微博数据加到原来的微博前面
    
    // 开启的时候自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 设置参数
    /** 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
    HVWHomeStatusParam *param = [[HVWHomeStatusParam alloc] init];
    
    HVWStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    HVWStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = [NSNumber numberWithDouble:firstStatus.idstr.doubleValue];
    }
    
    // 发送请求
    [HVWStatusTool statusWithParameters:param success:^(HVWHomeStatusResult *statusResult) {
        // 获取最新的微博frame数组
        NSArray *newStatusFrames = [HVWStatusFrame statusFramesWithStatuses:statusResult.statuses];
        
        // 插入到微博数据数组的最前面
        NSRange newWeiboRange = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *newWeiboIndexSet = [NSIndexSet indexSetWithIndexesInRange:newWeiboRange];
        [self.statusFrames insertObjects:newStatusFrames atIndexes:newWeiboIndexSet];
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 刷新提示
        [self showRefreshIndicator:newStatusFrames.count];
        
        // 缩回刷新器
        [refreshControl endRefreshing];
        
        // 更新未读消息提醒角标
        self.tabBarItem.badgeValue = nil;
        
    } failure:^(NSError *error) {
        HVWLog(@"获取微博数据失败------%@", error);
    }];

}

/** 加载更多（旧）微博 */
- (void) loadMoreWeiboData {
    // 把更多的微博数据加到原来的微博后面
    
    // 设置参数
    HVWHomeStatusParam *param = [[HVWHomeStatusParam alloc] init];
    
    /** 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
    HVWStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    HVWStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    // 发送请求
    [HVWStatusTool statusWithParameters:param success:^(HVWHomeStatusResult *statusResult) {
        // 得到新微博数据frame
        NSArray *newStatusFrames = [HVWStatusFrame statusFramesWithStatuses:statusResult.statuses];
        
        // 插入到微博数据数组的后面
        [self.statusFrames addObjectsFromArray:newStatusFrames];
        
        // 刷新数据
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        HVWLog(@"获取微博数据失败------%@", error);
    }];
    
    [self.loadMoreFooter endRefresh];
}

/** 弹出微博更新提示框 */
- (void) showRefreshIndicator:(int) refreshCount {
    // 创建UILabel
    UILabel *refreshIndicatorLabel = [[UILabel alloc] init];
    refreshIndicatorLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置文本
    refreshIndicatorLabel.text = [NSString stringWithFormat:@"更新了%d条微博", refreshCount];
    
    // 设置背景
    refreshIndicatorLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_new_status_background"]];
    
    // 设置位置尺寸
    refreshIndicatorLabel.width = self.navigationController.view.width;
    refreshIndicatorLabel.height = 35;
    refreshIndicatorLabel.x = 0;
    // 因为一开始是藏在导航栏上的，所以要减去自身的高度
    refreshIndicatorLabel.y = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.height - refreshIndicatorLabel.height;
    
    // 添加到导航控制器view，要加载导航器的下面
    [self.navigationController.view insertSubview:refreshIndicatorLabel belowSubview:self.navigationController.navigationBar];
    
    // 使用动画弹出
    [UIView animateWithDuration:1.0 animations:^{
        // 使用更改transform来实现
        refreshIndicatorLabel.transform = CGAffineTransformMakeTranslation(0, refreshIndicatorLabel.height);
    } completion:^(BOOL finished) {
        // 弹出完毕后，再使用动画缩回
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复位置
            refreshIndicatorLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 从导航view删除
            [refreshIndicatorLabel removeFromSuperview];
        }];
    }];
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
    
    // 保存到成员属性
    self.titleButton = titleButton;
    
    // 设置导航栏标题
    HVWAccountInfo *accountInfo = [HVWAccountInfoTool accountInfo];
    NSString *navTitle = @"首页";
    if (accountInfo.screen_name) {
        navTitle = accountInfo.screen_name;
    }
    [titleButton setTitle:navTitle forState:UIControlStateNormal];
    
    [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 设置背景图片
    [titleButton setBackgroundImage:[UIImage resizedImage:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 监听按钮点击事件，替换图标
    [titleButton addTarget:self action:@selector(titleButtonClickd:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}


/** 获取用户信息 */
- (void) setupUserInfo {
    // 设置参数
    HVWAccountInfo *accountInfo = [HVWAccountInfoTool accountInfo];
    HVWUserParam *param = [[HVWUserParam alloc] init];
    param.uid = accountInfo.uid;
    
    // 发送请求
    [HVWUserTool userWithParameters:param success:^(HVWUserResult *user) {
        // 获取用户信息
        HVWAccountInfo *accountInfo = [HVWAccountInfoTool accountInfo];
        accountInfo.screen_name = user.screen_name;
        [HVWAccountInfoTool saveAccountInfo:accountInfo];
        
        // 设置导航栏标题
        [self.titleButton setTitle:accountInfo.screen_name forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        HVWLog(@"获取用户信息失败!error:%@", error);
    }];
}

#pragma mark - UITableVidwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 没有微博数据的时候，不需要显示“加载更多微博”控件
    self.loadMoreFooter.hidden = self.statusFrames.count==0?YES:NO;
    
    return self.statusFrames.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HVWStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    HVWStatusCell *cell = [HVWStatusCell cellWithTableView:tableView];
    cell.statusFrame = statusFrame;
    
    return cell;
}

#pragma mark - UITableViewDelegate
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

/** cell高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HVWStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

#pragma mark - HVWPopMenuDelegate
- (void)popMenuDidHideMenu:(HVWPopMenu *)popMenu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [self titleButtonClickd:titleButton];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 如果正在加载中，不用重复加载
    if (self.loadMoreFooter.isRefreshing) return;
    
    // 滚动时，scrollView处于屏幕顶部下方的内容长度
    CGFloat scrollingDelta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 当scrollView向上滚栋到刚好露出“上拉刷新”控件时，scrollView处于屏幕下方的内容长度
    CGFloat scrollViewHeighWithFooter = self.tableView.height - self.tabBarController.tabBar.height - self.loadMoreFooter.height;
    
    // 当向上滚动至scrollView能够显示的内容少于刚好露出“上拉刷新”控件时显示的内容，证明“上拉刷新”控件已经完全露出，可以刷新
    if (scrollingDelta < scrollViewHeighWithFooter) {
        [self.loadMoreFooter beginRefresh];
        [self loadMoreWeiboData];
    }
}

#pragma mark - 成员方法
/** 刷新数据 */
- (void) refreshStatusFromAnother:(BOOL)isFromAnother {
    if (!isFromAnother) { // 重复点击首页item
        if (self.tabBarItem.badgeValue.intValue) { // 有新消息
            // 刷新数据
            [self refreshLatestWeibo:self.refreshControl];
        }
        
        // 滚动到顶部
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - 通知方法
- (void) setupNotification {
    // 微博链接文本点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusLinkDidSelected:) name:HVWStatusDidLinkSelectedNotification object:nil];
}

/** 微博链接文本点击通知 */
- (void) statusLinkDidSelected:(NSNotification *)note {
    HVWStatusLink *link = note.userInfo[HVWStatusLinkKey];
    
    switch (link.type) {
        case HVWRegexTypeMention:
            
            break;
        case HVWRegexTypeSubject:
            
            break;
        case HVWRegexTypeHref:
            [self openHref:[HVWRegexTool textWithRegexString:link.text type:HVWRegexTypeHref]];
            break;
            
        default:
            break;
    }
}

/** 打开超链接 */
- (void) openHref:(NSString *)urlStr {
    UIViewController *viewController = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = [[UIApplication sharedApplication] keyWindow].bounds;
    [viewController.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:urlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
