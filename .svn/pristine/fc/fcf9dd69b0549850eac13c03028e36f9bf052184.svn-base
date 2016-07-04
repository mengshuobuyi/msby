//
//  Store.h
//  APP
//
//  Created by qw on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "ProblemModel.h"
#import "StoreModelR.h"
#import "StoreModel.h"

@interface Store : NSObject

/**
 *  @brief 开通城市检查
 *
 *  add by Meng
 */
+ (void)storeSearchOpenCityCheckWithPara:(StoreSearchOpenCityCheckModelR *)param
                                 success:(void (^)(id DFModel))success
                                 failure:(void(^)(HttpException *e))failure;
/**
 *  @brief 附近药房
 *
 *  fixed by lijian
 */
+ (void)getNearByStoreWithParam:(StoreSearchRegionModelR *)param withPromotion:(BOOL)promotion success:(void (^)(id))success
                           failure:(void(^)(HttpException *e))failure;
/**
 *  @brief 搜索药房
 *
 *  add by lijian 2.2.0
 */
+ (void)searchStoreWithParam:(StoreSearchRegionModelR *)param
                     success:(void (^)(id))success
                     failure:(void(^)(HttpException *e))failure;
/**
 *  查询有优惠活动的门店
 */

+ (void)branchSearchPromotionWithParams:(NSDictionary *)param
                    success:(void(^)(id))success
                    failure:(void(^)(HttpException * e))failure;

@end
