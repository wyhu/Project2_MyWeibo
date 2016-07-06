//
//  AnotationModel.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/23.
//  Copyright (c) 2015年 imac. All rights reserved.
//


//第一步
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"
@interface AnotationModel : NSObject<MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) WeiboModel *weiboModel;


@end
