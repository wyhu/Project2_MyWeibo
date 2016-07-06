//
//  FaceView.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/22.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FaceView.h"
//表情的宽高
#define face_width 30.0
#define face_height 30.0

//表情所在item的宽高
#define item_width (kScreenWidth / 7.0)
#define item_height (kScreenWidth / 7.0)


@implementation FaceView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        [self _initFangdajing];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self loadData];
    [self _initFangdajing];
}

//初始化放大镜视图
- (void)_initFangdajing{
    _fangdaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
    _fangdaImgView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
    [self addSubview:_fangdaImgView];
    
    //放大经商的小视图
    UIImageView *litterImgView = [[UIImageView alloc] initWithFrame:CGRectMake((64 - 40) / 2, 12, 40, 40)];
    litterImgView.backgroundColor = [UIColor clearColor];
    litterImgView.tag = 200;
    [_fangdaImgView addSubview:litterImgView];
    
    //开始的时候隐藏起来
    _fangdaImgView.hidden = YES;
}


- (void)loadData{
    
    //拿到数组文件
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
    NSArray *faceNameArr = [NSArray arrayWithContentsOfFile:pathFile];
    _faceMArr = [[NSMutableArray alloc] init];
    NSMutableArray *mArr = nil;
    //将每28个元素分到一组之中
    for (NSDictionary *dic in faceNameArr) {
        if (mArr == nil || mArr.count == 28) {
            
            mArr = [NSMutableArray arrayWithCapacity:28];
            [_faceMArr addObject:mArr];
        }
        
        
        [mArr addObject:dic];
    }
    
    //定义显示视图的尺寸
    self.width = kScreenWidth * _faceMArr.count;
    self.height = item_width * 4;
    
    
}

//画图操作
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    int hang = 0;//行
    int lie = 0;//列
    
    //外层控制页数，内层控制每一页的表情个数
    for (int i = 0; i < _faceMArr.count; i++) {
        NSArray *arr = [_faceMArr objectAtIndex:i];
        
        for (int j = 0; j < arr.count; j++) {
            
            NSDictionary *dic = arr[j];
            NSString *str = [dic objectForKey:@"png"];
            UIImage *img = [UIImage imageNamed:str];

            //构造坐标
            
            CGFloat x = (item_width - face_width) / 2 + item_width * lie + kScreenWidth * i;
            CGFloat y = (item_height - face_height) / 2 + item_height * hang;
            
            
            [img drawInRect:CGRectMake(x, y, face_width, face_height)];
            
            
            lie++;

            if (lie == 7) {
                hang++;
                lie = 0;
                }

            if (hang == 4) {
                hang = 0;
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]];
    //返回触摸点在视图中的当前坐标
    
    [self touchingAction:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //关闭滑动视图的滑动事件
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView * scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = NO;
        
    }
    
    UITouch *touch = [touches anyObject];
    //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]];
    //返回触摸点在视图中的当前坐标
    
    [self touchingAction:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //关闭滑动视图的滑动事件
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView * scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
        
    }
    
//    if ([self.delegate respondsToSelector:@selector(textChange:)]) {
//        [self.delegate textChange:_laxtImgName];
//
//    }
    
    
    //调用block
    if (self.block) {
        if (_laxtImgName != nil) {
            self.block(_laxtImgName);

        }
    }
    
    _laxtImgName = nil;
    _fangdaImgView.hidden = YES;
}

//手指滑动的时候,所引发的事件
- (void)touchingAction:(CGPoint)point{
    _fangdaImgView.hidden = NO;
    //计算出手指的位置
    NSInteger hang = point.y / item_height;
    NSInteger lie  = point.x / item_width;
    
    //计算出其页数
    NSInteger pageNum = point.x / kScreenWidth;
    
    //求出其对应的位置坐标
    NSInteger count = hang * 7 +lie - pageNum * 7;
//    NSLog(@"%ld",count);
    //取出对应的组
    
    
    NSArray *array = _faceMArr[pageNum];
    //取出对应的元素
    
    if (pageNum == 3 && count > 19) {
        _fangdaImgView.hidden = YES;
        
        return;
    }
    if (count > 27 || count < 0) {
        _fangdaImgView.hidden = YES;
        return;
    }
    
    
    NSDictionary *dic =  array[count];

    
    NSString *imgName = [dic objectForKey:@"png"];
    
    NSString * imgChs = [dic objectForKey:@"chs"];
    
    _laxtImgName = imgChs;
    
    
    UIImageView *imgView = (UIImageView *)[_fangdaImgView viewWithTag:200];
    
    imgView.image = [UIImage imageNamed:imgName];
    
    //计算放大镜视图的坐标位置
    CGFloat _x = lie * item_width + item_width / 2;
    CGFloat _y = hang * item_height;
    _fangdaImgView.right = _x + 32;
    _fangdaImgView.bottom = _y + 14 ;
}




@end
