//
//  HVWComposeEmotionGridView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionGridView.h"
#import "HVWComposeEmotionListView.h"
#import "HVWComposeEmotionScrollView.h"
#import "HVWComposeEmotionPageControl.h"

@interface HVWComposeEmotionGridView() <UIScrollViewDelegate>

/** 表情scrollView */
@property(nonatomic, weak) HVWComposeEmotionScrollView *emotionScrollView;

/** 页码 */
@property(nonatomic, weak) HVWComposeEmotionPageControl *pageControl;

@end

@implementation HVWComposeEmotionGridView

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 页码面板
        HVWComposeEmotionPageControl *pageControl = [[HVWComposeEmotionPageControl alloc]init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 表情滚动面板
        HVWComposeEmotionScrollView *emotionScrollView = [[HVWComposeEmotionScrollView alloc] init];
        emotionScrollView.delegate = self;
        [self addSubview:emotionScrollView];
        self.emotionScrollView = emotionScrollView;
    }
    return self;
}

/** 布局子控件 */
- (void)layoutSubviews {
    [super layoutSubviews];
   
     // 页码面板
    CGFloat pageControlWidth = self.width;
    CGFloat pageControlHeight = 35;
    CGFloat pageControlX = 0;
    CGFloat pageConrrolY = self.height - pageControlHeight;
    self.pageControl.frame = CGRectMake(pageControlX, pageConrrolY, pageControlWidth, pageControlHeight);
    
    // 表情滚动面板
    CGFloat emotionScrollViewWidth = self.width;
    CGFloat emotionScrollViewHeight = self.height - pageControlHeight;
    CGFloat emotionScrollViewX = 0;
    CGFloat emotionScrollViewY = 0;
    self.emotionScrollView.frame = CGRectMake(emotionScrollViewX, emotionScrollViewY, emotionScrollViewWidth, emotionScrollViewHeight);
}

/** 配置表情数据 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    // 滚动版面
    self.emotionScrollView.emotions = emotions;
    
    // 页码
    self.pageControl.numberOfPages = (emotions.count + ComposeEmotionListMaxCount - 1) / ComposeEmotionListMaxCount;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
