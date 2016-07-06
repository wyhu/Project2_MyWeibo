//
//  WeiboCellView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "ZoomImageView.h"
@interface WeiboCellView : UIView<WXLabelDelegate>

{
    //我的微博内容
    WXLabel * _weiboLabel;
    //转发微博内容
    WXLabel *_reposetWeiboLabel;
    //转发微博背景
    ThemeImgView *_reposetImgView;
    
    //微博图片
    ZoomImageView *_weiboImgView;
    
    BOOL _isDetail;
    
}
//数据源
@property (nonatomic,strong) WeiboModel *model;
@property (nonatomic,assign) BOOL isDetail;

@end
