//
//  LeftViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LeftViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    NSIndexPath *_lastIndexPath;
    NSArray *_data;
    NSUserDefaults *userDefaults;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    _tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    _tableView.scrollEnabled = NO;
    
    //构造数据
    _data = @[@[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差"],@[@"小图",@"大图"]];

}

//定义组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _data[section];
    return arr.count;
    
}


//定义单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
    NSArray *array = _data[indexPath.section];
    
    cell.textLabel.text = array[indexPath.row];
    
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if (indexPath.section == 0) {
        //动画切换
        NSNumber *indexNum = [userDefaults objectForKey:@"indexNum"];
        if (indexPath.row == [indexNum integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    }else if (indexPath.section == 1){
        //图片浏览模式
        NSNumber *indexPic = [userDefaults objectForKey:@"indexPic"];
        
        if (indexPath.row == [indexPic integerValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        
    }
    
    
    
    return cell;
    
}


//定义头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//定义头视图的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (section == 0) {
        label.text = @"界面效果切换";
    }else if (section == 1){
        label.text = @"图片浏览模式";
    }
    return label;
}

//单元格被点击的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_lastIndexPath != nil) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:_lastIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    
    _lastIndexPath = indexPath;
    
    if (indexPath.section == 0) {
        
        [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:indexPath.row];
        [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:indexPath.row];
        userDefaults = [NSUserDefaults standardUserDefaults];
        NSNumber *indexNum = [NSNumber numberWithInteger:indexPath.row];
        [userDefaults setObject:indexNum forKey:@"indexNum"];
        [userDefaults synchronize];
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0 ) {
            NSLog(@"小图");
        }else if(indexPath.row == 1){
            NSLog(@"大图");
        }
        
        [userDefaults setObject:@(indexPath.row) forKey:@"indexPic"];
        //切换大下图的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"picExchange" object:nil];
        
        NSLog(@"%f",kWeiboImgWidth);
        
    }
    
    [tableView reloadData];
    
    
}

//设置导航栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if ([ThemeManager shareThemeType].statesBarNum == 0) {
        return UIStatusBarStyleDefault;
    }
    
    
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
