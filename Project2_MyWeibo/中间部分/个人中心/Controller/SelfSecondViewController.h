//
//  SelfSecondViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/20.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface SelfSecondViewController : BaseViewController
{
    
    IBOutlet UICollectionView *_collectionView;
}

@property (nonatomic,copy) NSString *httpStr;

@property (nonatomic,copy) NSString *name;
@end
