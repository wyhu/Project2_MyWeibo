//
//  WeiboCell.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/15.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboCell.h"
#import "UserModel.h"
#import "SelfViewController.h"
@implementation WeiboCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    //设置公有属性
    touxiangBtn.layer.cornerRadius = 10.0;
    touxiangBtn.layer.masksToBounds = YES;
    
    UIImage *image = [UIImage imageNamed:@"userinfo_shadow_pic"];
    image = [image stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    bg_imgView.image = image;
    bg_imgView.userInteractionEnabled = NO;
    
    //初始化中间内容
    _weiboCellView = [[WeiboCellView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboCellView];
    
}


- (void)setModel:(WeiboModel *)model{
    if (_model !=model) {
        _model = model;
        [super setNeedsLayout];
    }
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //拿到用户数据
    UserModel *userModel = self.model.user;
    //头像
    [touxiangBtn sd_setImageWithURL:[NSURL URLWithString:userModel.profile_image_url] forState:UIControlStateNormal];
    //用户名
    _nameLabel.text = userModel.screen_name;
    
    //转发，评论，和赞
    NSString *str1= [NSString stringWithFormat:@"转发：%@",self.model.reposts_count];
    [_repostBtn setTitle:str1 forState:UIControlStateNormal];
    NSString *str2= [NSString stringWithFormat:@"评论：%@",self.model.comments_count];
    [_commentBtn setTitle:str2 forState:UIControlStateNormal];
    NSString *str3= [NSString stringWithFormat:@"赞：%@",self.model.attitudes_count];
    [_goodBtn setTitle:str3 forState:UIControlStateNormal];
    
    //来源
//    _sourceLabel.text = self.model.source;
    _sourceLabel.text = [NSString stringWithFormat:@"来自 %@",self.model.source];
    //时间
    _timeLabel.text = self.model.created_at;
    
    //定义中间视图内容
    _weiboCellView.frame = CGRectMake(20, 80, self.width - 40, self.height - 80 - 50);
    
    _weiboCellView.backgroundColor = [UIColor clearColor];

    _weiboCellView.model = self.model;
    
}


- (IBAction)btnAction:(id)sender {
    UIStoryboard *sb  =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelfViewController *selfVC = [sb instantiateViewControllerWithIdentifier:@"selfVC"];
    selfVC.model =self.model.user;
    
    [[self viewController].navigationController pushViewController:selfVC animated:YES];

    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
