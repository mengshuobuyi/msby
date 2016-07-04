//
//  PrivateChatAPI.h
//  APP
//  私聊API
//  Created by Martin.Liu on 16/3/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrivateChatParamR.h"
#import "PrivateChatResponseModel.h"

@interface PrivateChatAPI : NSObject

#pragma mark 添加会话明细
+ (void)addChatDetail:(PCCreateR*)param
              success:(void (^)(PrivateChatAddChatModel *addChatModel))success
              failure:(void (^)(HttpException *e))failure;

#pragma mark 根据toId和fromId查看会话详情
+ (void)getAll:(PCGetAllR*)param
       success:(void (^)(PrivateChatDetailListModel *chatDetailList))success
       failure:(void (^)(HttpException *e))failure;

#pragma mark 根据chatId查看会话详情
+ (void)getAllByChatId:(PCGetAllByChatIdR*)param
               success:(void (^)(PrivateChatDetailListModel *chatDetailList))success
               failure:(void (^)(HttpException *e))failure;

#pragma mark 【增量轮询】获取会话明细列表
+ (void)getMessages:(PCGetChatDetailListR*)param
           success:(void (^)(PrivateChatDetailListModel *chatDetailList))success
           failure:(void (^)(HttpException *e))failure;

@end
