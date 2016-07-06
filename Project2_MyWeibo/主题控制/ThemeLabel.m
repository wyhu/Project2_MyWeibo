//
//  ThemeLabel.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel

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

-(void)setTextColorName:(NSString *)textColorName{
    if (_textColorName != textColorName) {
        _textColorName = textColorName;
        [self loadImgView];
    }
}
//刷新UI
- (void)loadImgView{
    UIColor *textColor = [[ThemeManager shareThemeType] returnColorWithColorText:self.textColorName];
    self.textColor = textColor;
    
}


//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeChange object:nil];
}


@end
