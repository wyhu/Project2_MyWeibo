//
//  DateChange.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateChange : NSObject
/**
 *  根据制定格式返回时间格式
 *
 *  @param dateFormater <#dateFormater description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)returnNewDateFormater: (NSString *)date dateFormater: (NSString *)dateFormater;

@end
