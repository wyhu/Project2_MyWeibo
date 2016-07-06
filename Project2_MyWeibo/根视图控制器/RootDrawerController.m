//
//  RootDrawerController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RootDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"



#import "MMDrawerBarButtonItem.h"



#import "HomeViewController.h"
@interface RootDrawerController ()

@end

@implementation RootDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //从story中拿到三个视图
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //左侧视图
    self.leftDrawerViewController = [storyBoard instantiateViewControllerWithIdentifier:@"leftVC"];
    //中间视图
    self.centerViewController = [storyBoard instantiateViewControllerWithIdentifier:@"centerVC"];
    //右侧视图
    self.rightDrawerViewController = [storyBoard instantiateViewControllerWithIdentifier:@"rightVC"];
    
    //设置阴影
    self.showsShadow = YES;
    

    //设置左边视图的宽度
    self.maximumLeftDrawerWidth = 160.0;
    
    //设置右边视图的宽的
    self.maximumRightDrawerWidth = 60.0;
    
    //为其配置动画
    [self setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
        
        
    }];
    
    //配置动画类型
    /*
     NS_ENUM(NSInteger, MMDrawerAnimationType){
     MMDrawerAnimationTypeNone,
     MMDrawerAnimationTypeSlide,
     MMDrawerAnimationTypeSlideAndScale,
     MMDrawerAnimationTypeSwingingDoor,
     MMDrawerAnimationTypeParallax,

     */
    NSNumber *indexNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"indexNum"];
    if (indexNum == nil) {
        [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeNone];
        [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeNone];
        
    }else{
        [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:[indexNum integerValue]];
        [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:[indexNum integerValue]];
    }
    
    
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
