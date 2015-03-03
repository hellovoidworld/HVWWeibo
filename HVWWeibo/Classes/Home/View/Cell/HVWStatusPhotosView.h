//
//  HVWStatusPhotosView.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/28.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVWStatusPhotosView : UIView

/** 配图数组，里面装载的时HVWPic模型 */
@property(nonatomic, strong) NSArray *photos;

/** 根据配图数量计算相册尺寸 */
+ (CGSize) photosViewSizeWithCount:(int)count;

@end
