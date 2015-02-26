//
//  HVWStatusCell.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVWStatusFrame.h"

@interface HVWStatusCell : UITableViewCell

/** frame */
@property(nonatomic, strong) HVWStatusFrame *statusFrame;

/** 创建方法 */
+ (instancetype) cellWithTableView:(UITableView *)tableView;

@end
