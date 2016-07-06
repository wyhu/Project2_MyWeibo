//
//  SelfSecondViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/20.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SelfSecondViewController.h"
#import "SelfSecondCollectionViewCell.h"
#import "SelfViewController.h"
@interface SelfSecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_data;
}
@end

@implementation SelfSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self _loadData];
    
}
- (void)_loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.name forKey:@"screen_name"];
    
//    [params setObject:@152 forKey:@"count"];
    
    [DataService requestURL:self.httpStr params:params httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        NSArray *array = [result objectForKey:@"users"];
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            UserModel *userModel = [[UserModel alloc] initContentWithDic:dic];
            [mArr addObject:userModel];
        }
        
        _data = mArr;
        [_collectionView reloadData];
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
}

//定义行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelfSecondCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 10.0;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.model = _data[indexPath.row];
    return cell;
    
}
//单元格被点击的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb  =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelfViewController *selfVC = [sb instantiateViewControllerWithIdentifier:@"selfVC"];
    selfVC.model = _data[indexPath.row];
    [self.navigationController pushViewController:selfVC animated:YES];
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
