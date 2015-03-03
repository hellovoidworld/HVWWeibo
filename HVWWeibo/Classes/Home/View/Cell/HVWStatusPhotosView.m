//
//  HVWStatusPhotosView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/28.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusPhotosView.h"
#import "HVWStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "HVWPhotoBrowser.h"

#define HVWStatusPhotosTotalCount 9
#define HVWStatusPhotosMaxCol(count) ((count==4)?2:3);
#define HVWStatusPhotoWidth 70
#define HVWStatusPhotoHeight HVWStatusPhotoWidth
#define HVWStatusPhotoMargin 10

@interface HVWStatusPhotosView()

/** 相册内的配图view数组 */
@property(nonatomic, strong) NSMutableArray *photoViews;

/** 大图 */
@property(nonatomic, weak) UIImageView *bigPhotoView;

/** 被点击的小图frame */
@property(nonatomic, assign) CGRect clickedSmallPhotoFrame;

@end

@implementation HVWStatusPhotosView

- (NSMutableArray *)photoViews {
    if (nil == _photoViews) {
        _photoViews = [NSMutableArray array];
    }
    return _photoViews;
}

/** 使用代码初始化调用 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        // 先创建好n个配图view
        for (int i=0; i<HVWStatusPhotosTotalCount; i++) {
            HVWStatusPhotoView *photoView = [[HVWStatusPhotoView alloc] init];
            [self addSubview:photoView];
            [self.photoViews addObject:photoView];
            
            // 配置点击手势
            UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSamllPhoto:)];
            [photoView addGestureRecognizer:rec];
        }
    }
    
    return self;
}

/** 设置配图 */
- (void)setPhotos:(NSArray *)photoUrls {
    _photos = photoUrls;
    
    // 配置所有配图子view
    for (int i=0; i<self.photoViews.count; i++) {
        HVWStatusPhotoView *photoView = self.photoViews[i];
        if (i < photoUrls.count) {
            photoView.pic =  photoUrls[i];
            photoView.tag = i;
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
}

/** 布局子控件 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    int photosCount = self.photos.count;
    
    // 布局所有配图
    for (int i=0; i<photosCount; i++) {
        HVWStatusPhotoView *photoView = self.photoViews[i];
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        photoView.clipsToBounds = YES;
        
        int row = i / HVWStatusPhotosMaxCol(photosCount); // 配图所在行数
        int col = i % HVWStatusPhotosMaxCol(photosCount); // 配图所在列数
        
        CGFloat photoX = col * (HVWStatusPhotoWidth + HVWStatusPhotoMargin);
        CGFloat photoY = row * (HVWStatusPhotoHeight + HVWStatusPhotoMargin);
        photoView.frame = CGRectMake(photoX, photoY, HVWStatusPhotoWidth, HVWStatusPhotoHeight);
    }
    
}

/** 根据配图数量计算相册尺寸 */
+ (CGSize) photosViewSizeWithCount:(int)count {
    int maxCount = HVWStatusPhotosMaxCol(count);
    
    // 总列数
    int totalCol = count > maxCount? maxCount : count;
    // 总行数
    int totalRow = (count + maxCount - 1) / maxCount;
    
    CGFloat width = totalCol * (HVWStatusPhotoWidth + HVWStatusPhotoMargin) - HVWStatusPhotoMargin;
    CGFloat height = totalRow * (HVWStatusPhotoHeight + HVWStatusPhotoMargin) - HVWStatusPhotoMargin;
    return CGSizeMake(width, height);
}

/** 点击小图手势事件 */
- (void) tapSamllPhoto:(UITapGestureRecognizer *) rec {
    // 创建一个全屏遮盖背景
    HVWPhotoBrowser *photoBrowser = [[HVWPhotoBrowser alloc] init];
    photoBrowser.frame = [UIScreen mainScreen].bounds;
    
    // 添加到主窗口上
    // 一定要先添加到主窗口上,再进行坐标转换!!!否则会得到增大一倍的frame!!!
    [[[UIApplication sharedApplication] keyWindow] addSubview:photoBrowser];
    
    // 输入点击图片坐标
    HVWStatusPhotoView *smallPhotoView = (HVWStatusPhotoView *)rec.view;
    photoBrowser.photoOriginalFrames = [self photoOriginalFramesInView:photoBrowser];
    
    // 配置配图url
    NSMutableArray *photoUrls = [NSMutableArray array];
    for(HVWPic *pic in self.photos) {
        [photoUrls addObject:pic.bmiddle_pic];
    }
    photoBrowser.photoUrls = photoUrls;
    photoBrowser.currentPhotoIndex = smallPhotoView.tag;
}

/** 所有缩略图的frame */
- (NSArray *) photoOriginalFramesInView:(UIView *)view {
    NSMutableArray *photoOriginalFrames = [NSMutableArray array];
    for (HVWStatusPhotoView *photoView in self.photoViews) {
        CGRect convertFrame = [view convertRect:photoView.frame fromView:self];
        [photoOriginalFrames addObject:[NSValue valueWithCGRect:convertFrame]];
    }
    return photoOriginalFrames;
}

///** 点击小图手势事件 */
//- (void) tapSamllPhoto:(UITapGestureRecognizer *) rec {
//    // 创建一个全屏遮盖背景
//    UIView *bigPhotoCover = [[UIView alloc] init];
//    bigPhotoCover.frame = [UIScreen mainScreen].bounds;
//    bigPhotoCover.backgroundColor = [UIColor blackColor];
//    
//    // 添加点击遮盖手势
//    UITapGestureRecognizer *tapCoverRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhotoCover:)];
//    [bigPhotoCover addGestureRecognizer:tapCoverRec];
//    
//    // 添加到主窗口上
//    [[[UIApplication sharedApplication] keyWindow] addSubview:bigPhotoCover];
//    
//    // 被点击的小图
//    HVWStatusPhotoView *photoView = (HVWStatusPhotoView *)rec.view;
//    
//    // 创建一个要放大的图片，使用中等尺寸的配图
//    HVWPic *pic = self.photos[photoView.tag];
//    UIImageView *bigPhotoView = [[UIImageView alloc] init];
//    self.bigPhotoView = bigPhotoView;
//    bigPhotoView.contentMode = UIViewContentModeScaleAspectFill;
//    bigPhotoView.clipsToBounds = YES;
//    
//    // 下载图片
//    [bigPhotoView setImageWithURL:[NSURL URLWithString:pic.bmiddle_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
//    
//    // 转换大图的frame坐标,从photosView坐标转换到遮盖view坐标
//    bigPhotoView.frame = [bigPhotoCover convertRect:photoView.frame fromView:self];
//    self.clickedSmallPhotoFrame = bigPhotoView.frame;
//    
//    // 添加到遮盖上
//    [bigPhotoCover addSubview:bigPhotoView];
//    
//    // 放大图片
//    [UIView animateWithDuration:0.5 animations:^{
//        bigPhotoView.contentMode = UIViewContentModeScaleAspectFit;
//        bigPhotoView.clipsToBounds = NO;
//        CGFloat bigPhotoWidth = bigPhotoCover.width;
//        CGFloat bigPhotoHeight = bigPhotoView.height * (bigPhotoWidth / bigPhotoView.width);
//        CGFloat bigPhotoX = 0;
//        CGFloat bigPhotoY = bigPhotoHeight>=HVWScreenHeight? 0 : (HVWScreenHeight - bigPhotoHeight) * 0.5;
//        bigPhotoView.frame = CGRectMake(bigPhotoX, bigPhotoY, bigPhotoWidth, bigPhotoHeight);
//    }];
//    
//}
//
///** 点击大图展示遮盖手势事件 */
//- (void) tapPhotoCover:(UITapGestureRecognizer *) rec {
//    [UIView animateWithDuration:0.5 animations:^{
//        // 缩回图片
//        self.bigPhotoView.frame = self.clickedSmallPhotoFrame;
//    } completion:^(BOOL finished) {
//        // 消除遮盖
//        [rec.view removeFromSuperview];
//    }];
//}

@end
