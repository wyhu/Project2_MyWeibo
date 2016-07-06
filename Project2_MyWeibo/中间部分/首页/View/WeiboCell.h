//
//  WeiboCell.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/15.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboCellView.h"
@interface WeiboCell : UITableViewCell
{
    IBOutlet UIImageView *bg_imgView;
    
    IBOutlet UIButton *touxiangBtn;
    
    
    IBOutlet UIButton *_repostBtn;
    
    IBOutlet UIButton *_commentBtn;
    
    
    IBOutlet UIButton *_goodBtn;
    
    IBOutlet UILabel *_nameLabel;
    
    IBOutlet UILabel *_sourceLabel;
    
    
    
    IBOutlet UILabel *_timeLabel;
    
    //中间内容UIview
    WeiboCellView *_weiboCellView;

    
    
    
}

@property (nonatomic,strong) WeiboModel *model;
@end
