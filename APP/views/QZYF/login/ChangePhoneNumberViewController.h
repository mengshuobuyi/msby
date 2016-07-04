//
//  ChangePhoneNumberViewController.h
//  wenyao
//
//  Created by Meng on 14-9-30.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"
#import "CreditModel.h"
typedef NS_ENUM(NSInteger, ChangePhoneType){
    ChangePhoneType_ChangePhoneNumber = 0,   // 修改手机号
    ChangePhoneType_BindPhoneNumber,   // 绑定手机号
};

typedef void (^BindPhoneNumSuccessCallback)(BOOL success);

@protocol ChangePhoneNumberViewControllerDelegate <NSObject>

@optional
- (void)returnNumber:(NSString *)number;

@end


@interface ChangePhoneNumberViewController : QWBaseVC


@property (nonatomic ,weak) id<ChangePhoneNumberViewControllerDelegate>delegate;
@property (nonatomic, assign) ChangePhoneType changePhoneType;
// 如果是从登录页面过来，把登录页面的isPresentType赋值过来
@property (nonatomic, assign) BOOL isPresentType;
// 如果是第一次第三方登录，需要绑定手机，返回要跳回navi的rootVC
@property (nonatomic, assign) BOOL isNeedPopToRootVC;

// 是否是一次性任务，从积分页面的入口进来，为了监听事件
@property (nonatomic, assign) BOOL isSingleTask;
@property (nonatomic, assign) BOOL isFromeSetting;
@property (nonatomic,strong)CreditModel *model;
@property (nonatomic, copy)  BindPhoneNumSuccessCallback   extCallBack;

@end
