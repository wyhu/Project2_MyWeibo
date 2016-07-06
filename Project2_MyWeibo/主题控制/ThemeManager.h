//
//  ThemeManager.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

@property (nonatomic,copy) NSString *themeName;//主题名称
/**
 *  主题路径对应的字典
 */
@property (nonatomic ,strong) NSDictionary *themeDic;//主题路径对应字典

//状态栏颜色
@property (nonatomic, assign) NSInteger statesBarNum;




//构造主题单例对象
+ (instancetype)shareThemeType;


//构造方法，通过一个图片名称，返回一张图片
- (UIImage *)returnImgWithImgName: (NSString *)imgName;

//构造方法，通过一个字体类型，放回一个颜色类型
- (UIColor *)returnColorWithColorText: (NSString *)colorText;



@end
