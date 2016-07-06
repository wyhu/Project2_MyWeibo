//
//  MoreViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreSecondTabelVC.h"
@interface MoreViewController ()
@end

@implementation MoreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //账户管理接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountChange) name:@"accountChange" object:nil];
    
    
    self.rightLabel.right = kScreenWidth - 30;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:kThemeChange object:nil];
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if (delegate.sinaWeibo.isLoggedIn == 0) {
//        //还没有登陆
//        [delegate.sinaWeibo logIn];
//        self.cancceLabel.text = @"点击登录";
//    }else if (delegate.sinaWeibo.isLoggedIn == 1){
//        //已经登录
//        self.cancceLabel.text = @"注销当前账户";
//    }
    
}

- (void)refreshTableView{
    
    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消导航栏透明状态
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏的背景
    
    UIImage *img = [[ThemeManager shareThemeType] returnImgWithImgName:@"mask_detailbar.png"];
    
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, 64));
    [img drawInRect:CGRectMake(0, 0, kScreenWidth, 84)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    //背景
    UIImage *image = [[ThemeManager shareThemeType] returnImgWithImgName:@"bg_home.jpg"];
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, kScreenHeight * 2));
    [image drawInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    //标题
    ThemeLabel *titltLabe = [[ThemeLabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    titltLabe.textAlignment = NSTextAlignmentCenter;
    titltLabe.text = self.navigationItem.title;
    titltLabe.font = [UIFont boldSystemFontOfSize:22];
    titltLabe.textColorName = @"Mask_Title_color";
    self.navigationItem.titleView = titltLabe;

    
    
    UIImage *img1 = [[ThemeManager shareThemeType] returnImgWithImgName:@"more_icon_theme.png"];
    self.imgView1.image = img1;
    UIImage *img2 = [[ThemeManager shareThemeType] returnImgWithImgName:@"more_icon_account.png"];
    self.imgView2.image = img2;
    
    UIImage *img3 = [[ThemeManager shareThemeType] returnImgWithImgName:@"more_icon_feedback.png"];
    self.imgView3.image = img3;
    
    self.rightLabel.text = [ThemeManager shareThemeType].themeName;
    self.rightLabel.textColorName = @"Theme_Main_color";
    
    }

//当单元格被点击的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0&&indexPath.section == 0) {
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       MoreSecondTabelVC * VC = [storyBorad instantiateViewControllerWithIdentifier:@"secondVC"];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    //注销账户执行的方法
    if (indexPath.row ==0 && indexPath.section == 2) {
        //点击进行账户管理
        [self cancelAccount];
    }
    [tableView reloadData];
}

//注销账户
- (void)cancelAccount{
    

    
    
    
}


- (void)accountChange{
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeChange object:nil];
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
