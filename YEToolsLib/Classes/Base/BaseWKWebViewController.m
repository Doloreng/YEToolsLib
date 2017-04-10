//
//  BaseWKWebViewController.m
//  healthManagement
//
//  Created by Eason on 2017/3/13.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface BaseWKWebViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *mWebView;
@end

@implementation BaseWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackOfNavi];
    _mWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _mWebView.navigationDelegate = self;
    [self.view addSubview:_mWebView];
    [self loadWebUrl];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadWebUrl{
    if (_urlStr) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
        [_mWebView loadRequest:request];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark WKNavigationDelegate
//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD show];
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
//页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [SVProgressHUD dismiss];
}
@end
