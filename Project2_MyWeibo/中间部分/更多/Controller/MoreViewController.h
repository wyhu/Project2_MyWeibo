//
//  MoreViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : UITableViewController

@property (strong, nonatomic) IBOutlet ThemeLabel *rightLabel;
@property (strong, nonatomic) IBOutlet ThemeImgView *imgView1;

@property (strong, nonatomic) IBOutlet ThemeImgView *imgView2;


@property (strong, nonatomic) IBOutlet ThemeImgView *imgView3;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UILabel *cancceLabel;


@end
