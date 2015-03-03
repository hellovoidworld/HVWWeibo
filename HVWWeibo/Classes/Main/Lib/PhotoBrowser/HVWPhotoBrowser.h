//
//  HVWPhotoBrowser.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/1.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVWPhotoBrowser : UIView

/** 配图地址数组 */
@property(nonatomic, strong) NSMutableArray *photoUrls;

/** 当前配图序号 */
@property(nonatomic, assign) int currentPhotoIndex;

/** 配图组原始frame数组 */
@property(nonatomic, strong) NSArray *photoOriginalFrames;

@end
