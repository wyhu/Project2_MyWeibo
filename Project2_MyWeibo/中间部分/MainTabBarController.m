//
//  MainTabBarController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()
{
    ThemeImgView *_tarBarImgView;
    ThemeLabel *_label;
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义标签栏
    [self _initTabBarItem];
    //初始化标签栏上的信息提示小图标
    [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    
}

- (void)timerAction:(NSTimer *)timer{
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString *userID = delegate.sinaWeibo.userID;
//    if (userID.length == 0) {
//        return;
//    }
//    
//    
//    
//    
//    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"uid"];
    
    [DataService requestURL:@"remind/unread_count.json" params:params httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        //读取成功
       NSNumber *unread = [result objectForKey:@"status"];
        NSLog(@"unread is %@",unread);
        
        
        if (_imgView == nil) {
            _imgView = [[ThemeImgView alloc] initWithFrame:CGRectMake(kScreenWidth / 5 - 40, 2, 32, 32)];
            _imgView.imgName = @"number_notify_9.png";
            [_tarBarImgView addSubview:_imgView];
            _label = [[ThemeLabel alloc] initWithFrame:_imgView.bounds];
            _label.textColorName = @"Timeline_Notice_color";
            [_imgView addSubview:_label];
            _label.textAlignment = NSTextAlignmentCenter;
        }
        if ([unread integerValue] > 0) {
            if ([unread integerValue] > 99) {
                
            }
            _imgView.hidden = NO;
            _label.text = [NSString stringWithFormat:@"%@",unread];
        }else{
            _imgView.hidden = YES;
        }
        
        
        
        
        
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        //读取失败
        NSLog(@"%@",error);
    }];
    
    
    
    
}





- (void)_initTabBarItem{
    //隐藏系统
    self.tabBar.hidden = YES;
    
    //构造tarbarimgView
    _tarBarImgView = [[ThemeImgView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 55, kScreenWidth, 55)];
    //为其添加背景颜色
    _tarBarImgView.imgName = @"mask_navbar.png";
    _tarBarImgView.tag = 1234;
    [self.view addSubview:_tarBarImgView];
    
    //构造选择图片
    ThemeImgView *selectedView = [[ThemeImgView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 5, 55)];

    selectedView.imgName = @"home_bottom_tab_arrow.png";
    selectedView.tag = 300;

    [_tarBarImgView addSubview:selectedView];
    
    //循环添加按钮
    //打开触发时间
    _tarBarImgView.userInteractionEnabled = YES;
    
    for (int i = 0 ; i < 5; i ++) {
        
        ThemeBtn *btn = [[ThemeBtn alloc] initWithFrame:CGRectMake(kScreenWidth / 5 * i, 0, kScreenWidth / 5, 55)];
        
        NSString *str = [NSString stringWithFormat:@"home_tab_icon_%d.png",i +1];
        btn.btnImgName = str;
        
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tarBarImgView addSubview:btn];
        
    }
    
    
    
    
}

- (void)btnAction:(UIButton *)btn{
    self.selectedIndex = btn.tag - 200;
    
    UIImageView *imgView = (UIImageView *)[_tarBarImgView viewWithTag:300];
    
    imgView.center = btn.center;
    
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
