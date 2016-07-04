//
//  Appraise.m
//  APP
//
//  Created by qw on 15/3/13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Appraise.h"

@implementation Appraise

//检查会话是否评价过 AppraiseExist
+ (void)appraiseExistWithParams:(NSDictionary *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:AppraiseExist params:param success:^(id obj) {
        AppraiseModel *appraiseModel = [AppraiseModel parse:obj];
        if (success) {
            success(appraiseModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)addAppraiseWithParams:(AddAppraiseModelR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:AddAppraise params:[param dictionaryModel] success:^(id Obj) {
        if (success) {
            success(Obj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)queryAppraiseWithParams:(id)param
                        success:(void(^)(id resultObj))success
                        failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] get:GetAppraise params:[param dictionaryModel] success:^(id Obj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([StoreAppraiseModel class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"appraises"];
        
        QueryAppraiseModel *queryAppraiseModel = [QueryAppraiseModel parse:Obj ClassArr:keyArray Elements:valueArray];
        if (success) {
            success(queryAppraiseModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)appraiseByConsultGetParams:(GetAppraiseModelR *)param
                           success:(void(^)(AppraiseByConsultGetModel *resultObj))success
                           failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] get:AppraiseByConsult params:[param dictionaryModel] success:^(id Obj) {
        AppraiseByConsultGetModel *appraiseModel = [AppraiseByConsultGetModel parse:Obj];
        if (success) {
            success(appraiseModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)appraiseByConsultWithParams:(AppraiseByConsultModelR *)param
                            success:(void(^)(AppraiseByConsultModel *resultObj))success
                            failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:AppraiseByConsult params:[param dictionaryModel] success:^(id Obj) {
        AppraiseByConsultModel *queryAppraiseModel = [AppraiseByConsultModel parse:Obj];
        if (success) {
            success(queryAppraiseModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

// 获取药店评价
+ (void)getAppraiseByConsultWithParams:(GetAppraiseModelR *)param
                               success:(void(^)(AppraiseByConsultModel *resultObj))success
                               failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:AppraiseByConsult params:[param dictionaryModel] success:^(id Obj) {
//        AppraiseByConsultModel *queryAppraiseModel = [AppraiseByConsultModel parse:Obj];
        if (success) {
            success(Obj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

@end
