//
//  SelfSecondCollectionViewCell.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/20.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SelfSecondCollectionViewCell.h"

@implementation SelfSecondCollectionViewCell




- (void)setModel:(UserModel *)model{
    if (_model!=model) {
        _model=model;
        [self setNeedsLayout];
    }
    
    
}
//
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [_touxiangImgView sd_setImageWithURL:[NSURL URLWithString:_model.profile_image_url]];
    
    _nameLabel.text = _model.screen_name;
    _fensiLabel.text = [NSString stringWithFormat:@"粉丝：%@",_model.followers_count];
    
}




@end
