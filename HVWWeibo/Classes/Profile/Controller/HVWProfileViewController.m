//
//  HVWProfileViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWProfileViewController.h"

@interface HVWProfileViewController ()

@end

@implementation HVWProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableVidwDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"ProfileCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"我cell - %d", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
