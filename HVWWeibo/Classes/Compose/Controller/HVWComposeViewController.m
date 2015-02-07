//
//  HVWComposeViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/3.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeViewController.h"
#import "HVWComposeTextView.h"
#import "HVWComposeToolBar.h"
#import "HVWComposeImageDisplayView.h"

@interface HVWComposeViewController () <UITextViewDelegate, UIScrollViewDelegate, HVWComposeToolBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/** 输入框 */
@property(nonatomic, strong) HVWComposeTextView *composeView;

/** 工具条 */
@property(nonatomic, strong) HVWComposeToolBar *toolBar;

/** 图片显示区 */
@property(nonatomic, strong) HVWComposeImageDisplayView *imageDisplayView;

@end

@implementation HVWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 添加自定义UITextView
    [self setupTextView];

    // 添加工具栏
    [self setupToolBar];
}

/** 设置工具栏 */
- (void) setupToolBar {
    HVWComposeToolBar *toolBar = [[HVWComposeToolBar alloc] init];
    self.toolBar = toolBar;
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.delegate = self;
    
    toolBar.x = 0;
    // 在底部显示
    toolBar.y = self.view.height - toolBar.height;
    
    [self.view addSubview:toolBar];
}

/** 设置输入控件 */
- (void) setupTextView {
    HVWComposeTextView *composeView = [[HVWComposeTextView alloc] init];
    self.composeView = composeView;
    composeView.frame = self.view.bounds;
    composeView.delegate = self;
    
    composeView.placeHolder = @"分享点滴精彩...";
    
    [self.view addSubview:composeView];
    
    // 监听键盘通知
    // 键盘将弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘将缩回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 添加图片显示区
    [self setupImageDisplayView];
}

/** 设置导航栏 */
- (void) setupNavigationBar {
    // 标题
    self.title = @"发微博";
    
    // 导航栏左方按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

/** 添加图片显示区 */
- (void) setupImageDisplayView {
    HVWComposeImageDisplayView *imageDisplayView = [[HVWComposeImageDisplayView alloc] init];
    imageDisplayView.size = self.composeView.size;
    imageDisplayView.x = 0;
    imageDisplayView.y = 100;
    
    self.imageDisplayView = imageDisplayView;
    
    [self.composeView addSubview:imageDisplayView];
}

- (void)viewDidAppear:(BOOL)animated {
    // 自动弹出键盘
    [self.composeView becomeFirstResponder];
}

- (void) dismiss {
    [self.composeView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - UIScrollViewDelegate
/** 开始拖曳 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 缩回键盘
    [self.composeView resignFirstResponder];
}

#pragma mark - HVWComposeToolBarDelegate
/** 工具栏的按钮被点击了 */
- (void)composeToolBar:(HVWComposeToolBar *)composeToolBar didButtonClicked:(HVWComposeToolBarButtonTag)tag {
    // 判断哪个按钮被点击
    switch (tag) {
        case HVWComposeToolBarButtonTagCamera: // 相机
            [self openCamera];
            break;
        case HVWComposeToolBarButtonTagPhotoLib: // 相册
            [self openAlbum];
            break;
        case HVWComposeToolBarButtonTagMention: // 提到@
            
            break;
        case HVWComposeToolBarButtonTagTrend: // 话题
            
            break;
        case HVWComposeToolBarButtonTagEmotion: // 表情
            
            break;
        default:
            break;
    }
}

/** 打开相机 */
- (void) openCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

/** 打开相册 */
- (void) openAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 取得原图
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.imageDisplayView addImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 键盘通知处理
/** 键盘将弹出 */
- (void) keyboardWillShow:(NSNotification *) note {
    // 键盘弹出需要时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 移动工具条
    [UIView animateWithDuration:duration animations:^{
        // 获取键盘高度
        CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGFloat keyboardHeight = keyboardFrame.size.height;
        
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -1 * keyboardHeight);
    }];
}

/** 键盘将缩回 */
- (void) keyboardWillHide:(NSNotification *) note {
    // 键盘缩回需要时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 移动工具条
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

@end
