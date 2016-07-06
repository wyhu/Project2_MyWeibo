//
//  SelfSecondCollectionViewCell.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/20.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfSecondCollectionViewCell : UICollectionViewCell
{
    
    IBOutlet UIImageView *_touxiangImgView;
    
    
    IBOutlet UILabel *_nameLabel;
    
    
    IBOutlet UILabel *_fensiLabel;
    
}

@property (nonatomic,strong) UserModel *model;
@end
