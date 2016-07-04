//
//  Factory.h
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "FactoryModel.h"
#import "FactoryModelR.h"

@interface Factory : NSObject


/**
 *  3.3.29	获取生产厂家列表
 */
+ (void)queryFactoryListWithParam:(FactoryModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;

/**
 *  3.3.30	获取生产厂家商品列表
 */
+ (void)queryFactoryProductListWithParam:(FactoryProductListModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;


/**
 *  3.3.30	获取厂家详情
 */
+ (void)queryFactoryDetailWithParam:(FactoryDetailModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;

@end