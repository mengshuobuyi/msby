//
//  Promotion.h
//  APP
//
//  Created by qw on 15/3/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "PromotionModelR.h"
#import "PromotionModel.h"
#import "BannerModel.h"
#import "Activity.h"
#import "CouponModel.h"

@interface Promotion : NSObject

/**
 *  @brief 获取首页的banner图片
 */
+ (void)queryBannerWithParams:(PromotionModelR *)param
                      success:(void(^)(id DFUserModel))success
                      failure:(void(^)(HttpException * e))failure;


//附近优惠商品列表 add by lijian 2.2.0
+ (void)queryNearByPromotionListWithParams:(NearByPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//筛选条件：商品标签列表 add by lijian 2.2.0
+ (void)queryNearByPromotionTagWithParams:(TagModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//筛选条件：药厂标签列表 add by lijian 2.2.0
+ (void)queryNearByPromotionGroupTagWithParams:(TagModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;

//商品所属活动适用药房列表 add by lijian 2.2.0
+ (void)queryPromotionBranchWithParams:(PromotionGroupModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;

//商品所属商家列表 add by lijian 2.2.0
+ (void)queryPromotionGroupWithParams:(PromotionGroupModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//领取优惠 add by lijian 2.2.0
+ (void)pickPromitionDrug:(PickPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//生成code add by lijian 2.2.0
+ (void)createVerifyCode:(CreateVerifyCodeModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//轮询订单是否被商家验证 add by lijian 2.2.0
+ (void)loopCheck:(LoopCheckModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//评价 add by lijian 2.2.0
+ (void)baseComment:(commnetModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
//查看我的评价 add by lijian 2.2.0
+ (void)checkMyComment:(commnetModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;



//附近优惠商品列表 add by cj 2.2.3
+ (void)queryNewNearByPromotionListWithParams:(NewNearByPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;
+ (void)queryNewNearByTwoListWithParams:(NewNearByPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure;

@end
