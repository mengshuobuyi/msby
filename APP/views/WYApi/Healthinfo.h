//
//  News_QueryChannel.h
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "HealthinfoModel.h"

@interface Healthinfo : NSObject

//健康资讯栏目列表
+ (void)QueryChannelsuccess:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//健康咨询列表查询
+ (void)QueryHealthAdviceListWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//根据栏目获取banner
+ (void)queryChannelBannerWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//检查是否已经点赞
+ (void)checkPraiseAdviceWithParams:(NSDictionary *)param
                            success:(void(^)(id))success
                            failure:(void(^)(HttpException * e))failure;

//点赞
+ (void)praiseAdviceWithParams:(NSDictionary *)param
                            success:(void(^)(id))success
                            failure:(void(^)(HttpException * e))failure;

//取消点赞
+ (void)cancelPraiseAdviceWithParams:(NSDictionary *)param
                            success:(void(^)(id))success
                            failure:(void(^)(HttpException * e))failure;

//阅读数+1
+ (void)readAdviceWithParams:(NSDictionary *)param
                            success:(void(^)(id))success
                            failure:(void(^)(HttpException * e))failure;

//健康资讯分享
+ (void)shareAdviceWithParams:(NSDictionary *)param
                     success:(void(^)(id))success
                     failure:(void(^)(HttpException * e))failure;

//健康资讯详情
+ (void)getHealthAdviceWithParams:(NSDictionary *)param
                      success:(void(^)(id))success
                      failure:(void(^)(HttpException * e))failure;

+ (void)getHealthAdviceCountWithParams:(NSDictionary *)param
                               success:(void(^)(id))success
                               failure:(void(^)(HttpException * e))failure;

+ (void)getHealthAdviceSubjectWithParams:(NSDictionary *)param
                                 success:(void(^)(id model))success
                                 failure:(void(^)(HttpException * e))failure;

+ (void)queryDivisionAreaWithParams:(NSDictionary *)param
                            success:(void(^)(id model))success
                            failure:(void(^)(HttpException * e))failure;

@end
