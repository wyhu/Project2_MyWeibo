//
//  FaceView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceDelegaet <NSObject>

- (void)textChange:(NSString *)imgName;

@end


typedef void(^FaceViewBlock)(NSString *imgName);


@interface FaceView : UIView

{
    NSMutableArray *_faceMArr;
    
    UIImageView *_fangdaImgView;//放大镜所在视图
    
    NSString *_laxtImgName;
}
@property (nonatomic,weak) id<FaceDelegaet> delegate;
@property (nonatomic,copy) FaceViewBlock block;


@end
