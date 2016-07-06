//
//  DataService.h
//  UI-05-homework
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessedBlock)(AFHTTPRequestOperation *operation, id result);
typedef void(^FailedBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface DataService : NSObject

+ (AFHTTPRequestOperation *)requestURL:(NSString *)url
                                params:(NSMutableDictionary *)params
                            httpMethod:(NSString *)httpMethod
                     didSuccessedBlock:(SuccessedBlock)successedBlock
                        didFailedBlock:(FailedBlock)failedBlock;

/**
 *  typedef void(^FinishDidBlock)(AFHTTPRequestOperation *operation, id result);
 
 typedef void(^FailuerBlock)(AFHTTPRequestOperation *operation, NSError *error);
 
 @interface DataService : NSObject
 
 + (AFHTTPRequestOperation *)requestWithURL:(NSString *)url
 params:(NSMutableDictionary *)params
 httpMethod:(NSString *)httpMethod
 finishDidBlock:(FinishDidBlock)finishDidBlock
 failuerBlock:(FailuerBlock)failuerBlock;
 

 */

@end
