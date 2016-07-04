//
//  News_QueryChannel.m
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Healthinfo.h"
#import "Constant.h"

@implementation Healthinfo

//健康资讯栏目列表
+ (void)QueryChannelsuccess:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance] get:QueryChannelList
                               params:param
                              success:^(id resultObj) {
                                  
                                  NSArray *modelArray = [HealthinfoChannel parseArray:resultObj[@"list"]];
                                  if (success) {
                                      success(modelArray);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//健康咨询列表查询
+ (void)QueryHealthAdviceListWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled=NO;
    [[HttpClient sharedInstance] get:QueryHealthAdviceList
                               params:param
                              success:^(id resultObj) {
//                                  DebugLog(@"%@",resultObj);
                                  HealthinfoAdvicelPage *page = [HealthinfoAdvicelPage parse:resultObj Elements:[HealthinfoAdvicel class] forAttribute:@"list"];//[HealthinfoAdvicelPage parse:resultObj Elements:[HealthinfoAdvicel class]];
                                  
                                  if (success) {
                                      success(page);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//根据栏目获取banner
+ (void)queryChannelBannerWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled=NO;
    [[HttpClient sharedInstance] get:QueryChannelBanner
                               params:param
                              success:^(id resultObj) {
//                                  QWLOADING.showLoading
                                  NSArray *modelArray = [HealthinfoChannelBanner parseArray:resultObj[@"list"]];
                                  
                                  if (success) {
                                      success(modelArray);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//检查是否已经点赞
+ (void)checkPraiseAdviceWithParams:(NSDictionary *)param
                            success:(void(^)(id))success
                            failure:(void(^)(HttpException * e))failure
{
//    HttpClientMgr.progressEnabled=NO;
//    [[HttpClient sharedInstance] post:NW_CheckPraiseAdvice
//                               params:param
//                              success:^(id resultObj) {
//                                  
//                                  
//                                  if (success) {
//                                      success(resultObj);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
}

//点赞
+ (void)praiseAdviceWithParams:(NSDictionary *)param
                       success:(void(^)(id))success
                       failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] put:NW_PraiseAdvice
                               params:param
                              success:^(id resultObj) {
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//取消点赞
+ (void)cancelPraiseAdviceWithParams:(NSDictionary *)param
                             success:(void(^)(id))success
                             failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] put:NW_CancelPraiseAdvice
                               params:param
                              success:^(id resultObj) {
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//阅读数+1
+ (void)readAdviceWithParams:(NSDictionary *)param
                     success:(void(^)(id))success
                     failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled=NO;
    [[HttpClient sharedInstance] post:NW_ReadAdvice
                               params:param
                              success:^(id resultObj) {
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//健康资讯分享
+ (void)shareAdviceWithParams:(NSDictionary *)param
                      success:(void(^)(id))success
                      failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:NW_shareAdvice
                               params:param
                              success:^(id resultObj) {
                                  
                                  
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//健康资讯详情
+ (void)getHealthAdviceWithParams:(NSDictionary *)param
                          success:(void(^)(id))success
                          failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled=NO;
    [[HttpClient sharedInstance] get:NW_QueryHealthAdviceInfo
                               params:param
                              success:^(id resultObj) {
                                  
                                  if (resultObj) {
                                      HealthinfoAdvicel * advicel = [HealthinfoAdvicel parse:resultObj];
                                      if (advicel) {
                                          if (success) {
                                              success(advicel);
                                          }
                                      }
                                      else
                                      {
                                          if (failure) {
                                              failure(resultObj);
                                          }
                                      }
                                  }
                                  else
                                  {
                                      if (failure) {
                                          failure(resultObj);
                                      }
                                  }
                                  
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)getHealthAdviceCountWithParams:(NSDictionary *)param
                               success:(void(^)(id))success
                               failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryAdviceCount
                               params:param
                              success:^(id resultObj) {
                                  if (resultObj) {
                                      HealthInfoReadCountModel *modelCount = [HealthInfoReadCountModel parse:resultObj];
                                      if (success) {
                                          success(modelCount);
                                      }
                                  }
                                  
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)getHealthAdviceSubjectWithParams:(NSDictionary *)param
                                 success:(void(^)(id model))success
                                 failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:HealthAdviceSubject
                              params:param
                             success:^(id resultObj) {
                                 if (resultObj) {
                                     NSMutableArray *keyArr = [NSMutableArray array];
                                     [keyArr addObject:NSStringFromClass([ChannelSubjectsVO class])];
                                     [keyArr addObject:NSStringFromClass([DisvionVO class])];
                                     NSMutableArray *valueArr = [NSMutableArray array];
                                     [valueArr addObject:@"channelSubjectsVO"];
                                     [valueArr addObject:@"disvionVO"];
                                     SubjectOrDisvionAreaVO *modelAreas = [SubjectOrDisvionAreaVO parse:resultObj ClassArr:keyArr Elements:valueArr];
                                     if (success) {
                                         success(modelAreas);
                                     }
                                 }
                                 
                             }
                             failure:^(HttpException *e) {
                                 DebugLog(@"%@",e);
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}

+ (void)queryDivisionAreaWithParams:(NSDictionary *)param
                            success:(void(^)(id model))success
                            failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryDivisionAreas
                              params:param
                             success:^(id resultObj) {
                                 if (resultObj) {
                                     DivisionAreaVoList *modelAreas = [DivisionAreaVoList parse:resultObj Elements:[DivisionAreaVo class] forAttribute:@"list"];
                                     if (success) {
                                         success(modelAreas);
                                     }
                                 }
                             }
                             failure:^(HttpException *e) {
                                 DebugLog(@"%@",e);
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}

@end
