//
//  CostumMKAnnotationView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CostumMKAnnotationView : MKAnnotationView<WXLabelDelegate>

{
    //微博图片背景
    UIImageView *_weiboImgView;
    
    //头像视图
    UIImageView *_touxiangImgView;
    
    //文字label
    WXLabel *_wxLabel;
    
    
}




@end
