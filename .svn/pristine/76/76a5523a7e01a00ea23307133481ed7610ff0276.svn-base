//
//  IMApi.h
//  APP
//
//  Created by qw on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "ImModelR.h"


@interface IMApi : NSObject

//删除指定药店/客户的IM聊天记录DelAllMessage
+ (void)deleteallWithParams:(NSDictionary *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;
//设置IM消息状态已接受IMSetReceived
+ (void)setReceivedWithParams:(NSDictionary *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;

//获取所有未接收的会话记录 AlternativeIMSelect
+ (void)alternativeIMSelectWithParams:(NSDictionary *)param
                              success:(void (^)(id))success
                              failure:(void (^)(HttpException *))failure;

//查询全维药事聊天记录 SelectQWIM
+ (void)selectIMQwWithParams:(ImModelR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure;
//新增全维药事聊天记录 SelectQWIM
+ (void)selectIMQwNewlyAddedWithParams:(ImModelR *)param
                               success:(void (^)(id))success
                               failure:(void (^)(HttpException *))failure;
//查询全维药事聊天记录数目 IMReadNum
//+ (void)selectIMReadNumWithParams:(NSDictionary *)param
//                          success:(void (^)(id))success
//                          failure:(void (^)(HttpException *))failure;

//查询IM聊天记录数目 SelectIM
+ (void)selectIMWithParams:(ImModelR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure;

//推送设置 CheckCert
+ (void)certcheckIMWithParams:(NSDictionary *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure;

//删除IM聊天记录 DeleteIM
+ (void)deleteIMWithParams:(NSDictionary *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure;

+ (void)pollByCustomer:(ImModelR *)param
               success:(void (^)(id))success
               failure:(void (^)(HttpException *))failure;
@end
