//
//  UIView+ViewContorller.m
//  UI09-task-05
//
//  Created by keyzhang on 15/8/17.
//  Copyright (c) 2015年 keyzhang. All rights reserved.
//

#import "UIView+ViewContorller.h"

@implementation UIView (ViewContorller)

//通过响应者链寻找控制器
- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    do {
        //判断响应者是否是视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        //如果没有找到控制器，那么继续往下一层响应者去找
        next = next.nextResponder;
    } while (next);
    
    return nil;
}


@end
