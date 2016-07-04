//
//  Factory.m
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Factory.h"



@implementation Factory


/**
 *  3.3.29	获取生产厂家列表
 */
+ (void)queryFactoryListWithParam:(FactoryModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
    [HttpClientMgr get:GetFactoryList params:[params dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([FactoryDetailModel class])];
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        FactoryListModel *factoryList = [FactoryListModel parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(factoryList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


/**
 *  3.3.30	获取产品列表
 */
+ (void)queryFactoryProductListWithParam:(FactoryProductListModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
    [HttpClientMgr get:GetFactoryProductList params:[params dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([FactoryProduct class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        
        FactoryProductList *productsList = [FactoryProductList parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(productsList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



/**
 *  3.3.30	获取厂家详情
 */
+ (void)queryFactoryDetailWithParam:(FactoryDetailModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
    
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:GetFactoryDetail params:[params dictionaryModel] success:^(id responseObj) {
        
       
        FactoryDetailModel *model = [FactoryDetailModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



@end

