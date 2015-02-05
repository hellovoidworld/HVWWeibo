//
//  HVWOAuthViewController.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/4.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "HVWControllerTool.h"
#import "HVWAccountInfo.h"
#import "HVWAccountInfoTool.h"

@interface HVWOAuthViewController () <UIWebViewDelegate>

@end

@implementation HVWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    
    // 添加到主界面
    [self.view addSubview:webView];
    
    // 加载请求页面
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",HVWAppKey, HVWRedirecgURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
/** 开始加载网页 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在努力加载中..."];
}

/** 结束加载网页 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

/** 加载失败 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
}

/** 截取web发送请求 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"http://www.cnblogs.com/hellovoidworld/?code="];
    
    if (range.location != NSNotFound && range.length > 0) { // 如果是匹配的url，即发送的是带access_code的url
        // 截取access_code
        NSUInteger accessCodeLocation = range.length + range.location;
        NSString *accessCode = [urlStr substringFromIndex:accessCodeLocation];
        
        // 获取access_token
        [self accessTokenWithAccessCode:accessCode];
        
        return NO; // 阻止发送，不需要跳转到重定向页面
    }
    
    return YES; // 其他情况照常发送
}

/** 根据access_code获取access_token */
- (void) accessTokenWithAccessCode:(NSString *) accessCode {
    // 创建AFN的http操作请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    // 参数设置
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"client_id"] = HVWAppKey;
    param[@"client_secret"] = HVWAppSecret;
    param[@"grant_type"] = HVWGrantType;
    param[@"code"] = accessCode;
    param[@"redirect_uri"] = HVWRedirecgURI;
    
    // 发送请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        
        // 返回的是用户信息字典
        // 存储用户信息，包括access_token到沙盒中
        HVWAccountInfo *accountInfo = [HVWAccountInfo accountInfoWithDictionary:responseObject];
        [HVWAccountInfoTool saveAccountInfo:accountInfo];
        
        // 设置根控制器
        [HVWControllerTool chooseRootViewController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        HVWLog(@"请求access_token失败 ----> %@", error);
    }];
    
}

@end
