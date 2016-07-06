//
//  BaseNavigationController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseNavigationController.h"
#import "WXNavigationController.h"
@interface WXNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initNavigationController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_initNavigationController) name:kThemeChange object:nil];
    
    
}
//自定义导航栏
- (void)_initNavigationController{
    self.delegate = self;
    //取消导航栏透明状态
    self.navigationBar.translucent = NO;
    //自定义导航栏的背景
    
    UIImage *img = [[ThemeManager shareThemeType] returnImgWithImgName:@"mask_detailbar.png"];
    
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, 64));
    [img drawInRect:CGRectMake(0, 0, kScreenWidth, 84)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
    //刷新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
    
}
//push隐藏标签栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger count = self.viewControllers.count;

    UIImageView *imgView = (UIImageView *)[self.tabBarController.view viewWithTag:1234];
    
    
    if (count == 1) {
        
        imgView.hidden = NO;
//        imgView.right = kScreenWidth;
        
                    }else if(count == 2){
        imgView.hidden = YES;
//                        imgView.right = 0;

                    }
}



- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if ([ThemeManager shareThemeType].statesBarNum == 0) {
        return UIStatusBarStyleDefault;
    }
    
    
    return UIStatusBarStyleLightContent;
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
