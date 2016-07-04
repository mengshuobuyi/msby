//
//  Coupon.h
//  APP
//
//  Created by 李坚 on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"
#import "HttpClient.h"
#import "CouponModel.h"
#import "CouponModelR.h"
#import "PromotionModel.h"

@interface Coupon : BaseModel

/**
 *  优惠券领取成功页面优惠券适用门店列表 add by lijian At 3.0.0
 */
+ (void)PickSuccessSuitableBranchs:(GetOnlineCouponModelR *)mode success:(void (^)(SuitableMicroMallBranchListVo *))success failure:(void (^)(HttpException *))failure;

+(void)couponBranchSuitable:(CouponBranchSuitableModelR *)mode success:(void (^)(CouponBranchVoListModel *))success failure:(void (^)(HttpException *))failure;

+(void)couponOrderCheck:(CouponOrderCheckVoModelR *)mode success:(void (^)(CouponOrderCheckVo *))success failure:(void (^)(HttpException *))failure;

+(void)couponGetMyCoupon:(CouponGetModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponProductSuitable:(CouponProductSuitableModelR *)mode success:(void (^)(CouponProductVoListModel *))success failure:(void (^)(HttpException *))failure;

+(void)couponAssess:(CouponAssessModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponAssessQuery:(CouponAssessQueryModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponBranchBuy:(CouponBranchBuyModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponCheck:(CouponCheckModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponPick:(CouponPickModelR *)mode success:(void (^)(CouponPickVoModel *))success failure:(void (^)(HttpException *))failure;

+(void)couponPickByMobile:(CouponPickByMobileModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponProductBuy:(CouponProductBuyModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponQueryOnlineByCustomer:(CouponQueryOnlineByCustomerModelR *)mode success:(void (^)(OnlineCouponVoListModel *model))success failure:(void (^)(HttpException *))failure;

+(void)couponQueryBranchFournNew:(BranchFournNewModelR *)mode success:(void (^)(BranchCouponListVoModel *model))success failure:(void (^)(HttpException *))failure;

+ (void)couponQueryInCity:(CouponQueryInCityModelR *)mode success:(void (^)(OnlineCouponVoListModel *model))success failure:(void (^)(HttpException *))failure;

+(void)couponQueryOverdueByCustomer:(CouponQueryOverdueByCustomerModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+ (void)getOnlineCoupon:(GetOnlineCouponModelR *)mode success:(void (^)(MyCouponDetailVoListModel *))success failure:(void (^)(HttpException *))failure;

+(void)couponGetOnlineCoupon:(GetOnlineCouponModelR *)mode success:(void (^)(OnlineCouponDetailVoListModel *))success failure:(void (^)(HttpException *))failure;

+(void)couponQueryUnusedByCustomer:(CouponQueryUnusedByCustomerModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponConditions:(BaseAPIModel *)mode success:(void (^)(ConditionAmountVoListModel *model))success failure:(void (^)(HttpException *))failure;

//领券中心筛选条件:药房 add by lijian 2.2.4
+(void)couponCityConditions:(CouponListModelR *)mode success:(void (^)(GroupFilterListVo *model))success failure:(void (^)(HttpException *))failure;

+(void)couponQueryUsedByCustomer:(CouponQueryUsedByCustomerModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponUse:(CouponUseModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)couponShow:(CouponShowModelR *)mode success:(void (^)(UseMyCouponVoModel *))success failure:(void (^)(HttpException *))failure;

//药房详情获取优惠券 add by lijian 2.2.0
+(void)pharmacyCouponQuan:(pharmacyCouponModelR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//药房详情获取优惠券 add by lijian V3.1.1
+ (void)mallBranchCouponQuan:(pharmacyCouponModelR *)model success:(void (^)(OnlineCouponVoListModel *))success failure:(void (^)(HttpException *))failure;

//药房详情获取优惠商品 add by lijian 2.2.0
+(void)pharmacyCouponDrug:(pharmacyCouponModelR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//药房详情获取优惠商品 add by cj 2.2.3
+(void)pharmacyCouponDrugNew:(pharmacyProductModelR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//跑马灯进入详情获取数据 add by lijian 2.2.0
+(void)getAvtivityDetail:(activityDetailModelR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//跑马灯进入详情获取活动商品数据 add by lijian 2.2.0
+(void)getAvtivityDetailPromotion:(activityDetailModelR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//我的优惠券（已领取） add by lijian 2.2.0
+(void)myCouponQuanPicked:(myCouponQuanModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//我的优惠券（已使用） add by lijian 2.2.0
+(void)myCouponQuanUsed:(myCouponQuanModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//我的优惠券（已过期） add by lijian 2.2.0
+(void)myCouponQuanDated:(myCouponQuanModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//我的优惠商品（包括已领取、已使用、已过期,status区分） add by lijian 2.2.0
+(void)myCouponDrug:(myCouponDrugModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//我的优惠商品详情 add by lijian 2.2.0
+(void)myCouponDrugDetail:(myCouponDrugDetailModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//我的活动商品适用药房 add by lijian 2.2.0
+(void)promotionDrugBranch:(drugBranchModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//慢病优惠券适用商品 add by lijian 2.2.0
+(void)suitableDrug:(onlineCouponModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//冻结优惠券移除方法 add by lijian 2.2.0
+(void)removeQuan:(removeQuanModelR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//冻结优惠商品移除方法 add by lijian 2.2.0
+(void)removeDrug:(DeleteDrugModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//优惠商品的适用药房列表 add by perry 2.2.3
+(void)getCouponPharmacy:(CouponBranchSuitableModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//优惠细则个数
+(void)getCouponCondition:(CouponConditionModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//新的优惠券详情
+ (void)getNewOnlineCoupon:(GetNewOnlineCouponModelR *)mode success:(void (^)(MyCouponDetailVoListModel *))success failure:(void (^)(HttpException *))failure;

//400版本
+(void)couponCenterShow:(CouponShowModelR *)mode success:(void (^)(UseMyCouponVoModel *))success failure:(void (^)(HttpException *))failure;

+(void)couponSuitableDrug:(GetCouponDetailProductModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;


+ (void)getCenterCouponDetail:(GetCenterCouponDetailModelR *)mode success:(void (^)(OnlineCouponDetailVo *))success failure:(void (^)(HttpException *))failure;

+(void)getMyCouponDetail:(GetMyCouponDetailModelR *)mode success:(void (^)(id))success failure:(void (^)(HttpException *))failure;


/**
 *  优惠券适用药房列表接口，用于领券中心优惠券详情
 *  fixed by lijian at V3.2.0
 *  @param modelR  CouponNewBranchSuitableModelR
 *  @param success CouponBranchVoListModel
 *  @param failure HttpException
 */
+(void)getNewCouponPharmacy:(CouponNewBranchSuitableModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
/**
 *  优惠券适用药房列表接口，用于我的优惠券详情
 *  fixed by lijian at V3.2.0
 *  @param modelR  CouponNewBranchSuitableModelR
 *  @param success CouponBranchVoListModel
 *  @param failure HttpException
 */
+(void)getMyCouponPharmacy:(CouponNewBranchSuitableModelR *)modelR success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+(void)actCouponPick:(ActCouponPickModelR *)mode success:(void (^)(CouponPickVoModel *))success failure:(void (^)(HttpException *))failure;

@end
