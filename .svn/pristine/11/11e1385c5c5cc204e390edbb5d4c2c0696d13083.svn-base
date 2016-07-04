//
//  QWUnreadCountModel.h
//  wenYao-store
//
//  Created by PerryChen on 6/11/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BasePrivateModel.h"

@interface QWUnreadCountModel : BasePrivateModel
@property (nonatomic, strong) NSString *passport;

//@property (nonatomic, assign) BOOL bool_ConsultShouldShowRed;
//@property (nonatomic, assign) BOOL bool_PTPShouldShowRed;
//@property (nonatomic, assign) BOOL bool_NotiShouldShowRed;

@property (nonatomic, strong) NSString *count_CounsultUnread;
@property (nonatomic, strong) NSString *count_NotifyListUnread;     //消息盒子的通知列表未读数
@property (nonatomic, strong) NSString *count_PTPUnread;            //点对点未读数
@property (nonatomic, strong) NSString *count_OfficialUnread;       //消息盒子的全维药事未读数
@property (nonatomic, strong) NSString *count_CouponUnread;         //消息盒子的优惠券未读数
@property (nonatomic, strong) NSString *count_sysUnread;            //消息盒子的系统未读数
@property (nonatomic, strong) NSString *count_orderUnread;          //消息盒子的订单通知未读数
@end

@interface QWUnreadFlagModel : BasePrivateModel
//1.消息中心 2.订单通知 3.积分通知 101.健康指南 102.店长咨询 103.专家私聊 104.圈子消息,
@property (nonatomic, copy) NSString *passport;
@property (nonatomic, assign) BOOL healthMsgUnread;
@property (nonatomic, assign) BOOL noticeMsgUnread;
@property (nonatomic, assign) BOOL orderMsgUnread;
@property (nonatomic, assign) BOOL circleMsgUnread;
@property (nonatomic, assign) BOOL shopConsultUnread;
@property (nonatomic, assign) BOOL expertPTPMsgUnread;
@property (nonatomic, assign) BOOL creditUnread; // 用户端没有
@property (nonatomic, assign) NSInteger expertPTPMsgUnreadCount;
@property (nonatomic, assign) NSInteger shopConsultUnreadCount;
@end
