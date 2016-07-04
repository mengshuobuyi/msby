//
//  SysNotiListRequest.h
//  APP
//
//  Created by PerryChen on 8/18/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SysNotiListModelR.h"
#import "SysNotiBaseModel.h"
@interface SysNotiListRequest : NSObject
//p2p  全量拉取系统消息列表
+ (void)getAllSystemNotiList:(SysNotiListModelR *)param
                     success:(void (^)(SystemMessageArrayVo *responModel))succsee
                     failure:(void (^)(HttpException *e))failure;

// 增量获取系统消息列表
//+ (void)getNewSystemList:(SysNotiPullListModelR *)param
//                 success:(void (^)(SystemMessageArrayVo *responModel))success
//                 failure:(void (^)(HttpException *e))failure;

//p2p 全量拉取订单通知消息列表
+ (void)getAllOrderNotiList:(OrderNotiListModelR *)param
                    success:(void (^)(OrderMessageArrayVo *responModel))succsee
                    failure:(void (^)(HttpException *e))failure;

+ (void)setOrderNotiReadWithMessageId:(NSString *)strMsgId
                              success:(void (^)(id responModel))success
                              failure:(void (^)(HttpException *e))failure;

+ (void)removeByCustomer:(RemoveByCustomerOrderR *)param
                 success:(void (^)(id responModel))success
                 failure:(void (^)(HttpException *e))failure;
@end