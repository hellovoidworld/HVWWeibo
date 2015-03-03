//
//  HVWPhotoPageLabel.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWPhotoPageLabel.h"

@implementation HVWPhotoPageLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.font = [UIFont systemFontOfSize:20];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

/** 改变页码 */
- (void)changePageLabel:(int)pageIndex {
    self.text = [NSString stringWithFormat:@"%d/%d", pageIndex + 1, self.totalPageCount];
}

@end
