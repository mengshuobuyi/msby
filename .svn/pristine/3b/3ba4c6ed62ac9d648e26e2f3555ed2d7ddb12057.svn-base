//
//  IMApi.m
//  APP
//
//  Created by qw on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "IMApi.h"
#import "BaseAPIModel.h"
@implementation IMApi

//删除指定药店/客户的IM聊天记录DelAllMessage
+ (void)deleteallWithParams:(NSDictionary *)param
                    success:(void (^)(id))success
                    failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] put:DelAllMessage params:param success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//获取所有未接收的会话记录 AlternativeIMSelect
+ (void)alternativeIMSelectWithParams:(NSDictionary *)param
                              success:(void (^)(id))success
                              failure:(void (^)(HttpException *))failure
{
    [HttpClient sharedInstance].progressEnabled=false;
    [[HttpClient sharedInstance] post:AlternativeIMSelect params:param success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//设置IM消息状态已接受IMSetReceived
+ (void)setReceivedWithParams:(NSDictionary *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] put:IMSetReceived params:param success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//获取所有未接收的会话记录 AlternativeIMSelect
//+ (void)alternativeIMSelectWithParams:(NSDictionary *)param
//                              success:(void (^)(id))success
//                              failure:(void (^)(HttpException *))failure
//{
//    [[HttpClient sharedInstance] post:AlternativeIMSelect params:param success:^(id obj) {
//        if (success) {
//            success(obj);
//        }
//    } failure:^(HttpException *e) {
//        DebugLog(@"%@",e);
//        if (failure) {
//            failure(e);
//        }
//    }];
//}

//查询全维药事聊天记录 SelectQWIM
+ (void)selectIMQwWithParams:(ImModelR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure
{
    [HttpClient sharedInstance].progressEnabled = NO;
    [[HttpClient sharedInstance] get:SelectQWIM params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        //DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//增量查询全维药事聊天记录 SelectQWIM
+ (void)pollByCustomer:(ImModelR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure
{
    [HttpClient sharedInstance].progressEnabled = NO;
    [[HttpClient sharedInstance] getWithoutProgress:PollByCustomer params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        //DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
//新增全维药事聊天记录 SelectQWIM
+ (void)selectIMQwNewlyAddedWithParams:(ImModelR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure
{
    [HttpClient sharedInstance].progressEnabled = NO;
    [[HttpClient sharedInstance] get:SelectQWIM params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        //DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
//+ (void)selectIMReadNumWithParams:(NSDictionary *)param
//                          success:(void (^)(id))success
//                          failure:(void (^)(HttpException *))failure
//{
//    [[HttpClient sharedInstance] post:IMReadNum params:param success:^(id obj) {
//        if (success) {
//            success(obj);
//        }
//    } failure:^(HttpException *e) {
//        DebugLog(@"%@",e);
//        if (failure) {
//            failure(e);
//        }
//    }];
//}

//查询IM聊天记录数目 SelectIM
+ (void)selectIMWithParams:(ImModelR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:SelectIM params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//推送设置 CheckCert
+ (void)certcheckIMWithParams:(NSDictionary *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:CheckCert params:param success:^(id obj) {
        BaseAPIModel *apiModel = [BaseAPIModel parse:obj];
        if (success) {
            success(apiModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//删除IM聊天记录 DeleteIM
+ (void)deleteIMWithParams:(NSDictionary *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] put:DeleteIM params:param success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
@end
