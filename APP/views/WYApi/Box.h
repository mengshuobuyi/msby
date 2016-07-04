//
//  Box.h
//  APP
//
//  Created by garfield on 15/3/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "QueryMyboxModelR.h"
#import "QueryMyBoxModel.h"


@interface Box : NSObject

/**
 *  @brief 3.1.1 查询我的用药列表
 *
 *  add by Cat
 */
+ (void)queryMyBoxWithParams:(QueryMyboxModelR *)param
                         success:(void (^)(id))success
                         failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.2 根据关键字查询我的用药
 *
 *  add by Cat
 */
+ (void)queryBoxByKeywordWithParams:(QueryBoxByKeywordModelR *)param
                            success:(void (^)(id))success
                            failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.3 根据标签查询我的用药
 *
 *  add by Cat
 */
+ (void)queryBoxByTagWithParams:(QueryBoxByTagModelR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.4 添加更新我的用药
 *
 *  add by Cat
 */
+ (void)saveOrUpdateMyBoxWithParams:(SaveOrUpdateMyBoxModelR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.5 用药详情
 *
 *  add by Cat
 */
+ (void)GetBoxProductDetailWithParams:(GetBoxProductDetailR *)param
                              success:(void (^)(id))success
                              failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.6 删除我的用药
 *
 *  add by Cat
 */
+ (void)DeleteBoxProductWithParams:(DeleteBoxProductR *)param
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.7 更新用药的药效的标签
 *
 *  add by Cat
 */
+ (void)UpdateBoxProductTagWithParams:(UpdateBoxProductTagR *)param
                              success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.8 同效药品列表
 *
 *  add by Cat
 */
+ (void)SimilarDrugWithParams:(SimilarDrugR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.9 我的用药所有标签
 *
 *  add by Cat
 */
+ (void)QueryAllTagsWithParams:(QueryAllTagsR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure;

/**
 *  @brief 3.1.10 获取药品的用法用量信息
 *
 *  add by Cat
 */
//+ (void)GetProductUsageWithParams:(QueryMyboxModelR *)param
//                          success:(void (^)(id))success
//                          failure:(void (^)(HttpException *))failure;


@end
