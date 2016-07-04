//
//  SysNotiListRequest.m
//  APP
//
//  Created by PerryChen on 8/18/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "SysNotiListRequest.h"

@implementation SysNotiListRequest
//p2p  全量拉取系统消息列表
+ (void)getAllSystemNotiList:(SysNotiListModelR *)param
                     success:(void (^)(SystemMessageArrayVo *responModel))succsee
                     failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MsgBoxListSysNotiList params:[param dictionaryModel] success:^(id responseObj) {
        SystemMessageArrayVo *listModel = [SystemMessageArrayVo parse:responseObj Elements:[SystemMessageVo class] forAttribute:@"messages"];
        if (succsee) {
            succsee(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

// 增量获取系统消息列表
//+ (void)getNewSystemList:(SysNotiPullListModelR *)param
//                 success:(void (^)(SystemMessageArrayVo *responModel))success
//                 failure:(void (^)(HttpException *e))failure
//{
//    HttpClientMgr.progressEnabled = NO;
//    [[HttpClient sharedInstance] get:MsgBoxListPullSysNotiList params:[param dictionaryModel] success:^(id responseObj) {
//        SystemMessageArrayVo *listModel = [SystemMessageArrayVo parse:responseObj Elements:[SystemMessageVo class] forAttribute:@"messages"];
//        if (success) {
//            success(listModel);
//        }
//    } failure:^(HttpException *e) {
//        if (failure) {
//            failure(e);
//        }
//    }];
//}

//p2p 全量拉取订单通知消息列表
+ (void)getAllOrderNotiList:(OrderNotiListModelR *)param
                    success:(void (^)(OrderMessageArrayVo *responModel))succsee
                    failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MsgBoxListOrderNotiList params:[param dictionaryModel] success:^(id responseObj) {
        OrderMessageArrayVo *listModel = [OrderMessageArrayVo parse:responseObj Elements:[OrderMessageVo class] forAttribute:@"messages"];
        if (succsee) {
            succsee(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)setOrderNotiReadWithMessageId:(NSString *)strMsgId
                              success:(void (^)(id responModel))success
                              failure:(void (^)(HttpException *e))failure
{
    OrderNotiReadR *modelR = [OrderNotiReadR new];
    modelR.messageId = strMsgId;
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:OrderNotiMsgRead params:[modelR dictionaryModel] success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)removeByCustomer:(RemoveByCustomerOrderR *)param
                 success:(void (^)(id responModel))success
                 failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] put:OrderNotiRemoveItem params:[param dictionaryModel] success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
