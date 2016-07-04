//
//  Store.m
//  APP
//
//  Created by qw on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Store.h"
#import "AppraiseModel.h"
#import "ActivityModel.h"
@implementation Store

/**
 *  @brief 开通城市检查
 *
 *  add by Meng
 */
+ (void)storeSearchOpenCityCheckWithPara:(StoreSearchOpenCityCheckModelR *)param
                                 success:(void (^)(id result))success
                                 failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:Store_checkOpencity params:[param dictionaryModel] success:^(id responseObj) {
        StoreSearchOpenCityCheckModel *model = [StoreSearchOpenCityCheckModel parse:responseObj];
        
        model = [StoreSearchOpenCityCheckModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
/**
 *  @brief 附近药店
 *
 *  fixed by lijian（2.2.0修改）
 */
+ (void)getNearByStoreWithParam:(StoreSearchRegionModelR *)param withPromotion:(BOOL)promotion
                           success:(void (^)(id))success
                           failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    NSString *url = BranchLbs;
    //根据promotion判断请求的是普通药房还是优惠药房
    if(promotion == YES){
        url = BranchPromotionLbs;
    }else{
        url = BranchLbs;
    }
    
    [[HttpClient sharedInstance] get:url params:[param dictionaryModel] success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/**
 *  @brief 关键字搜索药店
 *
 *  add by lijian（2.2.0修改）
 */
+ (void)searchStoreWithParam:(StoreSearchRegionModelR *)param
                        success:(void (^)(id))success
                        failure:(void(^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:BranchLbs params:[param dictionaryModel] success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)branchSearchPromotionWithParams:(NSDictionary *)param
                                success:(void(^)(id))success
                                failure:(void(^)(HttpException * e))failure
{
    [HttpClientMgr get:BranchSearchPromotion params:param success:^(id responseObj) {
        
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
