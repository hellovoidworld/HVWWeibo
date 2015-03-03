//
//  HVWPhotoBrowser.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/1.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "HVWPhotoCover.h"
#import "HVWPhotoPageLabel.h"

#define PhotoScrollViewWidth self.photoScrollView.width
#define PhotoScrollViewHeight self.photoScrollView.height

@interface HVWPhotoBrowser() <UIScrollViewDelegate>

/** 当前背景 */
@property(nonatomic, weak) HVWPhotoCover *cover;
/** 替换用背景 */
@property(nonatomic, weak) HVWPhotoCover *backupCover;

/** 滚动配图展示view */
@property(nonatomic, weak) UIScrollView *photoScrollView;

/** 上次滚动x位置 */
@property(nonatomic, assign) CGFloat lastOffsetX;

/** 是否正在滚动 */
@property(nonatomic, assign, getter=isScrolling) BOOL scrolling;

/** 是否已经运行了开场动画(放大) */
@property(nonatomic, assign, getter=isDidRunAnimation) BOOL didRunAnimation;

/** 页码 */
@property(nonatomic, weak) HVWPhotoPageLabel *pageLabel;

@end

@implementation HVWPhotoBrowser

/** 使用代码创建调用的初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 隐藏状态栏
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        self.backgroundColor = [UIColor blackColor];
        
        // 滚动配图展示
        UIScrollView *photoScrollView = [[UIScrollView alloc] init];
        [self addSubview:photoScrollView];
        self.photoScrollView = photoScrollView;
        photoScrollView.delegate = self;

        photoScrollView.scrollEnabled = YES;
        photoScrollView.userInteractionEnabled = YES;
        photoScrollView.pagingEnabled = YES;
        photoScrollView.showsHorizontalScrollIndicator = NO;
        photoScrollView.showsVerticalScrollIndicator = YES;
        
        // 由于配置currentPhotoIndex时会用其frame计算cover位置，所以不能等到layoutSubviews才设置frame
        self.photoScrollView.frame = [UIScreen mainScreen].bounds;
        
        // 配图背景
        HVWPhotoCover *cover = [[HVWPhotoCover alloc] init];
        self.cover = cover;
        [photoScrollView addSubview:cover];
        
        HVWPhotoCover *backupCover = [[HVWPhotoCover alloc] init];
        self.backupCover = backupCover;
        [photoScrollView addSubview:backupCover];
        
        // 添加点击遮盖手势
        UITapGestureRecognizer *tapCoverRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhotoCover:)];
        [self addGestureRecognizer:tapCoverRec];
        
        // 页码
        HVWPhotoPageLabel *pageLabel = [[HVWPhotoPageLabel alloc] init];
        [self addSubview: pageLabel];
        self.pageLabel = pageLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 页码
    self.pageLabel.frame = (CGRect){{0, 10}, {self.width, 35}};
}

/**  配置当前配图 */
- (void)setCurrentPhotoIndex:(int)currentPhotoIndex {
    _currentPhotoIndex = currentPhotoIndex;
    
    // 由于滚动结束触发此方法，不需要重新加载图片
    if (!self.isDidRunAnimation) {
        // 加载图片
        [self loadImage:self.cover withPhotoIndex:currentPhotoIndex];
    }
    
    // 页码
    [self.pageLabel changePageLabel:currentPhotoIndex];
}

/** 点击大图展示遮盖手势事件 */
- (void) tapPhotoCover:(UITapGestureRecognizer *) rec {
    [UIView animateWithDuration:0.5 animations:^{
        // 缩回图片
        UIImageView *photoView = self.cover.photoView;
        photoView.frame = [self currentPhotoOriginalFrame];
        
        // 恢复状态栏显示
        [UIApplication sharedApplication].statusBarHidden = NO;
    } completion:^(BOOL finished) {
        // 消除遮盖
        [rec.view removeFromSuperview];
    }];
}

/** 所有配图 */
- (void)setPhotoUrls:(NSMutableArray *)photoUrls {
    _photoUrls = photoUrls;
    
    // 配置scrollView
    self.photoScrollView.contentSize = CGSizeMake(HVWScreenWidth * photoUrls.count, 0);
    
    // 配置cover
    self.pageLabel.totalPageCount = photoUrls.count;
}

