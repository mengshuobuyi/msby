//
//  CouponModelR.h
//  APP
//
//  Created by 李坚 on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface CouponModelR : BaseModel

@end

@interface CouponListModelR : BaseModel

@property (nonatomic) NSString *page;       //请求页码。选填
@property (nonatomic) NSString *pageSize;   //页面大小。选填
@property (nonatomic) NSString *province;   //省编码。可选
@property (nonatomic) NSString *city;       //市编码。可选

@end

@interface CouponDeatilModelR : BaseModel

@property (nonatomic) NSString *promotion;       //优惠活动的ID

@end


@interface CouponConsuletR : BaseModel

@property (nonatomic) NSString *promotion;
@property (nonatomic) NSString *page;       //请求页码。选填
@property (nonatomic) NSString *pageSize;   //页面大小。选填

@end

@interface GenerateQRcodeR : BaseModel

@property (nonatomic) NSString *token;      //登陆凭证。必填
@property (nonatomic) NSString *pro;        //商品编码。必填
@property (nonatomic) NSString *price;      //商品单价。必填
@property (nonatomic) NSString *quantity;   //商品数量。必填
@property (nonatomic) NSString *promotion;  //活动ID。必填
@property (nonatomic) NSString *inviter;

@end
/**
 *  3.3.12	疾病明细查询(ios)
 */
@interface diseaseDetaileIosR : BaseModel
@property (nonatomic,strong)NSString *diseaseId;//疾病ID
@property (nonatomic,strong)NSString *diseaseName;
@end
/**
 *  3.15.15	[用户端]订单检测 – 详细
 */
@interface barnchInfoR : BaseModel

@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *code;

@end
/**
 *  3.15.2	[用户端][扫码]查询优惠活动
 */
@interface ScanModelR : BaseModel

@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *proId;

@end

@interface GetOnlineCouponModelR : BaseModel

@property (nonatomic,strong) NSString   *token;
@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong)NSString *groupId;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSNumber *lng;
@property (nonatomic,strong) NSNumber *lat;

@end

@interface GetNewOnlineCouponModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;

@end

//400版本
@interface GetCouponDetailProductModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *branchId;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;

@end


@interface GetCenterCouponDetailModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;
@property (nonatomic,strong) NSString *branchId;

@end


@interface GetMyCouponDetailModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;
@property (nonatomic,strong) NSString *branchId;

@end



@interface PromotionBranchModelR : BaseModel

@property (nonatomic,strong) NSString *promotionId;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *currPage;
@property (nonatomic,strong) NSString *pageSize;


@end

@interface CouponProductModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;

@end

@interface CouponOrderCheckVoModelR : BaseModel

@property (nonatomic,strong) NSString *orderId;

@end

@interface CouponPharBranchModelR : BaseModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;

@end

@interface CouponBranchSuitableModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,assign) NSString *view;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;

@end

@interface CouponGetModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;

@end

@interface CouponProductSuitableModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;

@end

@interface CouponAssessModelR : BaseModel

@property (nonatomic,strong) NSString *myCouponId;

@end

@interface CouponAssessQueryModelR : BaseModel

@property (nonatomic,strong) NSString *myCouponId;

@end

@interface CouponBranchBuyModelR : BaseModel

@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;

@end

@interface CouponCheckModelR : BaseModel

@property (nonatomic,strong) NSString *code;

@end

@interface CouponPickModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *platform;
@property (nonatomic,strong) NSString *city;

@end

@interface ActCouponPickModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *platform;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString *marketingCaseId;

@end

@interface CouponPickByMobileModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *mobile;

@end

@interface CouponProductBuyModelR : BaseModel

@property (nonatomic,strong) NSString *coupomyCouponIdnId;

@end

@interface CouponQueryInCityModelR : BaseModel

@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *groupId;     //筛选条件：药房名称2.2.4
@property (nonatomic,strong) NSString *amountRange; //筛选条件：满额金额区间。形如 30#QZSP#_100 / #QZSP#100 / 30#QZSP#_
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;

@end


@interface CouponQueryOnlineByCustomerModelR : BaseModel

//@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *all;
@property (nonatomic,strong) NSString *groupId;     //筛选条件：药房名称2.2.4
@property (nonatomic,strong) NSString *scope;       //筛选条件：券类型。0.全部，1.通用，2.慢病专享
@property (nonatomic,strong) NSString *amountRange; //筛选条件：满额金额区间。形如 30#QZSP#_100 / #QZSP#100 / 30#QZSP#_
@property (nonatomic,strong) NSString *sort;        //排序规则。1.默认排序，2.优惠金额从低到高，3.优惠金额从高到底
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;

@end

@interface BranchFournNewModelR : BaseModel

@property (nonatomic,strong) NSString *branchId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,assign) NSInteger currPage;
@property (nonatomic,assign) NSInteger pageSize;


@end



@interface CouponQueryOverdueByCustomerModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *all;

@end

@interface CouponQueryUnusedByCustomerModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *all;

@end

@interface CouponQueryUsedByCustomerModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *all;

@end

@interface CouponUseModelR : BaseModel

@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *deviceCode;

@end

@interface CouponShowModelR : BaseModel

@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *couponId;

@end

//药房详情获取优惠券/优惠商品 add by lijian 2.2.0
@interface pharmacyCouponModelR : BaseModel

@property (nonatomic,strong) NSString *branchId;
@property (nonatomic,strong) NSNumber *currPage;
@property (nonatomic,strong) NSNumber *pageSize;
@property (nonatomic,strong) NSString *token;

@end

//药房详情获取优惠券/优惠商品 add by CJ 2.2.3
@interface pharmacyProductModelR : BaseModel

@property (nonatomic,strong) NSString *branchId;
@property (nonatomic,strong) NSNumber *currPage;
@property (nonatomic,strong) NSNumber *pageSize;
@property (nonatomic,strong) NSString *index;

@end


//跑马灯进入详情获取优惠券数据 add by lijian 2.2.0
@interface activityDetailModelR : BaseModel

@property (nonatomic,strong) NSString *packPromotionId;
@property (nonatomic,strong) NSString *branchId;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSNumber *currPage;
@property (nonatomic,strong) NSNumber *pageSize;

@end




//我的优惠券 add by lijian 2.2.0
@interface myCouponQuanModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *pageSize;

@end

//我的优惠商品 add by lijian 2.2.0
@interface myCouponDrugModelR : BaseModel

@property (nonatomic,strong) NSNumber *status;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSNumber *page;
@property (nonatomic,strong) NSNumber *pageSize;

@end

//我的优惠商品详情 add by lijian 2.2.0
@interface myCouponDrugDetailModelR : BaseModel

@property (nonatomic,strong) NSNumber *status;
@property (nonatomic,strong) NSString *proDrugId;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;

@end

//我的优惠商品详情 add by lijian 2.2.0
@interface onlineCouponModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;

@end

//我的活动商品适用药房 add by lijian 2.2.0
@interface drugBranchModelR : BaseModel

@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;

@end

//我的活动商品适用药房 add by lijian 2.2.0
@interface removeQuanModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *myCouponId;

@end


@interface CouponConditionModelR : BaseModel
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *id;
@end

@interface CouponNewBranchSuitableModelR : BaseModel

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *branchId;


@end































