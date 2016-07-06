//
//  UserModel.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
/**
 *  特殊处理
 */
- (id)initContentWithDic:(NSDictionary *)jsonDic{
    self = [super initContentWithDic:jsonDic];
    if (self) {
        
        self.userId = [jsonDic objectForKey:@"id"];
        self.user_description = [jsonDic objectForKey:@"description"];
        
        //gender;             //性别，m：男、f：女、n：未知
        NSString *gender = [jsonDic objectForKey:@"gender"];
        
        if ([gender isEqualToString:@"m"]) {
            self.gender = @"男";
        }else if ([gender isEqualToString:@"f"]){
            self.gender = @"女";
        }else if ([gender isEqualToString:@"n"]){
            self.gender = @"未知";
        }
        
        
        
    }
    return self;
}
@end
