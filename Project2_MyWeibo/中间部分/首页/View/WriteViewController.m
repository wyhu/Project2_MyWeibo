//
//  WriteViewController.m
//  Project2_MyWeibo
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WriteViewController.h"
#import "RootDrawerController.h"
#import "ZoomImageView.h"
#import "UIProgressView+AFNetworking.h"
#import "MixedFaceView.h"
@interface WriteViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZoomDelegate,FaceDelegaet,UITextViewDelegate>
{
    UIImagePickerController *_pickerCtrl;
    IBOutlet UIView *_editorBarView;
    ZoomImageView *_zoomImgView;
    UIImage *_image;
    
    
    UIWindow *proWindow;
    AFHTTPRequestOperation *_operation;
    //发送提示条
    UIProgressView *_progressView;
    UILabel *_proLabel;
    
    MixedFaceView *mixedView;
}
@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradAction:) name:UIKeyboardDidChangeFrameNotification object:nil];

    //初始化导航栏上的UI
    [self _initUI];
    //初始化textView模块
    [self _initTextView];
}
- (void)becomeFirst{
    [_textView becomeFirstResponder];

}
- (void)LostFirst{
    [_textView resignFirstResponder];

}

#pragma mark 键盘监听事件
- (void)keyBoradAction:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    
    CGFloat keyBorad_y = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
        if (keyBorad_y >= kScreenHeight) {
            _editorBarView.top = kScreenHeight;
            _zoomImgView.bottom = _editorBarView.top - 64;
            
        }else{
            
            _editorBarView.bottom = keyBorad_y - 64;
            _zoomImgView.bottom = _editorBarView.top;
        }
    }

- (void)textTap:(UITapGestureRecognizer *)tap{
    _textView.inputView = nil;
    [_textView reloadInputViews];
    
}
#pragma mark  初始化textView模块
- (void)_initTextView{
    _textView.top = 0;
    _editorBarView.top = kScreenHeight;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTap:)];
    [_textView addGestureRecognizer:tap];
    
    //自动弹出键盘
    [_textView becomeFirstResponder];
    
    NSArray *imgsArr = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_6.png",
                      @"compose_toolbar_5.png"
                      ];
    for (int i = 0; i < imgsArr.count; i++) {
        NSString *imgName = imgsArr[i];
        
        ThemeBtn *button = [[ThemeBtn alloc] initWithFrame:CGRectMake((kScreenWidth/5)*i + 15, 8, 40, 33)];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200 + i;
        button.btnImgName = imgName;
        [_editorBarView addSubview:button];

    
    }
}
- (void)btnAction:(ThemeBtn *)btn{
    //处理键盘栏事件
    switch (btn.tag) {
        case 200:
            //拍照、相机
            [self xiangjiAction];
            break;
        case 203:
            //表情
            [self faceAction:btn];
            break;
        default:
            break;
    }
}

#pragma  mark 表情按钮触发事件

- (void)faceAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (mixedView == nil) {
        mixedView = [[MixedFaceView alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
    }
    
    if (btn.selected) {
               _textView.inputView = mixedView;
        
                __weak UITextView *weakTextView = self.textView;
        
                mixedView.faceView.block = ^(NSString *imgName){
                    __strong UITextView *strongTextView = weakTextView;
                    
                    [strongTextView insertText:imgName];
                };
        
    }else{
       
        _textView.inputView = nil;
        
    }
    
    [_textView reloadInputViews];
    
    
}
#pragma  mark  -UitextViewDelegaet
- (void)textChange:(NSString *)imgName{
    
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,imgName];
}

