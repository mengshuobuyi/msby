//
//  DrugGuideApi.m
//  APP
//
//  Created by chenzhipeng on 3/13/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "DrugGuideApi.h"
#import "DrugGuideModel.h"

@implementation DrugGuideApi

//+ (void)getDrugGuideList:(DrugGuideListModelR *)para
//                 success:(void (^)(id array))success
//                 failure:(void (^)(HttpException *err))failure
//{
//    HttpClientMgr.progressEnabled = NO;
//    [[HttpClient sharedInstance] get:GetDrugGuideList
//                               params:[para dictionaryModel]
//                              success:^(id resultObj) {
//                                  DrugGuideModel *model = [DrugGuideModel parse:resultObj Elements:[DrugGuideListModel class] forAttribute:@"list"];
//                                  if (success) {
//                                      success(model);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
//}

+ (void)queryMsgLogList:(DrugMsgLogListModelR *)para
                success:(void (^)(id model))success
                failure:(void (^)(HttpException *err))failure
{
    [[HttpClient sharedInstance] get:QueryMsgLogList
                               params:[para dictionaryModel]
                              success:^(id resultObj) {
                                  DDLogVerbose(@"the res is %@", resultObj);
                                  DrugGuideMsgLogModel *model = [DrugGuideMsgLogModel parse:resultObj Elements:[DrugGuideMsgLogListModel class] forAttribute:@"list"];
                                  if (success) {
                                      success(model);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)queryAttentionList:(DrugGuideAttentionModelR *)para
                   success:(void (^)(id model))success
                   failure:(void (^)(HttpException *err))failure
{
    [[HttpClient sharedInstance] get:QueryAttentionList
                               params:[para dictionaryModel]
                              success:^(id resultObj) {
                                  
                                  DrugAttentionModel *model = [DrugAttentionModel parse:resultObj Elements:[DrugAttentionChildModel class] forAttribute:@"list"]; 
                                  
                                  if (success) {
                                      success(model);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}


+ (void)saveDrugGuideItem:(SaveDrugGuideItemModelR *)para
                  success:(void (^)(id model))success
                  failure:(void (^)(HttpException *err))failure;
{
    HttpClientMgr.progressEnabled=NO;
    [[HttpClient sharedInstance] post:SaveDrugGuideItem
                               params:[para dictionaryModel]
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

+ (void)deleteDrugGuideItem:(DeleteDrugGuideItemModelR *)para
                    success:(void (^)(id model))success
                    failure:(void (^)(HttpException *err))failure
{
    HttpClientMgr.progressEnabled=YES;
    [[HttpClient sharedInstance] put:DeleteMsgDrugGuide
                               params:[para dictionaryModel]
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

+ (void)addLikeNum:(DrugGuideLikeCountModelR *)para
           success:(void (^)(id model))success
           failure:(void (^)(HttpException *err))failure
{
    [[HttpClient sharedInstance] post:LikeCountsPlus
                               params:[para dictionaryModel]
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


+ (void)minusLikeNum:(DrugGuideLikeCountModelR *)para
             success:(void (^)(id model))success
             failure:(void (^)(HttpException *err))failure
{
    [[HttpClient sharedInstance] post:LikeCountsDecrease
                               params:[para dictionaryModel]
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

+ (void)queryNewDiseaseList:(QueryDrugGuideNewItemModelR *)para
                    success:(void (^)(id model))success
                    failure:(void (^)(HttpException *err))failure
{
    [[HttpClient sharedInstance] get:QueryNewDiseaseList
                               params:[para dictionaryModel]
                              success:^(id resultObj) {
                                  DrugGuideCheckNewMsgListModel *newMsgList = [DrugGuideCheckNewMsgListModel parse:resultObj Elements:[DrugGuideCheckNewMsgModel class] forAttribute:@"list"];
                                  if (success) {
                                      success(newMsgList);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)drugGuidePushMesWithParams:(NSDictionary *)params
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:DrugGuidePushMsg params:params success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)drugGuideReadDotWithParams:(NSDictionary *)params
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:DrugGuideReadDot params:params success:^(id responseObj) {
        
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
