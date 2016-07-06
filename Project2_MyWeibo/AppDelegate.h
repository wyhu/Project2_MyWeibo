//
//  AppDelegate.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeiboDelegate <NSObject>

- (void)refreshTableView;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic,weak) id<WeiboDelegate>weiboDelegate;

@end