#pragma  mark 相机按钮触发事件
- (void)xiangjiAction{
    
    //构造弹出器
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择你的操作" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加action
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //取消
        _image = nil;
        [_zoomImgView removeFromSuperview];
        
        
    }];
    UIAlertAction *xiangceAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //相册
        //安全判断
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //不支持相册
            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有检测到相册" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alertCtrl addAction:action];
            [self presentViewController:alertCtrl animated:YES completion:nil];
            return;
        }
        
        _pickerCtrl = [[UIImagePickerController alloc] init];
        _pickerCtrl.delegate = self;
        [self presentViewController:_pickerCtrl animated:YES completion:^{
            
        }];
        
        
    }];
    
    UIAlertAction *xiangjiAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //相机
        //安全判断
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //不支持相机
            UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有检测到相机" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alertCtrl addAction:action];
            [self presentViewController:alertCtrl animated:YES completion:nil];
            return ;
        }

        
        
    }];
                                   
    [alertControl addAction:xiangjiAction];
    [alertControl addAction:xiangceAction];
    [alertControl addAction:cancleAction];
    
    [self presentViewController:alertControl animated:YES completion:nil];
    
    
}

#pragma mark picker代理事件

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    if (_zoomImgView == nil) {
        _zoomImgView = [[ZoomImageView alloc] initWithFrame:CGRectMake(10, 200, 70, 70)];
        _zoomImgView.bottom = _editorBarView.top;
        _zoomImgView.backgroundColor = [UIColor clearColor];
                _zoomImgView.contentMode = UIViewContentModeScaleAspectFit;
        [_zoomImgView addZoomTapWithImgURL:nil];
        _zoomImgView.zoomDelegate = self;

    }
    
    [self.view addSubview:_zoomImgView];
    _zoomImgView.image= image;

    _image = image;
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
    
}


#pragma mark 初始化导航栏上的UI

- (void)_initUI{
    //关闭的按钮
    ThemeBtn *closeButton = [[ThemeBtn alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.btnImgName = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(canceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    //发送按钮
    ThemeBtn *sendButton = [[ThemeBtn alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.btnImgName = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendItem;
    

}


#pragma mark 发送按钮事件
- (IBAction)sendBtnAction:(id)sender {
    //做本地判断
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容不能为空";
    }else if (text.length > 140) {
        error = @"微博内容应该小于140个字符";
    }
    
    if (error != nil) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:error preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alertCtrl addAction:action];
        [self presentViewController:alertCtrl animated:YES completion:nil];
        return;
    }
    
    //发送微博
    [self sendWeibo:text];
}

//隐藏导航条窗口
- (void)hiddenWin{
    proWindow.hidden = YES;
    proWindow = nil;
}

- (void)sendWeibo:(NSString *)text{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    [params setObject:text forKey:@"status"];
    
    if (_image != nil) {
        //有图片
        NSData *data = UIImageJPEGRepresentation(_image, 0.3);
        [params setObject:data forKey:@"pic"];
        
    }

    _operation = [DataService requestURL:@"hehe" params:params httpMethod:@"POST" didSuccessedBlock:^(AFHTTPRequestOperation *operation, id result) {

        NSLog(@"发送完成");
        ;
        _proLabel.text = @"发送完成";
        
        [self performSelector:@selector(hiddenWin) withObject:nil afterDelay:1];
        

    } didFailedBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        _proLabel.text = @"发送失败";
        [self performSelector:@selector(hiddenWin) withObject:nil afterDelay:1];
        NSLog(@"%@",error);
    }];
    
    //自动关闭事件
    [self canceBtnAction:nil];
    
    if (proWindow == nil) {
        proWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        proWindow.backgroundColor = [UIColor whiteColor];
        proWindow.windowLevel = UIWindowLevelAlert;
        proWindow.hidden = NO;
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
        _progressView.progressViewStyle = UIProgressViewStyleBar;
        [_progressView setProgressWithUploadProgressOfOperation:_operation animated:YES];
        

        _proLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _proLabel.text = @"微博正在发送中...";
        _proLabel.font = [UIFont boldSystemFontOfSize:15];

    }
    [proWindow addSubview:_progressView];
    
    [proWindow addSubview:_proLabel];
    
    
}


#pragma mark  取消按钮事件
- (IBAction)canceBtnAction:(id)sender {
    
    RootDrawerController *rootDrawer = (RootDrawerController *)self.view.window.rootViewController;
    
    [self dismissViewControllerAnimated:YES completion:^{
        //MMDrawer关闭左右视图的方法
        [rootDrawer closeDrawerAnimated:YES completion:nil];
    }];

}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];

}


@end
