//
//  SecondDiscoverViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface SecondDiscoverViewController : BaseViewController<MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, copy) NSString *httpStr;

@end
