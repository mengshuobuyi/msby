//
//  EnrollSetPasswordViewController.h
//  APP
//
//  Created by Martin.Liu on 16/4/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "LoginViewController.h"
@interface EnrollSetPasswordViewController : QWBaseVC
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, strong) NSString* verifyCode;

@property (nonatomic, assign)   BOOL                isPresentType;
@property (nonatomic, assign)   BOOL                needVerifyFullInfo;
// h5 用的 从登录页面传过来的
@property (nonatomic, copy)     PassTokenBlock passTokenBlock;
@end