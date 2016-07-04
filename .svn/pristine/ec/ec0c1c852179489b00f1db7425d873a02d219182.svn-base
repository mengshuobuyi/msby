//
//  PrivateChatResponseModel.h
//  APP
//  私聊API返回的数据模型
//  Created by Martin.Liu on 16/3/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIModel.h"

@interface PrivateChatResponseModel : NSObject

@end

@interface PrivateChatAddChatModel : BaseAPIModel
@property (nonatomic, strong) NSString *sessionId;                  // 会话ID
@property (nonatomic, strong) NSString *detailId;                   // 会话明细Id
@property (nonatomic, strong) NSString *uuid;                       // 返回回来的uuid
@end

@interface PrivateChatDetailListModel : BaseAPIModel
@property (nonatomic, strong) NSString *sessionId;                  // 会话ID
@property (nonatomic, strong) NSString *nickName;                   // 会话用户昵称
@property (nonatomic, strong) NSString *headImg;                    // 会话用户头像
@property (nonatomic, strong) NSString *recipientId;                 // 会话用户账号
@property (nonatomic, strong) NSArray  *details;                    // 会话明细
@property (nonatomic, strong) NSString *serverTime;                 // 当前服务器时间
@property (nonatomic, assign) BOOL      onlineFlag;                 // 是否在线

@end

@interface PrivateChatDetailModel : BaseModel
@property (nonatomic, strong) NSString  *detailId;                  // 私聊明细表ID
@property (nonatomic, strong) NSString  *sessionId;                 // 会话Id
@property (nonatomic, strong) NSString  *recipientId;               // 接收人Id
@property (nonatomic, strong) NSString  *senderId;                  // 发送人Id,
@property (nonatomic, strong) NSString  *nickName;                  // 发送人的昵称,
@property (nonatomic, strong) NSString  *headImg;                   // 发送人的头像,
@property (nonatomic, assign) NSInteger userType;                   // 发送人的类型
@property (nonatomic, assign) BOOL      myselfFlag;                 // 是否本人
@property (nonatomic, strong) NSString  *contentJson;               // 会话json内容
@property (nonatomic, strong) NSString  *content;                   // 会话内容（AB端展示或者分析使用）
@property (nonatomic, strong) NSString  *contentType;               // 会话内容类型(TXT/IMG/POS/ACT/AUD/PRO/PMT/SYS)
@property (nonatomic, strong) NSString  *readFlag;                  // 已读标识(Y/N),
@property (nonatomic, strong) NSString  *device;                    // 设备号
@property (nonatomic, strong) NSString  *createTime;                // 创建时间
@property (nonatomic, strong) NSString  *displayDate;
@property (nonatomic, assign) BOOL      onlineFlag;                 //专家是否在线

@end