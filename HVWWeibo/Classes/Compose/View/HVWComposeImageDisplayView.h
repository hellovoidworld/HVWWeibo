//
//  HVWComposeImageDisplayView.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/7.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVWComposeImageDisplayView : UIView

@property(nonatomic, strong) NSMutableArray *images;

- (void) addImage:(UIImage *) image;

@end
