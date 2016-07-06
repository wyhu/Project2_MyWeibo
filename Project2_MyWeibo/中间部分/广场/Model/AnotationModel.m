
//  AnotationModel.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AnotationModel.h"

@implementation AnotationModel

- (void)setWeiboModel:(WeiboModel *)weiboModel{
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        NSArray *arr = [weiboModel.geo objectForKey:@"coordinates"];
        
        CLLocationCoordinate2D coor = {[arr[0] doubleValue],[arr[1] doubleValue]};

        _coordinate = coor;
        
    }
}

@end
