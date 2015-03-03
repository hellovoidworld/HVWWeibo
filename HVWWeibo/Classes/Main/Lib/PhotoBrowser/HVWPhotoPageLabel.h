//
//  HVWPhotoPageLabel.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVWPhotoPageLabel : UILabel

/** 总页数 */
@property(nonatomic, assign) int totalPageCount;

/** 改变页码 */
- (void)changePageLabel:(int)pageIndex;

@end
