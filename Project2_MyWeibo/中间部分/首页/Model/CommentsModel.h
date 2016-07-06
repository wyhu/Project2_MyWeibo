//
//  CommentsModel.h
//  Project2_MyWeibo
//
//  Created by imac on 15/9/19.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
@interface CommentsModel : BaseModel
//评论ID
@property (nonatomic,copy) NSString *commentID;

//评论创建时间
@property (nonatomic ,copy) NSString *created_at;
//评论来源
@property (nonatomic,copy) NSString *source;
//评论内容
@property (nonatomic,copy) NSString *text;

//评论作者
@property (nonatomic,strong) UserModel *user;



@end
