//
//  FaceTextExchange.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FaceTextExchange.h"
#import "RegexKitLite.h"
@implementation FaceTextExchange


+ (NSString *)getFaceWithText: (NSString *)text{
    //构造正则表达式
    NSString *regex = @"\\[\\w+\\]";
    //筛选text
    NSArray *faceStrArray = [text componentsMatchedByRegex:regex];
    
    //遍历进行匹配
    for (NSString *faceStr in faceStrArray) {
        //[哈哈]
        //拿到资源文件
        NSString *failPath = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
        NSArray *dataArr = [NSArray arrayWithContentsOfFile:failPath];
        
        //构造谓词进行筛选
        //构造筛选条件
        NSString *pre = [NSString stringWithFormat:@"self.chs = '%@'",faceStr];
        //构造谓词
        NSPredicate *predicate = [NSPredicate predicateWithFormat:pre];
        //进行筛选，得到的是字典
        NSArray *preArr = [dataArr filteredArrayUsingPredicate:predicate];
        
        //拿到对应的字典
        if (preArr.count > 0) {
            NSDictionary *dic = preArr[0];
            
             NSString * picName = [dic objectForKey:@"png"];
            
            //拼接处想要的字符串
//            [hehe] <---> <image url = '00x.png'>
            NSString *repleaseName = [NSString stringWithFormat:@"<image url = '%@'>",picName];
            
            text = [text stringByReplacingOccurrencesOfString:faceStr withString:repleaseName];

        }
    }
    
    
    
    
    return text;
}

@end
