//
//  DrugGuideApi.h
//  APP
//
//  Created by chenzhipeng on 3/13/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrugGuideModelR.h"
#import "HttpClient.h"
#import "DrugGuideItemModelR.h"

@interface DrugGuideApi : NSObject

/**
 *  慢病订阅列表页面
 *
 *  @param para    相应参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
//+ (void)getDrugGuideList:(DrugGuideListModelR *)para
//                 success:(void (^)(id array))success
//                 failure:(void (^)(HttpException *err))failure;

/**
 *  慢病订阅消息列表页面
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)queryMsgLogList:(DrugMsgLogListModelR *)para
                success:(void (^)(id model))success
                failure:(void (^)(HttpException *err))failure;

/**
 *  慢病列表
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)queryAttentionList:(DrugGuideAttentionModelR *)para
                success:(void (^)(id model))success
                failure:(void (^)(HttpException *err))failure;


/**
 *  保存慢病订阅
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)saveDrugGuideItem:(SaveDrugGuideItemModelR *)para
                  success:(void (^)(id model))success
                  failure:(void (^)(HttpException *err))failure;

/**
 *  删除慢病订阅
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)deleteDrugGuideItem:(DeleteDrugGuideItemModelR *)para
                    success:(void (^)(id model))success
                    failure:(void (^)(HttpException *err))failure;
/**
 *  慢病订阅添加喜欢
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)addLikeNum:(DrugGuideLikeCountModelR *)para
           success:(void (^)(id model))success
           failure:(void (^)(HttpException *err))failure;


/**
 *  慢病订阅减少喜欢
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)minusLikeNum:(DrugGuideLikeCountModelR *)para
             success:(void (^)(id model))success
             failure:(void (^)(HttpException *err))failure;

/**
 *  获取标新的慢病
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)queryNewDiseaseList:(QueryDrugGuideNewItemModelR *)para
             success:(void (^)(id model))success
             failure:(void (^)(HttpException *err))failure;


/**
 *  获取慢病指导信息，弹框提醒与小红点显示
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)drugGuidePushMesWithParams:(NSDictionary *)params
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure;

/**
 *  设置小红点已读
 *
 *  @param para
 *  @param success
 *  @param failure
 */
+ (void)drugGuideReadDotWithParams:(NSDictionary *)params
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure;


@end


