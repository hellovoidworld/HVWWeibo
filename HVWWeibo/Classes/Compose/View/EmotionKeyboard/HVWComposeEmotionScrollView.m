//
//  HVWComposeEmotionScrollView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionScrollView.h"
#import "HVWComposeEmotionListView.h"

@interface HVWComposeEmotionScrollView()

@end

@implementation HVWComposeEmotionScrollView

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置
        self.scrollEnabled = YES;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

/** 配置表情 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    // 清空原有表情
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 复位滚动位置
    self.contentOffset = CGPointZero;
    
    // 创建N页表情
    int pageCount = (int)(emotions.count + ComposeEmotionListMaxCount - 1) / ComposeEmotionListMaxCount;
    for (int i=0; i<pageCount; i++) {
        // 每一页的表情
        HVWComposeEmotionListView *emotionListView =  [[HVWComposeEmotionListView alloc] init];
        
        int loc = i * ComposeEmotionListMaxCount;
        int len = ComposeEmotionListMaxCount;
        
        if (loc + len > emotions.count) {
            len = emotions.count % ComposeEmotionListMaxCount;
        }
        
        NSRange emotionRange = NSMakeRange(loc, len);
        NSArray *listEmotions = [emotions subarrayWithRange:emotionRange];
        emotionListView.emotions = listEmotions;
        
        [self addSubview:emotionListView];
    }
    
    // 计算scrollView
    self.contentSize = CGSizeMake(self.width * pageCount, 0);
    
    // 刷新布局
    [self setNeedsLayout];
}

/** 布局子控件 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 配置所有emotionListView
    for (int i=0; i<self.subviews.count; i++) {
        CGFloat listViewWidth = self.width;
        CGFloat listViewHeight = self.height;
        CGFloat listViewX = i * listViewWidth;
        CGFloat listViewY = 0;
        HVWComposeEmotionListView *listView = self.subviews[i];
        listView.frame = CGRectMake(listViewX, listViewY, listViewWidth, listViewHeight);
    }
}


@end
