//
//  DetailViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DetailViewController.h"
#import "HeaderView.h"
#import "CommentsModel.h"
#import "DateChange.h"
@interface DetailViewController ()
{
    HeaderView *headerView;
    NSArray *_data;//评论列表
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initHeaderView];
    
    [self _initCommentList];
    
    self.tableView.rowHeight = 55;
    
}


- (void)_initCommentList{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:self.model.weiboId forKey:@"id"];
    
    [DataService requestURL:@"comments/show.json" params:params httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        
      NSArray *array = [result objectForKey:@"comments"];
        NSMutableArray *mArr = [NSMutableArray array];

        for (NSDictionary *dic in array) {
            CommentsModel *model = [[CommentsModel alloc] initContentWithDic:dic];
            
            [mArr addObject:model];
        }
        _data = mArr;
        [_tableView reloadData];
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//定义头部视图
- (void)_initHeaderView{
     
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"DetailViewHeaderView" owner:nil options:nil] lastObject];
    headerView.model = _model;
    //定义头部视图的高度
    CGFloat height = [self returnHeight:_model];
    headerView.height = height;
    
    _tableView.tableHeaderView = headerView;

 }
- (CGFloat)returnHeight:(WeiboModel *)model{
    
    //定义一个基准高度
    CGFloat baseHeight = 120;
    
    //初始化我的微博
    NSString *text = model.text;
    
    CGFloat textHeight = [WXLabel getAttributedStringHeightWithString:text WidthValue:self.view.width - 40 delegate:nil font:[UIFont systemFontOfSize:18]];
    baseHeight += textHeight + 10;
    
    //判断是否有转发微博
    if (model.retweeted_status != nil) {
        //有转发微博
        NSString *reText = model.retweeted_status.text;
        
        CGFloat reTextHeight = [WXLabel getAttributedStringHeightWithString:reText WidthValue:self.view.width - 20 - 40 delegate:nil font:[UIFont systemFontOfSize:16]];
        
        baseHeight += reTextHeight + 20;
        
        //判断转发的微博中是否有图片
        if (model.retweeted_status.bmiddle_pic.length != 0) {
            //有图片
            baseHeight += 10 + kWeiboImgWidth;
            
        }else{
            //没有图片
            
        }
        
        
        
    }else{
        //没有转发微博
        //判断是否有图片
        if (model.bmiddle_pic.length != 0) {
            //有图片
            
            baseHeight += kWeiboImgWidth + 10;
            
        }else{
            //没有图片
            
        }
        
        
    }
    return baseHeight;
}
//定义组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

//定义单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifer = @"dddd";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    CommentsModel *model = _data[indexPath.row];
    
    NSString *str = model.user.profile_image_url;

    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"002"]];
    //数据特殊处理
    NSString *str1 = [DateChange returnNewDateFormater:model.created_at dateFormater:@"MM-dd HH:mm"];
    cell.detailTextLabel.text =str1;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.frame = CGRectMake(0, 0, 70, 10);
    cell.textLabel.text =  model.text;
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    return cell;
}
//定义组头视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 30)];
    
    topLabel.text = [NSString stringWithFormat:@"    %ld条评论",_data.count];
    
    topLabel.font = [UIFont boldSystemFontOfSize:20];
    return topLabel;
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
