//
//  ThemeBtn.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeBtn.h"

@implementation ThemeBtn

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


- (void)setBtnImgName:(NSString *)btnImgName{
    if (_btnImgName != btnImgName) {
        _btnImgName = [btnImgName copy];
        [self loadImgView];
    }
}
//刷新UI

- (void)loadImgView{
    //普通状态

    UIImage *image = [[ThemeManager shareThemeType] returnImgWithImgName:self.btnImgName];
    //高亮状态
    UIImage *image1 = [[ThemeManager shareThemeType] returnImgWithImgName:self.btnHighImgName];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image1 forState:UIControlStateHighlighted];
    
    
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
