//
//  PrivateChatParamR.h
//  APP
//  私聊API中的参数模型
//  Created by Martin.Liu on 16/3/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface PrivateChatParamR : NSObject

@end

@interface PCCreateR : BaseModel
@property (nonatomic, strong) NSString *token;                          // 登录令牌
@property (nonatomic, strong) NSString *recipientId;                       // 会话用户账号
@property (nonatomic, strong) NSString *contentJson;                    // 会话json内容
@property (nonatomic, strong) NSString *contentType;                    // 会话内容类型(TXT/IMG/POS/ACT/AUD/PRO/PMT/SYS)
@property (nonatomic, strong) NSString *deviceCode;                         // 设备号
@property (nonatomic, strong) NSString *UUID;                           // 消息UUID
@end

@interface PrivateChatContentJson : BaseModel

@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *branchProId;

@property (nonatomic, strong) NSString *actId;
@property (nonatomic, strong) NSString *actImgUrl;
@property (nonatomic, strong) NSString *actTitle;
@property (nonatomic, strong) NSString *actContent;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *speText;
@property (nonatomic, strong) NSString *speUrl;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *platform;

//优惠药品
@property (nonatomic, strong) NSString *pmtLabe;
@property (nonatomic, strong) NSString *pmtId;

//优惠券
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *couponValue;
@property (nonatomic, strong) NSString *couponTag;
@property (nonatomic, strong) NSString *begin;
@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *top;

//优惠活动
@property (nonatomic, strong) NSString *branchLogo;//商户图片
@end



@interface PCGetAllR : BaseModel
@property (nonatomic, strong) NSString  *token;                         // 登录令牌
@property (nonatomic, strong) NSString  *recipientId;                   // 会话用户账号
@property (nonatomic, assign) NSString  *point;                          // 查询时间点。0=>取系统当前最新时间，且类型为-1历史数据
@property (nonatomic, assign) NSInteger  view;                          // 明细查询条数，默认10
@property (nonatomic, assign) NSInteger  viewType;                      // 查询类型：-1 历史数据，1新数据
@end

@interface PCGetAllByChatIdR : BaseModel
@property (nonatomic, strong) NSString  *token;                         // 登录令牌
@property (nonatomic, strong) NSString  *chatId;                        // 会话Id
@property (nonatomic, assign) NSString  *point;                          // 查询时间点。0=>取系统当前最新时间，且类型为-1历史数据
@property (nonatomic, assign) NSInteger  view;                          // 明细查询条数，默认10
@property (nonatomic, assign) NSInteger  viewType;                      // 查询类型：-1 历史数据，1新数据
@end


@interface PCGetChatDetailListR : BaseModel
@property (nonatomic, strong) NSString  *token;                         // 登录令牌
@property (nonatomic, strong) NSString  *sessionId;                     // 会话Id
@end
