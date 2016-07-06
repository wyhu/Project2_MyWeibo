//
//  DiscoverViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SecondDiscoverViewController.h"
@interface DiscoverViewController ()


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //为按钮添加阴影效果
    _nearbyWeiboBtn.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _nearbyWeiboBtn.layer.shadowRadius = 10.0;
    _nearbyWeiboBtn.layer.shadowOpacity = 0.8;
    
    _nearbyUserBtn.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    _nearbyUserBtn.layer.shadowRadius = 10.0;
    _nearbyUserBtn.layer.shadowOpacity = 0.8;

    
    
    
}

- (IBAction)btnAction:(UIButton *)sender {
    
    SecondDiscoverViewController *secondDisVC = [[SecondDiscoverViewController alloc] init];
    
    if (sender.tag == 200) {
        //附近微博
        secondDisVC.title = @"附近微博";
        secondDisVC.httpStr = @"place/nearby_timeline.json";
    }else{
        //附近的人
        secondDisVC.title = @"附近的人";
        secondDisVC.httpStr = @"place/nearby_timeline.json";
    }

    
    
    [self.navigationController pushViewController:secondDisVC animated:YES];
    
}












@end
