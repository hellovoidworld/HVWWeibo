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
#import "HVWAccountInfo.h"
#import "HVWAccountInfoTool.h"
#import "MBProgressHUD+MJ.h"
#import "HVWFileDataParam.h"
#import "HVWComposeStatusParam.h"
#import "HVWComposeStatusResult.h"
#import "HVWStatusTool.h"

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
    
    // 导航栏右方按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendWeibo)];
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

/** 退出“发微博” */
- (void) dismiss {
    [self.composeView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/** 发送微博 */
- (void) sendWeibo {
    if (self.composeView.text.length == 0) {
        [MBProgressHUD showError:@"你好像忘记了内容..."];
        return;
    }
    
    [MBProgressHUD showMessage:@"发送微博中..."];
    
    if (self.imageDisplayView.images.count) { // 发送的时带图片的微博
        [self sendWeiboWithTextNImage];
    } else { // 发送的是纯文字微博
        [self sendWeiboWithText];
    }
}

/** 发送文字微博 */
- (void) sendWeiboWithText {
    // 设置参数
    HVWComposeStatusParam *statusParam = [[HVWComposeStatusParam alloc] init];
    statusParam.status= self.composeView.text;
    
    // 发送请求
    [HVWStatusTool composeStatusWithParameters:statusParam imagesData:nil success:^(HVWComposeStatusResult *result) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功!"];
    } failure:^(NSError *error) {
        HVWLog(@"发送微博失败, error:%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败!error"];
    }];
}

/** 发送图文微博 */
- (void) sendWeiboWithTextNImage {
    if (self.imageDisplayView.images.count == 0) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"懵了,找不到图儿!"];
        return;
    }
    
    // 设置参数
    HVWComposeStatusParam *statusParam = [[HVWComposeStatusParam alloc] init];
    statusParam.status = self.composeView.text;
    
    // 发送的图片数据,其实现在开放的API只允许上传一张图片
    HVWFileDataParam *imageDataParam = [[HVWFileDataParam alloc] init];
    UIImage *image  = [self.imageDisplayView.images firstObject];
    imageDataParam.fileData = UIImagePNGRepresentation(image);
    imageDataParam.name = @"pic"; // 这是微博API指定的参数名
    imageDataParam.fileName = @"statusPic"; // 这是随便起的
    imageDataParam.mimeType = @"image/png";
    NSArray *imagesDataParamArray = @[imageDataParam];
    
    // 发送请求
    [HVWStatusTool composeStatusWithParameters:statusParam imagesData:imagesDataParamArray success:^(HVWComposeStatusResult *result) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功!"];
    } failure:^(NSError *error) {
        HVWLog(@"发送微博失败, error:%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败!"];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
