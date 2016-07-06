//
//  WeiboCellView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboCellView.h"
#import "UIView+ViewContorller.h"
#import "SecondViewController.h"
@implementation WeiboCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initView];
}

- (void)setModel:(WeiboModel *)model{
    if (_model == nil) {
        _model = model;
        [self setNeedsLayout];
    }
}

/**
 *  初始化uiview
 */
- (void)_initView{
    //转发微博背景
    _reposetImgView = [[ThemeImgView alloc] initWithFrame:CGRectZero];
    _reposetImgView.cap1 = 25;
    _reposetImgView.cap2 =25;
    
    _reposetImgView.imgName = @"timeline_rt_border_9.png";
//    _reposetImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_reposetImgView];
    
    //转发微博内容
    _reposetWeiboLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _reposetWeiboLabel.wxLabelDelegate = self;
    _reposetWeiboLabel.backgroundColor  = [UIColor clearColor];
    [self addSubview:_reposetWeiboLabel];
    
    //微博图片
    _weiboImgView = [[ZoomImageView alloc] initWithFrame:CGRectZero];

    [self addSubview:_weiboImgView];
    
    //我的微博内容
    _weiboLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _weiboLabel.wxLabelDelegate = self;
//    _weiboLabel.numberOfLines = 0;
    _weiboLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_weiboLabel];

    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //初始化我的微博
    NSString *text = self.model.text;
    
    CGFloat textHeight = [WXLabel getAttributedStringHeightWithString:text WidthValue:self.width delegate:self font:[UIFont systemFontOfSize:WB(_isDetail)]];
    
    _weiboLabel.frame = CGRectMake(0, 10, self.width, textHeight);
    _weiboLabel.font = [UIFont systemFontOfSize:WB(_isDetail)];
    _weiboLabel.text = self.model.text;
    
    //判断是否有转发微博
    if (self.model.retweeted_status != nil) {
        //有转发微博
        _reposetImgView.hidden = NO;
        _reposetWeiboLabel.hidden = NO;
        
        
        
        
        NSString *reText = self.model.retweeted_status.text;

        CGFloat reTextHeight = [WXLabel getAttributedStringHeightWithString:reText WidthValue:self.width - 20 delegate:self font:[UIFont systemFontOfSize:R_WB(_isDetail)]];
        
        
        _reposetWeiboLabel.frame = CGRectMake(10, _weiboLabel.bottom + 10, self.width - 20, reTextHeight);

        _reposetWeiboLabel.font = [UIFont systemFontOfSize:R_WB(_isDetail)];
        _reposetWeiboLabel.text = self.model.retweeted_status.text;
        
        //判断转发的微博中是否有图片
        if (self.model.retweeted_status.bmiddle_pic.length != 0) {
            //有图片
            _weiboImgView.hidden = NO;

            _weiboImgView.frame = CGRectMake(15, _reposetWeiboLabel.bottom + 10, kWeiboImgWidth, kWeiboImgWidth);
            _weiboImgView.contentMode = UIViewContentModeScaleAspectFit;
            [_weiboImgView sd_setImageWithURL:[NSURL URLWithString:self.model.retweeted_status.bmiddle_pic]];
            //添加点击放大缩小手势
            [_weiboImgView addZoomTapWithImgURL:self.model.retweeted_status.original_pic];
            
            
            
        }else{
            //没有图片
            _weiboImgView.hidden = YES;
        }
        
        //处理转发微博背景图片
        //主要是高度
        CGFloat height = 0;
        if (self.model.retweeted_status.bmiddle_pic.length != 0) {
            //有图

            height = _reposetWeiboLabel.height + kWeiboImgWidth + 30;
            
        }else{
            //无图
            height = _reposetWeiboLabel.height +20;
        }
                _reposetImgView.frame = CGRectMake(5, _weiboLabel.bottom, self.width - 10, height);
        
    }else{
        //没有转发微博
        _reposetImgView.hidden = YES;
        _reposetWeiboLabel.hidden = YES;
        //判断是否有图片
        if (self.model.bmiddle_pic.length != 0) {
            //有图片

            _weiboImgView.hidden = NO;
            _weiboImgView.frame = CGRectMake(0, _weiboLabel.bottom + 10, kWeiboImgWidth, kWeiboImgWidth);
            _weiboImgView.contentMode = UIViewContentModeScaleAspectFit;
            [_weiboImgView sd_setImageWithURL:[NSURL URLWithString:self.model.bmiddle_pic]];
            //添加点击放大缩小手势
            [_weiboImgView addZoomTapWithImgURL:self.model.retweeted_status.original_pic];
            
            
        }else{
            //没有图片
            _weiboImgView.hidden = YES;
        }
    }
}




#pragma mark -WXLabelDelegate

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel
{
    return [UIColor blueColor];
}
//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel
{
    return [UIColor redColor];
}


//手指离开当前超链接文本响应的协议方法
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context
{
    NSLog(@"离开当前超链接文本:%@", context);
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.url = context;

    [[self viewController].navigationController pushViewController:secondVC animated:YES];
    
    
}


//手指接触当前超链接文本响应的协议方法
- (void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context
{
    NSLog(@"接触当前超链接文本:%@", context);

}


@end
