//
//  SpmApi.m
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "SpmApi.h"


@implementation SpmApi

//搜索症状-------------------------------------------------------------
+(void)querySearchSpmkwidWithParam:(id)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QuerySpmByKwId
                              params:[param dictionaryModel]
                             success:^(id resultObj) {
                                 SpmListPage *kwid=[SpmListPage parse:resultObj Elements:[SpmSearchId class] forAttribute:@"list"];
                                 if (success) {
                                     success(kwid);
                                 }
                             }
                             failure:^(HttpException *e) {
                                 DebugLog(@"%@",e);
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}

//头部下级部位
+ (void)QuerySpmBodyWithParams:(SpmBodyHeadModelR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:QuerySpmBody
                              params:[param dictionaryModel]
                             success:^(id responseObj) {
                                 SpmListByBodyPage *model=[SpmListByBodyPage parse:responseObj Elements:[SpmBodyHeadModel class] forAttribute:@"list"];
                                 
                                     if (success) {
                                         success(model);
                                     }
                             }
                             failure:^(HttpException *e) {
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}

//根据部位查询相关症状
+ (void)QuerySpmInfoListByBodyWithParams:(SpmListByBodyModelR *)param
                                 success:(void (^)(id))success
                                 failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:NW_querySpmInfoListByBody
                              params:[param dictionaryModel]
                             success:^(id responseObj) {
//        SpmListByBodyPage *model=[SpmListByBodyPage parse:responseObj Elements:[SpmListModel class] forAttribute:@"list"];
//                                     if (success) {
//                                         success(model);
//                                     }
                                 if (success) {
                                     success(responseObj);
                                 }
                                   }
                             failure:^(HttpException *e) {
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}


//症状百科
+ (void)QuerySpmInfoListWithParams:(SpmListModelR *)param
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:NW_querySpmInfoList
                              params:[param dictionaryModel]
                             success:^(id resultObj) {
//            SpmListByBodyPage *modelArr=[SpmListByBodyPage parse:resultObj Elements:[SpmListModel class] forAttribute:@"list"];
//                                 if (success) {
//                                     success(modelArr);
//                                 }
        //变成字典的，速度变快
                                 if (success) {
                                     success(resultObj);
                                 }
                                 
                             }
                             failure:^(HttpException *e) {
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
    
}
//症状详情页面
+(void)queryspminfoDetailProductListWithParam:(id)model Success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    [[HttpClient sharedInstance] get:NW_spmInfoDetail params:[model dictionaryModel] success:^(id responseObj) {
        
        spminfoDetail *model = [spminfoDetail parse:responseObj Elements:[spminfoDetailPropertiesModel class] forAttribute:@"properties"];
        if (success) {
            success(model);
        }
        
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



//------------------------------------------------------------------------


@end
