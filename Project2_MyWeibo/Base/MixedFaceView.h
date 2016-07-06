//
//  MixedFaceView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"
@interface MixedFaceView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageCtrl;
    FaceView *_faceView;
}
@property (nonatomic,copy) FaceViewBlock block;

@property (nonatomic,strong) FaceView *faceView;

@end
