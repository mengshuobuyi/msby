//
//  LoginViewController.h
//  WenYao
//
//  Created by Meng on 14-9-2.
//  Copyright (c) 2014年 江苏苏州. All rights reserved.
//

#import "QWBaseVC.h"

typedef void (^PassTokenBlock)(NSString *token);

@interface LoginViewController : QWBaseVC

@property (nonatomic, assign)   BOOL                isPresentType;
@property (nonatomic, assign)   UINavigationController    *parentNavgationController;
@property (nonatomic, copy)     void(^backBlocker)(void);
@property (nonatomic, copy)     void(^loginSuccessBlock)(void);
// h5 用的
@property (nonatomic, copy)     PassTokenBlock passTokenBlock;

// 验证是否需要完善资料，从“我的”页面点击注册/登录需要验证
@property (nonatomic) BOOL needVerifyFullInfo;
@property (nonatomic, strong) NSString          *preVCNameStr;          // 统计时间中用到 上级页面

@end
