//
//  HVWHomeViewController.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/1/31.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVWHomeViewController : UITableViewController

/** 刷新数据 */
- (void) refreshStatusFromAnother:(BOOL)isFromAnother;

@end
