//
//  BaseViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    MBProgressHUD *hud;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //标题字体颜色切换
    [self _initTitleTextColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_initTitleTextColor) name:kThemeChange object:nil];
}

- (void)_initTitleTextColor{
    //背景
    UIImage *image = [[ThemeManager shareThemeType] returnImgWithImgName:@"bg_home.jpg"];
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, kScreenHeight));
    [image drawInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
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
    
    
    
}

- (void)showSimpleHUDWithTitle: (NSString *)title{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = title;
}

- (void)completeLoadWithTitle:(NSString *)titile{
    MBProgressHUD *hudC = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudC.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark@2x副本"]];
    hudC.square = YES;
    hudC.mode = MBProgressHUDModeCustomView;
    hudC.labelText =titile;
    hudC.removeFromSuperViewOnHide = YES;
    [hudC hide:YES afterDelay:1.5];
}

- (void)hiddenSimpleHUD{
    hud.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
