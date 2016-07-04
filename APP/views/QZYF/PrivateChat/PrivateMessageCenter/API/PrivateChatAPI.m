//
//  PrivateChatAPI.m
//  APP
//  私聊API
//  Created by Martin.Liu on 16/3/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PrivateChatAPI.h"
#import "HttpClient.h"

@implementation PrivateChatAPI

/**
 *  添加会话明细
 *
 *  @param param   参数model
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
+ (void)addChatDetail:(PCCreateR *)param
              success:(void (^)(PrivateChatAddChatModel *))success
              failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] postWithoutProgress:API_PrivateChat_AddChatDetail params:[param dictionaryModel] success:^(id responseObj) {
        PrivateChatAddChatModel* addChatModel = [PrivateChatAddChatModel parse:responseObj];
        if (success) {
            success(addChatModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        };
    }];
}

/**
 *  获取会话详情
 *
 *  @param param   参数model
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
+ (void)getAll:(PCGetAllR *)param
       success:(void (^)(PrivateChatDetailListModel *))success
       failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] getWithoutProgress:API_PrivateChat_GetAll params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([PrivateChatDetailModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"details"];
        
        PrivateChatDetailListModel* chatDetailList = [PrivateChatDetailListModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(chatDetailList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/**
 *  根据chatId获取会话详情
 *
 *  @param param   参数model
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
+ (void)getAllByChatId:(PCGetAllByChatIdR *)param
               success:(void (^)(PrivateChatDetailListModel *))success
               failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] getWithoutProgress:API_PrivateChat_GetAllByChatId params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([PrivateChatDetailModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"details"];
        
        PrivateChatDetailListModel* chatDetailList = [PrivateChatDetailListModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(chatDetailList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/**
 *  【增量轮询】获取会话明细列表
 *
 *  @param param   参数model
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
+ (void)getMessages:(PCGetChatDetailListR *)param
           success:(void (^)(PrivateChatDetailListModel *))success
           failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] getWithoutProgress:API_PrivateChat_GetChatDetailList params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([PrivateChatDetailModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"details"];
        
        PrivateChatDetailListModel* chatDetailList = [PrivateChatDetailListModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(chatDetailList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        };
    }];
}

@end
