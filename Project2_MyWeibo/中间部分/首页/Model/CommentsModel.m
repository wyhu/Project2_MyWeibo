//
//  CommentsModel.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CommentsModel.h"

@implementation CommentsModel

- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        //特殊处理
        self.commentID = [jsonDic objectForKey:@"id"];
        
        self.user = [[UserModel alloc] initContentWithDic:[jsonDic objectForKey:@"user"]];
        
    }
    return self;
}

@end
