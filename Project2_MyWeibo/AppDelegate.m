//
//  AppDelegate.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.    
    
    
    //设置windows的背景
    ThemeImgView *imgView = [[ThemeImgView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgView.imgName = @"mask_bg.jpg";

    [self.window addSubview:imgView];
    
    /**
     构造新浪微博对象
     :returns: 
     */
    _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        
        NSLog(@"%@",_sinaWeibo.accessToken)
              ;
              _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    
    return YES;
}



- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"已经登陆");
    [self storeAuthData];
    
    
    if ([self.weiboDelegate respondsToSelector:@selector(refreshTableView)]) {
        [self.weiboDelegate refreshTableView];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accountChange" object:nil];
    
}



- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"已经退出登录");
    [self storeAuthData];
    if ([self.weiboDelegate respondsToSelector:@selector(refreshTableView)]) {
        [self.weiboDelegate refreshTableView];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accountChange" object:nil];
    
    
    
}
//存储登陆信息
- (void)storeAuthData
{
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _sinaWeibo.accessToken, @"AccessTokenKey",
                              _sinaWeibo.expirationDate, @"ExpirationDateKey",
                              _sinaWeibo.userID, @"UserIDKey",
                              _sinaWeibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
