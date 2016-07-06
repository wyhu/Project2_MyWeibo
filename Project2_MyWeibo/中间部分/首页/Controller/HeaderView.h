//
//  HeaderView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboCellView.h"
@interface HeaderView : UIView
{
    
    
    IBOutlet UIImageView *_touxiangImgView;
    
        
    IBOutlet UILabel *_nameLabel;
    
    IBOutlet UILabel *detailLabel;
    
        
    
    IBOutlet WeiboCellView *_weiboView;
    
    
}

@property (nonatomic,strong) WeiboModel *model;

@end
