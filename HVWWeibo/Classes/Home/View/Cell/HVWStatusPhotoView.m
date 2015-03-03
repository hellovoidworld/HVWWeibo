//
//  HVWStatusPhotoView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/28.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusPhotoView.h"
#import "UIImageView+WebCache.h"

@interface HVWStatusPhotoView()

/** gif logo */
@property(nonatomic, weak) UIImageView *gifLogo;

@end

@implementation HVWStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 填充方式显示
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 剪除框外图形
        self.clipsToBounds = YES;
        
        // 允许用户交互
        self.userInteractionEnabled = YES;
        
        // gif logo
        UIImageView *gifLogo = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"timeline_image_gif"]];
        [self addSubview:gifLogo];
        self.gifLogo = gifLogo;
    }
    return self;
}

- (void)setPic:(HVWPic *)pic {
    _pic = pic;
    
    // 显示配图到view上
    [self setImageWithURL:[NSURL URLWithString:pic.thumbnail_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    
    // 如果是gif文件，需要加上标识
    if ([pic.thumbnail_pic.pathExtension.lowercaseString isEqualToString:@"gif"]) {
        self.gifLogo.hidden = NO;
    } else {
        self.gifLogo.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.gifLogo && self.gifLogo.hidden==NO) {
        self.gifLogo.x = self.width - self.gifLogo.width;
        self.gifLogo.y = self.height - self.gifLogo.height;
    }
}

@end
