//
//  ZoomImageView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/21.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ZoomImageView.h"



@implementation ZoomImageView

- (void)addZoomTapWithImgURL:(NSString *)imgUrlStr{
    //为自己添加点击放大的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutTap:)];
    [self addGestureRecognizer:tap];
    
    //开启点击事件
    self.userInteractionEnabled = YES;
    _imgUrlStr = imgUrlStr;
    
}

#pragma mark 点击放大
- (void)zoomOutTap:(UITapGestureRecognizer *)tap{

    
    
    if ([self respondsToSelector:@selector(LostFirst)]) {
        [self.zoomDelegate LostFirst];
    }
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancleFirst" object:nil];
    if (self.image == nil) {
        return;
    }
    
    [self _initViews];
    
    
    
    //给子视图_fullImageView设置frame
    //获取该视图相对于另一个视图的frame
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    //    NSLog(@"%@", NSStringFromCGRect(rect));
    _zoomOutImgView.frame = rect;
    
    
    //一开始应该让_progressView隐藏
    _progressView.hidden = YES;
    
    //实现放大的动画
    [UIView animateWithDuration:0.35
                     animations:^{
                         //                         _fullImageView.frame = [UIScreen mainScreen].bounds;
                         
                         CGFloat height = kScreenWidth / (self.image.size.width / self.image.size.height);
                         
                         _zoomOutImgView.frame = CGRectMake(0, 0, kScreenWidth, MAX(height, kScreenHeight));
                         
                         _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
                         
                     }
                     completion:^(BOOL finished) {
                         if (_zoomOutImgView == nil) {
                             //没有大图片地址
                             return;
                         }
                         
                         
                         [_zoomOutImgView sd_setImageWithURL:[NSURL URLWithString:_imgUrlStr]
                                           placeholderImage:self.image
                                                    options:SDWebImageRetryFailed
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       
                                                       _progressView.hidden = NO;
                                                       _progressView.progress = (CGFloat)receivedSize / expectedSize;
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      //加载大图完成之后调用的block
                                                      
                                                      [_progressView removeFromSuperview];
                                                      _progressView = nil;
                                                  }];
                     }];

    
    
    
    
}

//初始化视图
- (void)_initViews{
    
    //构造滑动视图
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //往华东视图上面添加点击缩小手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInTap:)];
        [_scrollView addGestureRecognizer:tap];
        
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    [self.window addSubview:_scrollView];
    
    //创建放大视图
    if (_zoomOutImgView == nil) {
        _zoomOutImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _zoomOutImgView.image = self.image;
        _zoomOutImgView.contentMode = self.contentMode;
        
        
    }
    [_scrollView addSubview:_zoomOutImgView];
    
    //初始化进度条
    if (_progressView == nil) {
        _progressView = [[DDProgressView alloc] initWithFrame:CGRectMake(10, (kScreenHeight - 15) / 2, kScreenWidth - 20, 15)];
        
        //设置样式
        _progressView.outerColor = [UIColor redColor];//外边框
        _progressView.innerColor = [UIColor whiteColor];//已加载
        _progressView.emptyColor = [UIColor darkGrayColor];//未加载
        
    }
    
    [self.window addSubview:_progressView];


    
}

#pragma mark 点击缩小
- (void)zoomInTap:(UITapGestureRecognizer *)tap{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sureFirst" object:nil];
    if ([self respondsToSelector:@selector(becomeFirst)]) {
        [self.zoomDelegate becomeFirst];
    }

    
    [_progressView removeFromSuperview];
    _progressView = nil;
    
    //执行缩小的方法
    [UIView animateWithDuration:0.35
                     animations:^{
                         _zoomOutImgView.frame = [self convertRect:self.bounds toView:self.window];
                         _scrollView.backgroundColor = [UIColor clearColor];
                         
                     }
                     completion:^(BOOL finished) {
                         [_zoomOutImgView removeFromSuperview];
                         _zoomOutImgView = nil;
                         
                         [_scrollView removeFromSuperview];
                         _scrollView = nil;
                     }];

    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end

