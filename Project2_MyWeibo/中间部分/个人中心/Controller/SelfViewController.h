//
//  SelfViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface SelfViewController : BaseViewController

{
    
    
    IBOutlet UIView *_bgView;
    
    IBOutlet UIImageView *_bgImgView;
    
    
    IBOutlet UIImageView *_touxiangImgView;
    
    
    IBOutlet UILabel *_nameLabel;
    
    
    IBOutlet UILabel *_xingbieLabel;
    
    
    IBOutlet UILabel *_jianjieLabel;
    
    IBOutlet UILabel *_guanzhuLabel;
    
    
    IBOutlet UILabel *_fensiLabel;
    
    
    IBOutlet UIButton *_guanzhuBtn;
    
    
    IBOutlet UIButton *_fensiBtn;
    
    
    IBOutlet UIButton *_gengduoBtn;
    
    IBOutlet UIButton *_ziliaoBtn;
    
}

@property (nonatomic,strong) UserModel *model;



@end
