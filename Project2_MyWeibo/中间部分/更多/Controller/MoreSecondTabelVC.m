//
//  MoreSecondTabelVC.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreSecondTabelVC.h"

@interface MoreSecondTabelVC ()
{
    NSArray *arr;
    NSIndexPath *_lastIndexPath;
}
@end

@implementation MoreSecondTabelVC

- (void)viewDidLoad {
    self.title = @"主题选择";

    [super viewDidLoad];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"theme.plist" ofType:nil];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    arr = [dic allKeys];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_initBG) name:kThemeChange object:nil];
    [self _initBG];
}


- (void)_initBG{
    UIImage *image = [[ThemeManager shareThemeType] returnImgWithImgName:@"bg_home.jpg"];
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth, kScreenHeight * 2));
    [image drawInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    self.tableView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //标题
    ThemeLabel *titltLabe = [[ThemeLabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    titltLabe.textAlignment = NSTextAlignmentCenter;
    titltLabe.text = self.navigationItem.title;
    titltLabe.font = [UIFont boldSystemFontOfSize:22];
    titltLabe.textColorName = @"Mask_Title_color";
    self.navigationItem.titleView = titltLabe;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nihao" forIndexPath:indexPath];
    
        if (indexPath.row == _lastIndexPath.row&&_lastIndexPath!=nil) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }else{
            
            cell.accessoryType=UITableViewCellAccessoryNone;
        }

    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

//当单元格被选择时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = arr[indexPath.row];
    
    [ThemeManager shareThemeType].themeName = str;
    
    //拿到上一次被选择的单元格

    if (_lastIndexPath != nil) {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:_lastIndexPath];
        lastCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    //拿到被选择的单元格
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    _lastIndexPath = indexPath;
    
    [tableView reloadData];
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = [ThemeManager shareThemeType].themeName;
         NSInteger count = [arr indexOfObject:str];
    if (indexPath.row == count) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
}







/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
