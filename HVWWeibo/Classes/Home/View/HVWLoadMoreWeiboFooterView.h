//
//  HVWLoadMoreWeiboFooterView.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/6.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVWLoadMoreWeiboFooterView : UIView

/** 是否正在刷新 */
@property(nonatomic, assign, getter=isRefreshing) BOOL refreshing;

/** 开始刷新 */
- (void) beginRefresh;
/** 停止刷新 */
- (void) endRefresh;

@end
