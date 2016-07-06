//
//  DateChange.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DateChange.h"

@implementation DateChange
+ (NSString *)returnNewDateFormater: (NSString *)date dateFormater: (NSString *)dateFormater
{
    /**
     *  处理时间字段
     */
    //        NSLog(@"%@",self.created_at);
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    
    [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *new = [inputFormatter dateFromString:date];
    // 2015-09-15 11:31:42 +0000
    

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:dateFormater];
    date = [outputFormatter stringFromDate:new];
    
    
    return date;
}
@end
