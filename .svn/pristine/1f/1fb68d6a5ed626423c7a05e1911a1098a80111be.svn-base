//
//  Activity.h
//  APP
//
//  Created by Meng on 15/3/19.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "ActivityModel.h"
#import "ActivityModelR.h"

@interface Activity : NSObject

/**
 *  @brief 3.6.7	新营销活动详情
 *
 *  add by Meng(new framework)
 */
+ (void)getActivityWithParam:(id)param
                     success:(void (^)(id DFModel))succsee
                     failure:(void (^)(HttpException *e))failure;
/**
 *  从Banner进入营销活动详情
 */
+ (void)getActivityFromBanner:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure;

+(void)grabBusinessActivityList:(GrabActivityHomePageModelR *)param
                        success:(void (^)(GrabActivityVoModel *responModel))success
                        failure:(void (^)(HttpException *e))failure;

+ (void)getBannerActivityWithParam:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure;


/**
 *  获取指定药店的优惠活动
 */
+ (void)getStoreBranchPromotion:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure;

/**
 *  获取抢购商品信息
 **/
+(void)getGrabPromotionProduct:(GrabActivityModelR *)param
                       success:(void (^)(GrabProductListVo *responModel))success
                       failure:(void (^)(HttpException *e))failure;

/**
 *  抢购商品动作
 **/

+(void)postPurchaseProduct:(PurchaseGrabProductR *)param
                   success:(void (^)(PurchaseGrabProduct *responModel))success
                   failure:(void (^)(HttpException *e))failure;


/**
 *  首页抢购数据
 **/

+(void)grabHomePageActivityList:(GrabActivityHomePageModelR *)param
                        success:(void (^)(GrabActivityVoModel *responModel))success
                        failure:(void (^)(HttpException *e))failure;

/**
 *  首页频道活动
 **/

+(void)channelHomeActivity:(ChannelHomeModelR *)param
                   success:(void (^)(ChannelActivityArrayVoModel *responModel))success
                   failure:(void (^)(HttpException *e))failure;
/**
 *  频道活动商品
 **/
+(void)getChannelProductList:(ChannelProductListR *)param
                     success:(void (^)(ChannelProductArrayVo *responModel))success
                     failure:(void (^)(HttpException *e))failure;
/**
 *  活动维度的商品详情
 **/
+(void)getActivityPurchList:(ActivityPurchListR *)param
                    success:(void (^)(ChannelProductVo *responModel))success
                    failure:(void (^)(HttpException *e))failure;

/**
 *  请求中奖纪录
 **/
+(void)getWonAwards:(QueryWonAwardsR *)param
            success:(void (^)(LuckdrawAwardListVo *responModel))success
            failure:(void (^)(HttpException *e))failure;
/**
 *  请求微商开通情况下抢购商品详情
 **/
+(void)getRushProductList:(QueryRushProductR *)param success:(void(^)(GrabActivityRushVo *model))success failure:(void(^)(HttpException *e))failure;

@end