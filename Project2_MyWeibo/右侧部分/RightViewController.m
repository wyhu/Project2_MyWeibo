//
//  RightViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RightViewController.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:kThemeChange object:nil];
    
    [self refreshUI];
}


- (void)refreshUI{
    self.btn1.btnImgName = @"newbar_icon_1.png";
    self.btn2.btnImgName = @"newbar_icon_2.png";
    self.btn3.btnImgName = @"newbar_icon_3.png";
    self.btn4.btnImgName = @"newbar_icon_4.png";
    self.btn5.btnImgName = @"newbar_icon_5.png";
    
}

//设置导航栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if ([ThemeManager shareThemeType].statesBarNum == 0) {
        return UIStatusBarStyleDefault;
    }
    
    
    return UIStatusBarStyleLightContent;
}








@end
