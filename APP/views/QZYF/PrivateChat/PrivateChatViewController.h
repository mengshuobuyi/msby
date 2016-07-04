//
//  PrivateChatViewController.h
//  APP
//  Created by Martin.Liu on 16/3/10.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"

//extern BOOL const PrivateAllowsSendFace;                               //是否支持发送表情
//extern BOOL const PrivateAllowsSendVoice;                              //是否支持发送声音
//extern BOOL const PrivateAllowsSendMultiMedia;                         //是否支持发送多媒体
//extern BOOL const PrivateAllowsPanToDismissKeyboard;                   //是否允许手势关闭键盘，默认是允许
//extern BOOL const PrivateShouldPreventAutoScrolling;

@interface PrivateChatViewController : QWBaseVC

@property (nonatomic, strong) MicroMallBranchProductVo *product;//从商品详情传过来，用于发送药品链接
@property (nonatomic ,copy) NSString *sessionID;                // 会话id
@property (nonatomic ,copy) NSString *userId;                   // 门店id（现在应该是专家ID）【用户ID】
@property (nonatomic ,copy) NSString *nickName;                 // 门店名称（现在应该是专家昵称）【用户昵称】
@property (nonatomic ,strong) NSString *messageSender;          // 好像没用到？
@property (nonatomic ,assign) BOOL fromList;                    // 从列表推入的页面 add by PerryChen

@property (nonatomic ,assign) NSInteger expertType;             // 专家类型，统计事件用到

@property (nonatomic ,strong) NSString *branchProId;//药品ID
@end
