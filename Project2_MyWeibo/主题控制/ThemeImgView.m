//
//  ThemeImgView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeImgView.h"

@implementation ThemeImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initNotiRecesive];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initNotiRecesive];
}


//注册成为通知的接受者
- (void)_initNotiRecesive{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImgView) name:kThemeChange object:nil];
    
    
    
}

- (void)setImgName:(NSString *)imgName{
    if (_imgName != imgName) {
        _imgName = [imgName copy];
    
        [self loadImgView];
    }
}


//刷新UI
- (void)loadImgView{
    
    UIImage *image = [[ThemeManager shareThemeType] returnImgWithImgName:self.imgName];
    
    image = [image stretchableImageWithLeftCapWidth:self.cap1 topCapHeight:self.cap2];
    
    
    self.image = image;
    
    
}


//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeChange object:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
