//
//  ThemeManager.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *hehe = nil;
@implementation ThemeManager
{
    NSUserDefaults *userDefaults;
}

//构造初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {

        //数据持久化
        userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *str = [userDefaults objectForKey:@"themeName"];
        
        if (str.length == 0) {
            //此处注意，不可写self.themeName,防止循环调用
            _themeName = @"FishEye";
        }else{
            _themeName = [userDefaults objectForKey:@"themeName"];
        }
        
        //拿到对应的主题路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themeDic = [NSDictionary dictionaryWithContentsOfFile:filePath];

        //刷新状态栏
        [self refreshStatesBar];
        
    }
    return self;
}



//构造主题单例对象
+ (instancetype)shareThemeType{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hehe = [[ThemeManager alloc] init];
    });
    return hehe;
}


/**
 *  构造方法，通过一个图片名称，返回一张图片
 *
 *  @param imgName 图片名称
 *
 *  @return 返回一个图片
 */

- (UIImage *)returnImgWithImgName: (NSString *)imgName{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@/%@",_themeDic[_themeName],imgName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
        return image;
}

//构造方法，通过一个字体类型，放回一个颜色类型

- (UIColor *)returnColorWithColorText: (NSString *)colorText{
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@/config.plist",_themeDic[_themeName]];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:str];

    NSDictionary *dic1 = [dic objectForKey:colorText];


    
    CGFloat alp = dic1.count>=4? [[dic1 objectForKey:@"alpha"] floatValue] : 1.0;
    
    UIColor *color = [UIColor colorWithRed:[[dic1 objectForKey:@"R"] floatValue] / 255.0 green:[[dic1 objectForKey:@"G"] floatValue] / 255.0 blue:[[dic1 objectForKey:@"B"] floatValue] / 255.0 alpha:alp];
    
    
    return color;
}


- (void)setThemeName:(NSString *)themeName{
    if (_themeName != themeName) {
        _themeName = themeName;
        //刷新状态栏
        [self refreshStatesBar];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChange object:nil];
        
        [userDefaults setValue:_themeName forKey:@"themeName"];
        [userDefaults synchronize];
        
        
        
    }

}

//刷新状态栏
- (void)refreshStatesBar{
    
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@/config.plist",_themeDic[_themeName]];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:str];
    NSNumber *num = [dic objectForKey:@"Statusbar_Style"];
    self.statesBarNum = [num integerValue];
    
    
    
}


@end
