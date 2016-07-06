//
//  HomeViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboTableView.h"


@interface HomeViewController : BaseViewController
{
    UIView *barView;   //显示新微博的控件
    ThemeImgView *barItem;   //显示新微博的背景
    ThemeLabel *barLabel;   //显示新微博的条数

}

@property (strong, nonatomic) IBOutlet WeiboTableView *tableView;



@end
