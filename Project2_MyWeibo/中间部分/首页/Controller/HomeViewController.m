//
//  HomeViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "WeiboModel.h"
#import "MJRefresh.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainTabBarController.h"
@interface HomeViewController ()
<SinaWeiboRequestDelegate,WeiboDelegate>
{   //系统的总数据（包括加载后的）
    NSMutableArray *_sumData;
    
    AppDelegate *delegate;

    NSString *_lastWeiboID;
    
    MBProgressHUD *hud;

}


@end

@implementation HomeViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeChange object:nil ];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"picExchange" object:nil ];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //刷新UI的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:kThemeChange object:nil];
    //切换大小图的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_tabelViewReload) name:@"picExchange" object:nil];
    
    
    //上拉加载
    [self _initPullUpRefresh];
    //下拉刷新
    [self _initPullRefresh];
    //刷新UI
    [self refreshUI];
    //验证是否登录
    [self refreshSinaWeibo];
    

}




- (void)_initHUD{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    hud.square = YES;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = @"加载中...";
}

//刷新单元格
- (void)_tabelViewReload{
    [_tableView reloadData];
}
//刷新UI
- (void)refreshUI{
    
    ThemeBtn *rightBtn = [[ThemeBtn alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    rightBtn.showsTouchWhenHighlighted = YES;
    rightBtn.btnImgName = @"button_icon_plus.png";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    ThemeBtn *leftBtn = [[ThemeBtn alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    [leftBtn setTitle:@"设置" forState:UIControlStateNormal];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -100, 0, 0)];
    leftBtn.btnImgName = @"button_title.png";
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
#pragma mark 首次登陆加载数据
//登陆检查
- (void)refreshSinaWeibo{
    delegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.weiboDelegate = self;
    
    if (!delegate.sinaWeibo.isLoggedIn) {
        //还未登陆
        [delegate.sinaWeibo logIn];
        
    }else {
        //已经登录
        [self refreshTableView];
        
    }
    
}




//登录时首次请求数据
- (void)refreshTableView{
    //加载HUD
        if (delegate.sinaWeibo.isLoggedIn) {
            [self _initHUD];

        //已经登录
        //请求主页微博数据
        [DataService requestURL:home_timeline params:nil httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
            
            NSMutableArray *mArr = [NSMutableArray array];
            NSArray *array = [result objectForKey:@"statuses"];
            //遍历数组构造model
            for (NSDictionary *dic in array) {
                WeiboModel *model = [[WeiboModel alloc] initContentWithDic:dic];
                [mArr addObject:model];
                
            }
            
            WeiboModel *lastModel = [mArr lastObject];
            _lastWeiboID = lastModel.weiboId;
            
            [mArr removeLastObject];
            _tableView.data = mArr;
            
            NSLog(@"有%ld个数据",_tableView.data.count);
            
            _sumData = mArr;
            
            [_tableView reloadData];
            hud.hidden = YES;
            
            [self completeLoadWithTitle:@"加载完成"];
            
            
        } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }else{
        //未登录
        _tableView.data = nil;
        [_tableView reloadData];
    }
    
}

#pragma mark下拉刷新数据
//下拉刷新
- (void)_initPullRefresh{
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self pullDownRefresh];
        
    }];
    
    
}


//下拉刷新回调事件
- (void)pullDownRefresh{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
    
    if (_sumData.count > 0) {
        //首次请求到了数据
        WeiboModel *model = _sumData[0];
        NSString *topID = model.weiboId;
        [params setObject:topID forKey:@"since_id"];
    }
    
    [DataService requestURL:home_timeline params:params httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = result[@"statuses"];
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in  array) {
            
            WeiboModel *model = [[WeiboModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
            
        }
        
        if (mArr.count > 0) {
            //有新数据
            NSRange range = {0, mArr.count};
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_sumData insertObjects:mArr atIndexes:indexSet];
            
            
            //刷新表视图数据
            _tableView.data = _sumData;
            [_tableView reloadData];
            
            
        }
        
        NSLog(@"加载了%ld个新微薄",mArr.count);
        //收起下拉控件
        [_tableView.header endRefreshing];
        
        //现实新微博的数量
        [self showNewWeiboCount:mArr.count];
        
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_tableView.header endRefreshing];
    }];
    
    
    
    
}
#pragma mark上拉加载数据
//上拉加载
- (void)_initPullUpRefresh{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //
        [self refreshUpTabelView];
        NSLog(@"上拉加载");
    }];
    
    
}

