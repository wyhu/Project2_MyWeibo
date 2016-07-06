//
//  SecondViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SecondViewController.h"
#import "MJRefresh.h"
@interface SecondViewController ()<UIWebViewDelegate,MBProgressHUDDelegate>
{
    UIView *_actiView;
    UIWebView *_wView;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    self.title = @"Second";
    [super viewDidLoad];
    [self _initWebView];
    [self _initActivityIndicatorView];
    
}
/**
 初始化风火轮
 */
- (void)_initActivityIndicatorView{
    _actiView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 100) / 2, (kScreenHeight - 100) / 2 - 100, 100, 100)];
    _actiView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_actiView];
    
    UIActivityIndicatorView * actiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actiView.frame = CGRectMake(_actiView.width / 2, _actiView.height / 2, 0, 0);
    [actiView startAnimating];
    [_actiView addSubview:actiView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _actiView.height - 30, _actiView.width, 30)];
    
    label.text = @"加载中...";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    [_actiView addSubview:label];
    
    
    
}
/**
 *   初始化_initWebView
 */
- (void)_initWebView{
    
    _wView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //网页自适应
    _wView.scalesPageToFit = YES;
    _wView.delegate = self;
    [self.view addSubview:_wView];
    
    
    NSURL *url = [NSURL URLWithString:_url];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    
    [_wView loadRequest:request];//加载
    
    
    //下拉刷新
    _wView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_wView loadRequest:request];
    }];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView.scrollView.header  endRefreshing];
    [_actiView removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)viewWillDisappear:(BOOL)animated{
    [_wView stopLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
