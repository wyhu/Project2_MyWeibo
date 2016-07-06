//
//  SecondDiscoverViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/24.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SecondDiscoverViewController.h"
#import "WeiboModel.h"
#import "AnotationModel.h"
#import "CostumMKAnnotationView.h"
@interface SecondDiscoverViewController ()
{
    CLLocationManager *_manager;
    NSArray *_data;
    MKMapView *_mapView;
}
@end

@implementation SecondDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //构造定位器
    _manager = [[CLLocationManager alloc] init];
    //设置定位精度
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //8.0系统以后需要加上,同时需要修改PLIST文件
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [_manager requestAlwaysAuthorization];
    }
    //开启定位
    [_manager startUpdatingLocation];
    
    //设置代理
    _manager.delegate = self;
    
    
    //构造地图
    [self _initMap];
    
}

- (void)_initMap{
    
    //构造地图
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.delegate = self;
    
    _mapView.mapType = MKMapTypeStandard;
    
    _mapView.showsUserLocation = YES;
    
    [self.view addSubview:_mapView];
    
    
}

//加载数据
- (void)loadDataWithLat:(NSString *)lat long:(NSString *)lon{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //@39.924113  @116.186119
    [params setValue:lat forKey:@"lat"];
    [params setValue:lon forKey:@"long"];
    
    [DataService requestURL:self.httpStr
                     params:params
                 httpMethod:@"GET"
          didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {
        
        NSLog(@"附近动态请求成功");
              
                  NSArray *array = [result objectForKey:@"statuses"];
                  NSMutableArray *mArr = [NSMutableArray array];
                  for (NSDictionary *dic in array) {
                      WeiboModel *model = [[WeiboModel alloc] initContentWithDic:dic];
        
                      AnotationModel *anoModel = [[AnotationModel alloc] init];
                      
                      anoModel.weiboModel = model;

                      [mArr addObject:anoModel];
                      
                  }
                  
                  _data = mArr;
              //将标注对象添加到地图上去显示
                  [_mapView addAnnotations:_data];
              
        
    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"------%@",error);
    }];
}

/*第四步
 最后实现MKMapViewDelegate协议方法，在该代理中创建MKPinAnnotationView标注视图
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    
    static NSString *identifier = @"hehe";
    
    //MKPinAnnotationView是一个大头针视图
    CostumMKAnnotationView *annotationView = (CostumMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView == nil) {
        annotationView = [[CostumMKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
    
        //是否显示标题视图
        annotationView.canShowCallout = YES;
        
    }
    
    //防止复用
    annotationView.annotation = annotation;
    
    return annotationView;
}

//点击标注时出发的方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"点击了标注----%@", view);
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    [_manager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"定位成功：纬度：%.2f----经度：%.2f", coordinate.latitude, coordinate.longitude);
    //设置进入地图的显示位置
    //设置经纬度
    //设置精确度,数值越大，显示的范围越大
    MKCoordinateSpan span = {0.05, 0.05};
    //创建一个区域
    MKCoordinateRegion region = {coordinate, span};
    //设置显示的区域
    [_mapView setRegion:region animated:YES];
    
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    //加载数据
    [self loadDataWithLat:lat long:lon];
    
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败%@",error);
}

//标记视图已经添加到地图上显示的时候调用此方法
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    int time = 0;
    for (UIView *annotationView in views) {
        //当前视图缩小为原来的0.5倍
        annotationView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        annotationView.alpha = 0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             //延迟动画的调用
                             [UIView setAnimationDelay:time * 0.05];
                             
                             annotationView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                             annotationView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             //让视图从1.2--》1
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  annotationView.transform = CGAffineTransformIdentity;
                                              }];
                         }];
        time++;
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
