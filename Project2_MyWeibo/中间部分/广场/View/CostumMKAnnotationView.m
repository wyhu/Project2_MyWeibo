//
//  CostumMKAnnotationView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CostumMKAnnotationView.h"
#import "AnotationModel.h"
#import "WeiboModel.h"
#import "DetailViewController.h"
@implementation CostumMKAnnotationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}



- (void)_initViews
{
    //构造微博图片背景
    _weiboImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview: _weiboImgView];
    
    //构造微博头像
    _touxiangImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _touxiangImgView.layer.borderWidth = 1;
    _touxiangImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:_touxiangImgView];

    
    //构造文字label
    _wxLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _wxLabel.numberOfLines = 3;
    _wxLabel.font = [UIFont systemFontOfSize:12];
    _wxLabel.wxLabelDelegate = self;
    [self addSubview:_wxLabel];
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    WeiboModel *weiboModel = nil;
    
    if ([self.annotation isKindOfClass:[AnotationModel class]]) {
        
       AnotationModel *anotationModel =  (AnotationModel *)self.annotation;
        weiboModel = anotationModel.weiboModel;
        
    }
    
    if (weiboModel.bmiddle_pic.length == 0) {
        //没有图片
        self.image = [UIImage imageNamed:@"nearby_map_content"];

        _weiboImgView.hidden = YES;
        
        _touxiangImgView.frame = CGRectMake(18, 18, 48, 48);
        [_touxiangImgView sd_setImageWithURL:[NSURL URLWithString:weiboModel.user.profile_image_url]];
        
        _wxLabel.hidden = NO;
        
        _wxLabel.frame = CGRectMake(_touxiangImgView.right + 5, _touxiangImgView.top, 110, _touxiangImgView.height);
        _wxLabel.backgroundColor = [UIColor clearColor];
        _wxLabel.textColor = [UIColor whiteColor];
        _wxLabel.text = weiboModel.text;
        
    }else{
        //有图片
        _wxLabel.hidden = YES;
        _weiboImgView.hidden = NO;

        self.image = [UIImage imageNamed:@"nearby_map_photo_bg"];
        _weiboImgView.frame = CGRectMake(15, 15, 90, 85);
        _touxiangImgView.frame = CGRectMake(_weiboImgView.right - 33, _weiboImgView.bottom - 33, 30, 30);
        [_weiboImgView sd_setImageWithURL:[NSURL URLWithString:weiboModel.bmiddle_pic]];
        
        [_touxiangImgView sd_setImageWithURL:[NSURL URLWithString:weiboModel.user.profile_image_url]];
        
        
    }

    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    WeiboModel *weiboModel = nil;
    if ([self.annotation isKindOfClass:[AnotationModel class]]) {
        AnotationModel *weiboAnnotation = (AnotationModel *)self.annotation;
        weiboModel = weiboAnnotation.weiboModel;
    }else {
        return;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailVC = [storyBoard instantiateViewControllerWithIdentifier:@"detailVC"];
    detailVC.title = @"微博详情";
    detailVC.model = weiboModel;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
