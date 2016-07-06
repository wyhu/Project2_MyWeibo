//
//  WeiboTableView.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/15.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableView : UITableView<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,copy) NSArray *data;


@end
