//
//  BaseViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController


- (void)showSimpleHUDWithTitle: (NSString *)title;

- (void)completeLoadWithTitle:(NSString *)titile;
- (void)hiddenSimpleHUD;


@end
