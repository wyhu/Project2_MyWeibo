//
//  WeiboModel.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
#import "FaceTextExchange.h"
#import "DateChange.h"
@implementation WeiboModel
//对特殊情况进行处理
- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        //处理微博图文混编
        self.text = [FaceTextExchange getFaceWithText:self.text];
        
        //特殊weiboId
        self.weiboId = [jsonDic objectForKey:@"id"];
        
        //转发用户
        if ([jsonDic objectForKey:@"retweeted_status"]) {
            self.retweeted_status = [[WeiboModel alloc] initContentWithDic:[jsonDic objectForKey:@"retweeted_status"]];
            //在每一条转发微博内容前添加
            NSString *str = [NSString stringWithFormat:@"@%@: %@",self.retweeted_status.user.screen_name,self.retweeted_status.text];
            self.retweeted_status.text = str;
            
            
        }
       
        //用户信息
        if ([jsonDic objectForKey:@"user"]) {
            self.user = [[UserModel alloc] initContentWithDic:[jsonDic objectForKey:@"user"]];
        }
        /**
         *  处理微博来源字段
         */
        //第一种方法，暴力法无脑法
        //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a> --->微博 weibo.com
//        NSRange range1 = [self.source rangeOfString:@">"];
//        self.source = [self.source substringFromIndex:range1.location + 1];
//        NSRange range2 = [self.source rangeOfString:@"<"];
//        self.source = [self.source substringToIndex:range2.location];

        //第二种方式：正则表达式，用到系统自带的方法
//        NSString *regex = @">[.\\w\\s]+<";
        //        NSRegularExpression *regulaer = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
        //
        //        NSArray *array = [regulaer matchesInString:self.source options:NSMatchingReportProgress range:NSMakeRange(0, self.source.length)];
        //
        ////        NSLog(@"%@", array);
        //
        //        if (array.count > 0) {
        //            NSTextCheckingResult *result = array[0];
        //            NSRange range = result.range;
        //
        //            range.location += 1;
        //            range.length -= 2;
        //
        //            self.source = [self.source substringWithRange:range];
        //        }

        
        //第三种方法，需要如第三方框架
        //构造正则表达式
        
        
        NSString *regex = @">[.\\w\\s]+<";
        NSArray *array =[self.source componentsMatchedByRegex:regex];
        if (array.count > 0) {
            NSString *str = array[0];
            NSRange range = {1 ,str.length - 2};
            self.source = [str substringWithRange:range];
        }
        
        /**
         *  处理时间字段
         */
        NSString *formaterStr = @"MM-dd HH:mm";
        self.created_at = [DateChange returnNewDateFormater:self.created_at dateFormater:formaterStr];
        
////        NSLog(@"%@",self.created_at);
//        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
//
//        [inputFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
//        NSDate *new = [inputFormatter dateFromString:self.created_at];
//        // 2015-09-15 11:31:42 +0000
//
////        NSLog(@"%@",new);
//        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//        [outputFormatter setLocale:[NSLocale currentLocale]];
//        [outputFormatter setDateFormat:@"MM-dd HH:mm"];
//        self.created_at = [outputFormatter stringFromDate:new];
////        NSLog(@"%@",self.created_at);
    }

    return self;
}

@end