//上拉加载数据
- (void)refreshUpTabelView{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:_lastWeiboID forKey:@"max_id"];
    
    [DataService requestURL:home_timeline params:params httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        NSMutableArray *mArr = [NSMutableArray array];
        NSArray *array = [result objectForKey:@"statuses"];
        //遍历数组构造model
        for (NSDictionary *dic in array) {
            WeiboModel *model = [[WeiboModel alloc] initContentWithDic:dic];
            [mArr addObject:model];
            
        }
        
        if (mArr.count > 1) {
            _lastWeiboID = [[mArr lastObject] weiboId];
            [mArr removeLastObject];
            [_sumData addObjectsFromArray:mArr];
            NSLog(@"又加载了%ld个数据",mArr.count);
            _tableView.data =_sumData;
            NSLog(@"一共%ld个数据",_tableView.data.count);
        }else{
            
            [_sumData addObjectsFromArray:mArr];
            NSLog(@"又加载了%ld个数据",mArr.count);
            _tableView.data =_sumData;
            NSLog(@"一共%ld个数据",_tableView.data.count);
        }
        
        
        
        
        [_tableView reloadData];
        
        //下拉刷新停止
        [self.tableView.footer endRefreshing];
        
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.footer endRefreshing];
    }];
    
    
    
}


#pragma mark导航控制器按钮触发事件

//导航栏右边按钮触发事件
- (void)rightBtnAction{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}


//导航栏左边按钮触发事件
- (void)leftBtnAction{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/**
 *  视图将要显示的时候
 *
 *  @param animated 只有首页有滑动能力
 */
- (void)viewWillAppear:(BOOL)animated{
    //设置滑动的区域
    self.mm_drawerController. openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
//    [self refreshSinaWeibo];
}


- (void)viewDidDisappear:(BOOL)animated{
    //设置滑动的区域
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}



#pragma mark显示更新微博数量
//显示更新微博数量
- (void)showNewWeiboCount:(NSInteger)count
{
    if (barView == nil) {
        barView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 40)];
        
        [self.view addSubview:barView];
        
        barItem = [[ThemeImgView alloc] initWithFrame:barView.bounds];
        [barView addSubview:barItem];
        
        barLabel = [[ThemeLabel alloc] initWithFrame:barView.bounds];
        barLabel.textAlignment = NSTextAlignmentCenter;
        [barView addSubview:barLabel];
        
        barItem.backgroundColor = [UIColor clearColor];
        barView.backgroundColor = [UIColor clearColor];
        barLabel.backgroundColor = [UIColor clearColor];
        
        //给iamgeView和Label 赋值主题图片和字体颜色
        barItem.imgName = @"timeline_notify.png";
        barLabel.textColorName = @"Timeline_Notice_color";
        
    }
    
    barLabel.text = [NSString stringWithFormat:@"%ld条新微博", count];
    
    //显示动画
    [UIView animateWithDuration:0.6
                     animations:^{
                         barView.top = 10;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             [UIView setAnimationDelay:1];
                             [UIView animateWithDuration:1
                                              animations:^{
                                                  barView.top = -40;
                                              }];
                         }
                     }];
    
    

    
    //注册系统声音
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    
    //播放系统声音
    AudioServicesPlaySystemSound(soundID);
    
    
    //移除
    AudioServicesRemoveSystemSoundCompletion(soundID);
    
    //移除标签栏的数字
    [(MainTabBarController *)self.tabBarController imgView].hidden = YES;
    
}


@end
