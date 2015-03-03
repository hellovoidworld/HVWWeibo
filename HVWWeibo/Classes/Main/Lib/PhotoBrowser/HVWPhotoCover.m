//
//  HVWPhotoCover.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/2.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWPhotoCover.h"

@interface HVWPhotoCover()

/** 页码 */
@property(nonatomic, weak) UILabel *pageLabel;

@end

@implementation HVWPhotoCover

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 配图
        UIImageView *photoView = [[UIImageView alloc] init];
        photoView.contentMode = UIViewContentModeScaleAspectFill; // 填充图片
        photoView.clipsToBounds = YES; // 剪除多余部分
        self.photoView = photoView;
        [self addSubview:photoView];
    }
    return self;
}

@end