#pragma mark - UIScrollViewDelegate
/** 拖曳中 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (!self.isScrolling) { // 是否正在滚动，仅需在滚动开始的一刻加载图片
        if (offsetX > self.lastOffsetX) {
            [self loadImage:self.backupCover withPhotoIndex:self.currentPhotoIndex + 1];
            // 设置滚动标识
            self.scrolling = YES;
        } else if (offsetX < self.lastOffsetX) {
            [self loadImage:self.backupCover withPhotoIndex:self.currentPhotoIndex - 1];
            // 设置滚动标识
            self.scrolling = YES;
        }
    }
    
    // 设置页码
    int pageIndex =  (offsetX + self.photoScrollView.width * 0.5) / self.photoScrollView.width;
    [self.pageLabel changePageLabel:pageIndex];
}

/** 滚动完全停止 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 更新滚动位置
    self.lastOffsetX = scrollView.contentOffset.x;
    
    // 当前页码
    int currentPhotoIndex = self.lastOffsetX / PhotoScrollViewWidth;
    // 如果进行了换页
    if (currentPhotoIndex != self.currentPhotoIndex) {
        // 更新当前图片和替换图片
        HVWPhotoCover *tempCover = self.backupCover;
        self.backupCover = self.cover;
        self.cover = tempCover;

        // 更新当前图片索引
        self.currentPhotoIndex = currentPhotoIndex;
    }
    
    // 重置滚动标识
    self.scrolling = NO;
}

#pragma mark - 加载图片

/** 当前图片缩略图frame */
- (CGRect)currentPhotoOriginalFrame {
    return [self.photoOriginalFrames[self.currentPhotoIndex] CGRectValue];
}

/** 当前cover的frame */
- (CGRect)currentPhotoCoverFrame:(int)photoIndex {
    return CGRectMake(photoIndex * PhotoScrollViewWidth, 0, PhotoScrollViewWidth, PhotoScrollViewHeight);
}

/** 加载配图 */
- (void) loadImage:(HVWPhotoCover *)cover withPhotoIndex:(int)photoIndex{
    if (photoIndex < 0 || photoIndex >= self.photoUrls.count) return;
    
    // 取得配图地址
    NSString *currentPhotoUrlStr = self.photoUrls[photoIndex];
    
    // 加入到显示区
    cover.frame = [self currentPhotoCoverFrame:photoIndex];
    UIImageView *photoView = cover.photoView;
    photoView.frame = [self currentPhotoOriginalFrame];
    
    // 当前scrollView的offsetX
    self.lastOffsetX = photoIndex * PhotoScrollViewWidth;
    
    // 先设置一张占位图
    [photoView setImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    
    // 放大图片
    if (!self.isDidRunAnimation) { // 非滚动切换来的图片，需要进行放大动画
        // 滚动到相应位置
        [self.photoScrollView setContentOffset:CGPointMake(photoIndex * PhotoScrollViewWidth, 0)];
        
        __weak UIImageView *tempPhotoView = photoView;
        [UIView animateWithDuration:0.5 animations:^{
            
            CGFloat placeHolderWidth = self.width;
            CGFloat placeHolderHeight = placeHolderWidth;
            CGFloat placeHolderX = 0;
            CGFloat placeHolderY = (PhotoScrollViewHeight - placeHolderHeight) * 0.5;
            tempPhotoView.frame = CGRectMake(placeHolderX, placeHolderY, placeHolderWidth, placeHolderHeight);
            
        } completion:^(BOOL finished) {
            self.didRunAnimation = YES;
            [self setupPhotoView:photoView withUrl:currentPhotoUrlStr];
        }];
    } else { // 滚动切换图片，直接加载
        UIImageView *backupPhotoView = self.backupCover.photoView;
        [backupPhotoView setImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
        CGFloat placeHolderWidth = self.width;
        CGFloat placeHolderHeight = placeHolderWidth;
        CGFloat placeHolderX = 0;
        CGFloat placeHolderY = (PhotoScrollViewHeight - placeHolderHeight) * 0.5;
        backupPhotoView.frame = CGRectMake(placeHolderX, placeHolderY, placeHolderWidth, placeHolderHeight);
        
        [self setupPhotoView:photoView withUrl:currentPhotoUrlStr];
    }
}

/** 下载并设置图片 */
- (void) setupPhotoView:(UIImageView *)photoView withUrl:(NSString *)currentPhotoUrlStr {
    // 下载图片
    __weak UIImageView *tempPhotoView = photoView;
    [photoView setImageWithURL:[NSURL URLWithString:currentPhotoUrlStr] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        // 下载完毕，重新根据图片实际大小计算尺寸、位置
        tempPhotoView.height = image.size.height * (tempPhotoView.width / image.size.width);
        tempPhotoView.y = tempPhotoView.height>=PhotoScrollViewHeight? 0 : (PhotoScrollViewHeight - tempPhotoView.height) * 0.5;
    }];
}

@end
