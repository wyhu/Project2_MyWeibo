//
//  DataService.m
//  UI-05-homework
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DataService.h"

@implementation DataService

#define BASE_URL @"https://open.weibo.cn/2/"

//实现该方法
+ (AFHTTPRequestOperation *)requestURL:(NSString *)url
                            params:(NSMutableDictionary *)params
                        httpMethod:(NSString *)httpMethod
                didSuccessedBlock:(SuccessedBlock)successedBlock
                   didFailedBlock:(FailedBlock)failedBlock
{
    //构建URL
    NSString *urlStr = [BASE_URL stringByAppendingString:url];
    
    if (params == nil)
    {
        params = [NSMutableDictionary dictionary];
    }
    
    //参数处理
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *accessTokenKey = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    
    if (accessTokenKey.length == 0) {
        return nil;
    }
    
    [params setObject:accessTokenKey forKey:@"access_token"];
    
    /**
     *  构造操作对象
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    AFHTTPRequestOperation *operation = nil;
    
    if ([httpMethod isEqualToString:@"GET"]) {
        //GET请求
        operation = [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

            if (successedBlock) {
                successedBlock(operation,responseObject);
                NSLog(@"GET请求成功");
            }
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            if (failedBlock) {
                failedBlock(operation , error);
                NSLog(@"GET请求失败");
            }
        }];
        
        
    }else if ([httpMethod isEqualToString:@"POST"]){
        //POST请求
        BOOL isPic = NO;
        
        NSArray *array = [params allKeys];
        for (NSString *key in array) {
            if ([key isEqualToString:@"pic"]) {
                isPic = YES;
                break;
            }
        }
        
        
        if (!isPic) {
            url = @"https://api.weibo.com/2/statuses/update.json";
            //文字微博
            operation = [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
                if (successedBlock) {
                    successedBlock(operation,responseObject);
                    NSLog(@"POST-无图-请求成功");
                }

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failedBlock) {
                    failedBlock(operation , error);
                    NSLog(@"POST-无图-请求失败%@",error);
                }

            }];
            
            
        }else if (isPic){
            //图片微博
            url = @"https://upload.api.weibo.com/2/statuses/upload.json";
            
            operation = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *key in params) {
                    id value = params[key];
                    if ([value isKindOfClass:[NSData class]]) {
        
                        [formData appendPartWithFileData:value name:key fileName:key mimeType:@"image/jpg/png"];
                    }
                }
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {

                if (successedBlock) {
                    successedBlock(operation,responseObject);
                    NSLog(@"POST-有图-请求成功");
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failedBlock) {
                    failedBlock(operation , error);
                    NSLog(@"POST-有图-请求失败%@",error);
                }

            }];
            
            
        }
        
        
    }
    
    
    
    //数据解析
    
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    
    //监听上传的速度
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
//            CGFloat progerss = bytesWritten / totalBytesWritten;
//            NSLog(@"%lu",(unsigned long)bytesWritten);
//            NSLog(@"%llu",totalBytesWritten);
//            NSLog(@"%llu",totalBytesExpectedToWrite);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"progressChange" object:progerss];
            
            
        }];
    //监听下载的速度
    //    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    //
    //    }];

    
    
    return operation;
}




@end
