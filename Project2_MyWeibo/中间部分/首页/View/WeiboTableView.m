//
//  WeiboTableView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/15.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "DetailViewController.h"
@implementation WeiboTableView
{
    NSIndexPath *_indexPath;
    CGFloat _rowHeight;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self _initTabelView];
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initTabelView];
}

- (void)_initTabelView{
    self.delegate = self;
    self.dataSource = self;
    
}



//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}
//定义单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *indetifer = @"hehe";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifer];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WeiboCell" owner:nil options:nil] lastObject];
    }
    
    WeiboModel *model = _data[indexPath.row];
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //定义一个基准高度
    CGFloat baseHeight = 130;
    
    //获得微博内容
    WeiboModel * model = _data[indexPath.row];
    
    
    
    //初始化我的微博
    NSString *text = model.text;
    
    CGFloat textHeight = [WXLabel getAttributedStringHeightWithString:text WidthValue:self.width - 40 delegate:nil font:[UIFont systemFontOfSize:14]];
    baseHeight += textHeight + 10;
    
    //判断是否有转发微博
    if (model.retweeted_status != nil) {
        //有转发微博
        NSString *reText = model.retweeted_status.text;

        CGFloat reTextHeight = [WXLabel getAttributedStringHeightWithString:reText WidthValue:self.width - 20 - 40 delegate:nil font:[UIFont systemFontOfSize:12]];
        
        baseHeight += reTextHeight + 10;
        
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
    
    
    return baseHeight + 10;
}

#pragma  mark 单元格被点击触发时间

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //push到下一个界面
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailVC = [storyBoard instantiateViewControllerWithIdentifier:@"detailVC"];
    detailVC.title = @"微博详情";
    detailVC.model = _data[indexPath.row];
    
    [[self viewController].navigationController pushViewController:detailVC animated:YES];
    
    
    [tableView reloadData];
}



@end
