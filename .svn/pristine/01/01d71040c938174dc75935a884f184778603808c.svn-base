//
//  Problem.m
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Problem.h"
#import "Constant.h"
#import "ProblemModelR.h"

@implementation Problem

//问题类型
+ (void)moduleClassWithParams:(ProblemModuleR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure
{
//    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:QueryFamiliarQuestionChannel params:[param dictionaryModel] success:^(id responseObj) {
        
        if ([responseObj[@"apiStatus"] intValue] == 0) {
            
            NSArray *modelArray = [ProblemModule parseArray:responseObj[@"list"]];
            if (success) {
                success(modelArray);
            }
        }else
        {
            DDLogVerbose(@"error");
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

//首页问题模块
+ (void)moduleHomeClassWithParams:(ProblemHomeModuleR *)param
                          success:(void (^)(id array))success
                          failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:QueryProblemModel params:[param dictionaryModel] success:^(id responseObj) {
        
        if ([responseObj[@"apiStatus"] intValue] == 0) {
            
            NSArray *modelArray = [ProblemHomeModel parseArray:responseObj[@"list"]];
            if (success) {
                success(modelArray);
            }
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
    
}

//常见用药问题列表
+ (void)listWithParams:(ProblemListModelR *)param
               success:(void (^)(id))success
               failure:(void (^)(HttpException *))failure
{
       
    [[HttpClient sharedInstance] get:QueryFamiliarQuestionList
                               params:[param dictionaryModel]
                              success:^(id resultObj) {
                                  
                                  ProblemListPage *pa = [ProblemListPage parse:resultObj Elements:[ProblemListModel class] forAttribute:@"list"];
//                                  DDLogVerbose(@"pa ==== %@",pa);
                                  if (success) {
                                      success(pa);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//问题详情
+ (void)detailWithParams:(ProblemDetailModelR *)param
                 success:(void (^)(id))success
                 failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:QueryFamiliarQuestionDetail
                               params:[param dictionaryModel]
                              success:^(id resultObj) {
                                  
                                  if ([resultObj[@"apiStatus"] intValue] == 0) {
                                      
                                      ProblemListPage *page = [ProblemListPage parse:resultObj Elements:[ProblemDetailModel class] forAttribute:@"list"];
                                      if (success) {
                                          success(page);
                                      }
                                  }
                                  
                              }
                              failure:^(HttpException *e) {
                                 
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}
//+(void)spmAssociationDiseaseWithParams:(id)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
//    [[HttpClient sharedInstance] post:NW_queryAssociationDisease
//                               params:[param dictionaryModel]
//                              success:^(id resultObj) {
//                                  
//                                  spmAssociationDisease *page = [spmAssociationDisease parse:resultObj];
//                                  if (success) {
//                                      success(page);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
//}

+ (void)ProblemListByModuleWithParams:(NSDictionary *)param
                              success:(void(^)(id obj))success
                              failure:(void(^)(HttpException * e))failure
{
    [HttpClientMgr get:ProblemListByModule params:param success:^(id responseObj) {
        
        ProblemListPage *pa = [ProblemListPage parse:responseObj Elements:[ProblemListModel class] forAttribute:@"list"];
        if (success) {
            success(pa);
        }

        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

@end
