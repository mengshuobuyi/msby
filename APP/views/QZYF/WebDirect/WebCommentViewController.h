//
//  WebCommentViewController.h
//  APP
//
//  Created by garfield on 15/8/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "QWCallbackPluginExt.h"
typedef void (^CommentBlock)(BOOL success, NSString *callBackId);

@interface WebCommentViewController : QWBaseVC

@property (nonatomic, assign) NSInteger isTopic; // 1 是专题， 2 是专刊
@property (nonatomic, strong) NSString      *subjectId;
@property (nonatomic, copy) CommentBlock    successBlock;
@property (nonatomic, strong) NSString *callBackId;
@property (nonatomic, strong) QWCallbackPluginExt *extCallback;
@property (nonatomic, assign) BOOL isNewMes;        // Y 调用新的评论接口
@property (nonatomic, strong) NSString *msgTitle;      // H5 资讯标题
@end
