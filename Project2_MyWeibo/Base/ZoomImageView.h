//
//  ZoomImageView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/21.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDProgressView.h"

@protocol ZoomDelegate <NSObject>

- (void)becomeFirst;
- (void)LostFirst;

@end


@interface ZoomImageView : UIImageView
{
    UIScrollView *_scrollView;//放大后的滑动视图
    
    UIImageView *_zoomOutImgView;//放大后的imgView
    NSString *_imgUrlStr;
    
    DDProgressView *_progressView;
    
}

@property (nonatomic,weak) id<ZoomDelegate>zoomDelegate;


- (void)addZoomTapWithImgURL:(NSString *)imgUrlStr;




@end
