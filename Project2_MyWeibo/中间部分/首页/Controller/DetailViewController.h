//
//  DetailViewController.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
@interface DetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) WeiboModel *model;


@end
