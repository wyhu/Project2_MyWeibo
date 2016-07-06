//
//  FaceTextExchange.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceTextExchange : NSObject

/**
 *  此方法可进行图文交换
 *
 *  @param text 传进来的图文文本  [呵呵]
 *
 *  @return 返回替换的文本   <image url = '00x.png'>
 */

+ (NSString *)getFaceWithText: (NSString *)text;

@end
