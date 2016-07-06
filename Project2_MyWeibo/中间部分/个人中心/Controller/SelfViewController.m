//
//  SelfViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SelfViewController.h"
#import "SelfSecondViewController.h"
@interface SelfViewController ()

@end

@implementation SelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

        
    
    [self _initUI];
    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.sinaWeibo.isLoggedIn == 0) {
        //还没有登陆
        [delegate.sinaWeibo logIn];
    }else if (delegate.sinaWeibo.isLoggedIn == 1){
        //已经登录
        if (self.model == nil) {
            //数据为空
            [self _loadData];
            
        }else{
            //数据不为空
            [self returnData];
        }
    }

}
- (void)_initUI{
    //处理背景
    _bgView.top = 20;
    UIImage *bgImg = [UIImage imageNamed:@"userinfo_shadow_pic.png"];
    bgImg = [bgImg stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    _bgImgView.image = bgImg;
    
    //处理按钮
    _guanzhuBtn.titleEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 0);
    _fensiBtn.titleEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 0);
    _guanzhuBtn.layer.cornerRadius = 5.0;
    _guanzhuBtn.layer.masksToBounds = YES;
    
    _fensiBtn.layer.cornerRadius = 5.0;
    _fensiBtn.layer.masksToBounds = YES;

    _ziliaoBtn.layer.cornerRadius = 5.0;
    _ziliaoBtn.layer.masksToBounds = YES;

    _gengduoBtn.layer.cornerRadius = 5.0;
    _gengduoBtn.layer.masksToBounds = YES;


}



- (void)_loadData{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"HU伟亚" forKey:@"screen_name"];

    [DataService requestURL:@"users/show.json" params:params httpMethod:@"GET" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        //构造数据
        _model = [[UserModel alloc] initContentWithDic:result];
        
        [self returnData];
        
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

- (void)returnData{
    [_touxiangImgView sd_setImageWithURL:[NSURL URLWithString:_model.profile_image_url]];
    _nameLabel.text = _model.screen_name;
    _xingbieLabel.text = [NSString stringWithFormat:@"%@ %@",_model.gender,_model.location];
    
    
    _jianjieLabel.text = _model.user_description;
    _fensiLabel.text = [NSString stringWithFormat:@"%@",_model.followers_count];
    _guanzhuLabel.text = [NSString stringWithFormat:@"%@",_model.friends_count];
}




- (IBAction)guanzhuBtnAction:(id)sender {
    
    UIStoryboard *sb  =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelfSecondViewController *selfSecondVC = [sb instantiateViewControllerWithIdentifier:@"selfSecondVC"];
    
    selfSecondVC.name = _model.screen_name;
    
    if (selfSecondVC.name == nil) {
        return;
    }
    
    selfSecondVC.httpStr = @"friendships/friends.json";
    selfSecondVC.title = @"我的关注";
    [self.navigationController pushViewController:selfSecondVC animated:YES];
    
}

- (IBAction)fensiBtnAction:(id)sender {
    
    UIStoryboard *sb  =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SelfSecondViewController *selfSecondVC = [sb instantiateViewControllerWithIdentifier:@"selfSecondVC"];
    
    selfSecondVC.name = _model.screen_name;
    if (selfSecondVC.name == nil) {
        return;
    }

    selfSecondVC.httpStr = @"friendships/followers.json";
    selfSecondVC.title = @"我的粉丝";
    [self.navigationController pushViewController:selfSecondVC animated:YES];
    
    
    
    
}


- (void)setModel:(UserModel *)model{
    if (_model != model) {
        _model = model;
    }
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
