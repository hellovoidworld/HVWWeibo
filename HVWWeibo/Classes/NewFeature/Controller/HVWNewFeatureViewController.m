//
//  HVWNewFeatureViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWNewFeatureViewController.h"
#import "HVWTabBarViewController.h"

#define NewFeatureCount 4

@interface HVWNewFeatureViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) UIPageControl *pageControl;

@end

@implementation HVWNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加scrollView
    [self setupScrollView];
    
    // 添加pageControl
    [self setupPageControl];
}

/** 添加scrollView */
- (void) setupScrollView {
    // 创建一个scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    // 添加图片
    for (int i=0; i<NewFeatureCount; i++) {
        
        // 获取图片
        NSString *featureImageName = [NSString stringWithFormat:@"new_feature_%d", i+1];
        UIImageView *featureImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:featureImageName]];
        
        // 设置图片尺寸位置
        CGFloat featureWidth = self.view.width;
        CGFloat featureHeight = self.view.height;
        CGFloat featureX = featureImageView.width * i;
        CGFloat featureY = 0;
        featureImageView.frame = CGRectMake(featureX, featureY, featureWidth, featureHeight);
        
        // 如果是最后一页，加上功能按钮
        if (i == (NewFeatureCount - 1)) {
            // 为了让最后一页的的功能按钮能够生效，必须激活交互功能
            featureImageView.userInteractionEnabled = YES;
            
            [self addFunctionButton:featureImageView];
        }
        
        // 添加图片到scrollView
        [scrollView addSubview:featureImageView];
    }
    
    // 设置scrollView功能属性
    scrollView.userInteractionEnabled = YES;
    scrollView.scrollEnabled = YES; // 支持滚动
    scrollView.contentSize = CGSizeMake(self.view.width * NewFeatureCount, 0); // 只需要水平滚动
    scrollView.pagingEnabled = YES; // 支持分页
    scrollView.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
    
    // 设置背景色
    scrollView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    // 设置代理
    scrollView.delegate = self;
    
    // 添加
    [self.view addSubview:scrollView];
}

/** 添加pageControl */
- (void) setupPageControl {
    // pageControl不能加在scrollView上，不然会随着内容一起滚动
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.numberOfPages = NewFeatureCount;
    
    // 设置位置
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height * 0.9;
    
    
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate
/** scrollView滚动代理方法，在这里控制页码指示器 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 四舍五入，让图片滚动超过中线的时候改变页码
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width + 0.5;
}

#pragma mark - 最后一页的功能
/** 添加功能按钮 */
- (void) addFunctionButton:(UIImageView *) imageView {
    // 添加"分享"选项按钮
    [self addShareButton:imageView];
    
    // 添加"进入微博"按钮
    [self addEnterWeiboButton:imageView];
}

/** 分享选项按钮 */
- (void) addShareButton:(UIImageView *) imageView  {
    // 创建按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    
    [shareButton setImage:[UIImage imageWithNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    
    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 位置尺寸
    shareButton.size = CGSizeMake(150, 50);
    
    // 必须先设置了size，center才真的在中心，不然就是从左上角开始!!!
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.65;

    // 设置内间距
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10.0, 0, 0);
    
    // 添加
    [imageView addSubview:shareButton];
}

/** 分享选项点击事件方法 */
- (void) shareButtonClicked:(UIButton *) button {
    button.selected = !button.selected;
}

/** “进入微博"按钮 */
- (void) addEnterWeiboButton:(UIImageView *) imageView  {
    // 创建按钮
    UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.userInteractionEnabled = YES;
    [enterButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enterButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterButton setTitle:@"进入微博" forState:UIControlStateNormal];
    
    // 位置尺寸
    enterButton.size = enterButton.currentBackgroundImage.size;
    enterButton.centerX = self.view.width * 0.5;
    enterButton.centerY = self.view.height * 0.8;
    
    // 监听点击
    [enterButton addTarget:self action:@selector(enterWeiboButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加
    [imageView addSubview:enterButton];
}

/** “进入微博” 按钮点击 */
- (void) enterWeiboButtonClicked {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[HVWTabBarViewController alloc] init];
}

@end
