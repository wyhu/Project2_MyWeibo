//
//  HeaderView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HeaderView.h"
#import "UserModel.h"
@implementation HeaderView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initHeaderView];
}
- (void)_initHeaderView{
    
    //设置公有属性
    _touxiangImgView.layer.cornerRadius = 10.0;
    _touxiangImgView.layer.masksToBounds = YES;

    [detailLabel sizeToFit];
    
    _weiboView.isDetail = YES;

}

- (void)setModel:(WeiboModel *)model{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
        _weiboView.model = _model;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //拿到用户数据
    UserModel *userModel = self.model.user;
    //头像    
    [_touxiangImgView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_hd]];
        
    
    
    //用户名
    _nameLabel.text = userModel.screen_name;

    //描述界面
    detailLabel.text = userModel.user_description;
    

    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
