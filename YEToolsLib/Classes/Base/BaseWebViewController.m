//
//  BaseWebViewController.m
//  healthManagement
//
//  Created by Eason on 2017/3/13.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *mWebView;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackOfNavi];
    _mWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _mWebView.delegate = self;
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
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}
@end
