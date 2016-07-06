//
//  MessageViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MessageViewController.h"
#import "DataService.h"
@interface MessageViewController ()
{
    UIWebView *_wView;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _initWebView];
}

- (void)_initWebView{
    
    _wView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //网页自适应
    _wView.scalesPageToFit = YES;
//    _wView.delegate = self;
    [self.view addSubview:_wView];
    
    
    NSURL *url = [NSURL URLWithString:@"http://weibo.com/u/3035384642/home?wvr=5&tongji=baiduxinshouye&sudaref=www.baidu.com"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    
    [_wView loadRequest:request];//加载
    
    
    //下拉刷新
//    _wView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [_wView loadRequest:request];
//    }];
    
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
