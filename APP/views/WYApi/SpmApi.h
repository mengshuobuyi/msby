//
//  SpmApi.h
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "SpmModel.h"
#import "SpmModelR.h"

@interface SpmApi : NSObject


/**
 *  搜索症状---------------------------------------------------------------------------------------------------
 *
 */
+(void)querySearchSpmkwidWithParam:(id)param
                            success:(void (^)(id))success
                            failure:(void (^)(HttpException *))failure;


/**
 *  获取身体部位（头部）
 *
 */
+ (void)QuerySpmBodyWithParams:(SpmBodyHeadModelR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure;


/**
 *  获取部位下关联的症状
 *
 */
+ (void)QuerySpmInfoListByBodyWithParams:(SpmListByBodyModelR *)param
                                 success:(void (^)(id))success
                                 failure:(void (^)(HttpException *))failure;




/**
 *  症状列表
 *
 */
+ (void)QuerySpmInfoListWithParams:(SpmListModelR *)param
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure;


//3.3.35	症状明细
+ (void)queryspminfoDetailProductListWithParam:(id)model
                                       Success:(void(^)(id DFUserModel))success
                                       failure:(void(^)(HttpException * e))failure;

//---------------------------------------------------------------------------------------------------
@end
