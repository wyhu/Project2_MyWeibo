//
//  MixedFaceView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MixedFaceView.h"

@implementation MixedFaceView

//表情所在item的宽高
#define item_width (kScreenWidth / 7.0)
#define item_height (kScreenWidth / 7.0)

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initMixedView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initMixedView];
}

- (void)_initMixedView{
    self.width = kScreenWidth;
    self.height = item_height * 4 + 20;
    
    //初始化滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 4, self.height);
    _scrollView.clipsToBounds = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor clearColor];
    
    //初始化图片视图
    _faceView = [[FaceView alloc] initWithFrame:CGRectZero];
    _faceView.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_faceView];
    
    //初始化页码控制器
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _faceView.bottom, kScreenWidth, 20)];

    _pageCtrl.numberOfPages = _faceView.width / kScreenWidth;
    
    _pageCtrl.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_pageCtrl];
    [self addSubview:_scrollView];

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageCtrl.currentPage = scrollView.contentOffset.x / kScreenWidth;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIImage *img = [UIImage imageNamed:@"emoticon_keyboard_background.png"];
    
    [img drawInRect:CGRectMake(0, 0, self.width, self.height)];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
