//
//  Appraise.h
//  APP
//
//  Created by qw on 15/3/13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppraiseModelR.h"
#import "HttpClient.h"
#import "AppraiseModel.h"

@interface Appraise : NSObject

//检查会话是否评价过 AppraiseExist
+ (void)appraiseExistWithParams:(NSDictionary *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure;

/**
 *  3.7.1	添加药店评价
 */

+ (void)addAppraiseWithParams:(AddAppraiseModelR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;

/**
*   适用场景：
*   从通知栏、消息盒子的问题详情，若关闭，则直接进入评论页面。
*   此接口可获取评论内容
 */
+ (void)appraiseByConsultGetParams:(GetAppraiseModelR *)param
                           success:(void(^)(AppraiseByConsultGetModel *resultObj))success
                           failure:(void(^)(HttpException * e))failure;


/**
 *  @brief 3.7.3	用户端免费问药-药店评价列表
 */
+ (void)queryAppraiseWithParams:(id)param
                        success:(void(^)(id resultObj))success
                        failure:(void(^)(HttpException * e))failure;

/**
 *  @brief 3.7.3	用户端-药店评价
 */
+ (void)appraiseByConsultWithParams:(AppraiseByConsultModelR *)param
                            success:(void(^)(AppraiseByConsultModel *resultObj))success
                            failure:(void(^)(HttpException * e))failure;

// 获取药店评价
+ (void)getAppraiseByConsultWithParams:(GetAppraiseModelR *)param
                               success:(void(^)(AppraiseByConsultModel *resultObj))success
                               failure:(void(^)(HttpException * e))failure;
@end





