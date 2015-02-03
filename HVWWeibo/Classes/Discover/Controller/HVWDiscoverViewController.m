//
//  HVWDiscoverViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWDiscoverViewController.h"
#import "HVWSearchBar.h"

@interface HVWDiscoverViewController ()

@end

@implementation HVWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加搜索框
    HVWSearchBar *searchBar = [[HVWSearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, 300, 40);
    self.navigationItem.titleView = searchBar;
}

#pragma mark - UITableVidwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"DiscoverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"发现cell - %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
