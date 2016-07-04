//
//  CouponModel.h
//  APP
//
//  Created by 李坚 on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface BannerList : BaseAPIModel
@property (nonatomic) NSArray *banners;
@end

@interface Banner : BaseAPIModel

@property (nonatomic) NSString *obj;
@property (nonatomic) NSString *img;
@property (nonatomic) NSString *type;

@end

@interface CouponListModel : BaseAPIModel

@property (nonatomic) NSString *page;
@property (nonatomic) NSString *pageSize;
@property (nonatomic) NSString *pageSum;
@property (nonatomic) NSString *totalRecords;
@property (nonatomic) NSArray  *list;

@end

@interface CouponNewListModel : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *imgUrl;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *desc;
@property (nonatomic, strong) NSString  *replyText;
@property (nonatomic, strong)NSString  *pushStatus;


@end


@interface CouponDetailModel : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *remark;
@property (nonatomic) NSString *limitPersonTimes;
@property (nonatomic) NSString *limitTotal;
@property (nonatomic) NSString *statTotal;
@property (nonatomic) NSString *statPro;
@property (nonatomic) NSString *statBranch;
@property (nonatomic) NSString *validBegin;
@property (nonatomic) NSString *validEnd;
@property (nonatomic) NSString *over;
@property (nonatomic) NSString *largess;
@property (nonatomic) NSString *branchCount;
@property (nonatomic) NSArray *products;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *pushStatus;

@end


@interface ProductsModel : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *proId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *spec;
@property (nonatomic) NSString *factory;
@property (nonatomic) NSString *unit;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *promotionType;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

@end


@interface CouponConsuletListModel : BaseAPIModel

@property (nonatomic) NSArray *list;
@property (nonatomic) NSString *page;
@property (nonatomic) NSString *pageSize;
@property (nonatomic) NSString *pageSum;
@property (nonatomic) NSString *totalRecords;
@end

@interface CouponConsuletModel : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *addr;
@property (nonatomic) NSString *shortName;

@end

@interface CouponBranchVoListModel : BaseAPIModel

@property (nonatomic) NSString *suitableBranchCount;
@property (nonatomic) NSArray *suitableBranchs;

@end

@interface CouponBranchVoModel : BaseAPIModel
@property (nonatomic) NSString *branchId;
@property (nonatomic) NSString *branchName;
@property (nonatomic) NSString *branchLogo;
@property (nonatomic) NSString *stars;
@property (nonatomic) NSString *contact;
@property (nonatomic) NSString *online;
@property (nonatomic) NSString *distance;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *longitude;
@property (nonatomic) NSString *latitude;
@property (nonatomic) NSString *type;//类型：1.未开通微商药房 2.社会药房 3.开通微商药房
@property (nonatomic) NSString *cityOpenStatus;//1.城市未开通服务 2.城市未开通微商 3.城市开通微商

@end

@interface MyCouponDetailVoListModel : BaseAPIModel

@property (nonatomic) BOOL     canUserShare;
@property (nonatomic) NSString *tag;
@property (nonatomic) NSString *couponId;
@property (nonatomic) NSString *couponValue;
@property (nonatomic) NSString *couponTag;
@property (nonatomic) NSString *groupId;
@property (nonatomic) NSString *groupName;
@property (nonatomic) NSString *begin;
@property (nonatomic) NSString *end;
@property (nonatomic) NSString *chronic;
@property (nonatomic) NSString *source;
@property (nonatomic) NSString *scope;//券类型0.全部，1.通用代金券，2.慢病专享代金券，3.全部代金券，4.礼品券 5.商品券
@property (nonatomic) NSString *status; //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期,
@property (nonatomic) NSString *giftImgUrl;//礼品券URL
@property (nonatomic) BOOL top;
@property (nonatomic) NSString *frozen;//是否被冻结
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *couponTitle;
@property (nonatomic) NSString *couponRemark;
@property (nonatomic) NSString *couponNumLimit; //优惠券数量
@property (nonatomic) NSString *suitableProductCount;
@property (nonatomic) NSString *suitableBranchCount;
@property (nonatomic) NSString *myCouponId;
@property (nonatomic) NSString *pick;//是否已领取
@property (nonatomic) NSString *empty;//是否已领完
@property (nonatomic) NSArray  *suitableBranchs;
@property (nonatomic) BOOL      open;

@property (nonatomic) NSString *use;
@property (nonatomic) NSString *consumedBranch;
//
////我的优惠券属性(去使用，已使用，已过期)
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic) NSString *evaluated;
@property (nonatomic) NSString *priceInfo;//优惠商品券
@end

@interface CouponConditionVoListModel : BaseAPIModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *conditions;
@end


//400版本新的model
@interface OnlineCouponDetailVo : BaseAPIModel

@property (nonatomic) NSString *couponId;
@property (nonatomic) NSString *couponValue;
@property (nonatomic) NSString *couponTag;
@property (nonatomic) NSString *groupId;
@property (nonatomic) NSString *groupName;//所属商家名称。简称已做处理,
@property (nonatomic) NSString *begin;
@property (nonatomic) NSString *end;
@property (nonatomic) NSString *chronic;
@property (nonatomic) NSString *source;
@property (nonatomic) NSString *scope;//1.通用代金券，2.慢病专享代金券，4.礼品券，5.商品券, 6.折扣券, 7.优惠商品券, 8.兑换券,
@property (nonatomic) NSString *status; //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期,
@property (nonatomic) NSString *giftImgUrl;//礼品券URL
@property (nonatomic) BOOL top;
@property (nonatomic) NSString *frozen;//是否被冻结
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *couponTitle;
@property (nonatomic) NSString *couponRemark;
@property (nonatomic) NSString *couponNumLimit; //剩余领取次数,
@property (nonatomic) NSString *suitableProductCount;//适用商品数量,
@property (nonatomic) NSString *suitableBranchCount;//适用分店数量,
@property (nonatomic) BOOL     empty;//是否已领完
@property (nonatomic) BOOL     canUserShare;//用户端是否能够分享
@property (nonatomic) BOOL     canEmpShare;//商户端是否能够分享
@property (nonatomic) NSString *tag;// 券标签，新
@property (nonatomic) NSString *priceInfo;//优惠商品券 价值信息。仅3.0及之后的优惠商品券取本字段,
@property (nonatomic) BOOL     onlySupportOnlineTrading;//: 仅限在线支付使用,
@property (nonatomic) NSString *myCouponId;//领取优惠券ID
@property (nonatomic) NSString *pick;//是否已领取
@property (nonatomic) NSArray  *suitableBranchs;//适用分店列表。只展示最近一个
@property (nonatomic) CouponConditionVoListModel  *condition;//优惠细则
@property (nonatomic) BOOL     suitable;//药房是否适用此券;

//@property (nonatomic) BOOL      open;
//@property (nonatomic) NSString *use;
//@property (nonatomic) NSString *consumedBranch;
//////我的优惠券属性(去使用，已使用，已过期)
//@property (nonatomic,strong) NSString *orderId;
//@property (nonatomic) NSString *evaluated;

@end


//400版本新的model
@interface MyCouponDetailVo : BaseAPIModel

@property (nonatomic) NSString *couponId;
@property (nonatomic) NSString *myCouponId;
@property (nonatomic) NSString *couponValue;
@property (nonatomic) NSString *couponTag;
@property (nonatomic) NSString *groupId;
@property (nonatomic) NSString *groupName;//所属商家名称。简称已做处理,
@property (nonatomic) NSString *begin;
@property (nonatomic) NSString *end;
@property (nonatomic) NSString *chronic;
@property (nonatomic) NSString *status; //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期,
@property (nonatomic) NSString *suitableProductCount;//适用商品数量,
@property (nonatomic) NSString *suitableBranchCount;//适用分店数量,
@property (nonatomic) NSArray  *suitableBranchs;//适用分店列表。只展示最近一个
@property (nonatomic) NSString *frozen;//是否被冻结
@property (nonatomic) NSString *scope;//1.通用代金券，2.慢病专享代金券，4.礼品券，5.商品券, 6.折扣券, 7.优惠商品券, 8.兑换券,
@property (nonatomic) NSString *giftImgUrl;//礼品券URL
@property (nonatomic) BOOL top;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *couponRemark;
@property (nonatomic) NSString *couponTitle;
@property (nonatomic) BOOL      open;
@property (nonatomic) NSString *couponNumLimit; //剩余领取次数,
@property (nonatomic) BOOL     canUserShare;//用户端是否能够分享
@property (nonatomic) BOOL     canEmpShare;//商户端是否能够分享
@property (nonatomic) NSString *tag;// 券标签，新
@property (nonatomic) BOOL     fromMicroMall;//是否来自微商
@property (nonatomic) NSString *priceInfo;//优惠商品券 价值信息。仅3.0及之后的优惠商品券取本字段,
@property (nonatomic) CouponConditionVoListModel  *condition;//优惠细则
@property (nonatomic) NSString *code;//买单验证码
@property (nonatomic) BOOL     suitable;//药房是否适用此券;

@property (nonatomic) NSString *use;//是否用过
//@property (nonatomic) NSString *consumedBranch;
//////我的优惠券属性(去使用，已使用，已过期)
//@property (nonatomic,strong) NSString *orderId;
//@property (nonatomic) NSString *evaluated;

@end






@interface OnlineCouponDetailVoListModel : BaseAPIModel

@property (nonatomic) NSString *couponId;
@property (nonatomic) NSString *couponValue;
@property (nonatomic) NSString *couponTag;
@property (nonatomic) NSString *groupName;
@property (nonatomic) NSString *groupId;
@property (nonatomic) NSString *begin;
@property (nonatomic) NSString *end;
@property (nonatomic) BOOL chronic;
@property (nonatomic,assign) NSInteger  scope;
@property (nonatomic) NSString *giftImgUrl;
@property (nonatomic) NSString *myCouponId;
@property (nonatomic) BOOL pick;
@property (nonatomic) BOOL empty;
@property (nonatomic) NSString  *status;
@property (nonatomic) BOOL top;
@property (nonatomic) BOOL frozen;
@property (nonatomic) NSString *suitableBranchCount;
@property (nonatomic) NSArray  *suitableBranchs;
@property (nonatomic) NSString *priceInfo;//优惠商品券

@end

@interface CouponProductVoListModel : BaseAPIModel

@property (nonatomic) NSString *suitableProductCount;
@property (nonatomic) NSArray  *suitableProducts;

@end

@interface ConditionAmountVoListModel : BaseAPIModel

@property (nonatomic) NSInteger conditionCounts;
@property (nonatomic) NSArray  *conditions;

@end

@interface ConditionAmountVoModel : BaseAPIModel

@property (nonatomic) NSInteger max;
@property (nonatomic) NSInteger min;

@end

@interface CouponProductVoModel : BaseAPIModel

@property (nonatomic) NSString  *productId;
@property (nonatomic) NSString  *productName;
@property (nonatomic, strong) NSString  *productLogo;
@property (nonatomic) NSString  *spec;
@property (nonatomic) NSString  *factory;
@property (nonatomic) NSString  *branchProId;//门店商品ID
@property (nonatomic) NSString  *branchId;//门店ID

@end

@interface MyCouponVoModel : BaseAPIModel

@property (nonatomic) BOOL      canUserShare;
@property (nonatomic) NSString  *couponId;
@property (nonatomic) NSString  *myCouponId;
@property (nonatomic) NSString  *couponValue;
@property (nonatomic) NSString  *couponTag;
@property (nonatomic) NSString  *groupName;
@property (nonatomic) NSString  *groupId;   // comment by perry
@property (nonatomic) NSString  *begin;
@property (nonatomic) NSString  *end;
@property (nonatomic) NSString  *use;
@property (nonatomic) BOOL      top;
@property (nonatomic) NSString  *chronic;
@property (nonatomic) NSString  *evaluated;
@property (nonatomic) NSString  *status;    //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期,
@property (nonatomic) NSString  *frozen;//是否被冻结，只用于已领取
@property (nonatomic) NSString  *scope; //1.通用代金券，2.慢病专享代金券，4.礼品券，5.商品券,6.折扣券, 7.优惠商品券,
@property (nonatomic) NSString  *giftImgUrl;//礼品券图片URL
@property (nonatomic) NSString  *tag;
@property (nonatomic) NSString  *pick;
@property (nonatomic) NSString  *couponRemark;
@property (nonatomic) BOOL      open;
@property (nonatomic) BOOL fromMicroMall;// 是否来自微商(3.0) addByZpx
@property (nonatomic) NSString *priceInfo;//优惠商品券
@property (nonatomic) NSString *suitableProductCount;//(优惠商品的适用数量)

- (id)initWithMyCouponVoModel:(MyCouponDetailVoListModel *)model;


@end

@interface CouponOrderCheckVo : BaseAPIModel

@property (strong, nonatomic) NSString *presentType;       // 赠送类型。Q\P
@property (strong, nonatomic) NSArray  *presentPromotions; //赠送商品列表
@property (strong, nonatomic) NSArray  *presentCoupons;    //赠送优惠券列表
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *gift;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *myCouponId;
@property (nonatomic, strong) NSString *branchName;
@property (nonatomic, strong) NSArray  *gifts;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *giftImgUrl;
@property (nonatomic, strong) NSString *couponTitle;
@property (nonatomic, strong) NSString *couponRemark;

@end

@interface CouponGiftVoModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *imgUrl;


@end

//赠送优惠商品
@interface PresentPromotionVo : BaseModel

@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *name;

//2.2.4做了分享的调整，由原来的分享大礼包变成分享使用前的优惠券和优惠商品
//这个字段和PresentCouponVo不用
@property (nonatomic, strong) NSString *proDrugId;

@end

//赠送优惠券
@interface PresentCouponVo : BaseModel

@property (nonatomic, strong) NSString *couponId;

@end




@interface MyOverdueCouponVoListModel : BaseAPIModel

@property (nonatomic) NSString  *page;
@property (nonatomic) NSString  *pageSize;
@property (nonatomic) NSArray   *coupons;

@end


@interface MyUsedCouponVoListModel : BaseAPIModel

@property (nonatomic) NSString  *page;
@property (nonatomic) NSString  *pageSize;
@property (nonatomic) NSArray   *coupons;

@end



@interface MyCouponVoListModel : BaseAPIModel

@property (nonatomic) NSString  *page;
@property (nonatomic) NSString  *pageSize;
@property (nonatomic) NSArray   *coupons;

@end

@interface BranchCouponListVoModel : BaseAPIModel

@property (nonatomic) NSArray   *coupons;

@end


@interface OnlineCouponVoListModel : BaseAPIModel

@property (nonatomic) NSArray   *topCoupons;
@property (nonatomic) NSArray   *coupons;
@property (nonatomic) NSString  *page;
@property (nonatomic) NSString  *pageSize;

@end

@interface OnlineCouponVoModel : BaseAPIModel

@property (nonatomic, assign) BOOL top;
@property (nonatomic) NSString  *couponId;
@property (nonatomic) NSString  *tag;//标签，新
@property (nonatomic) NSString  *myCouponId;
@property (nonatomic) NSString  *groupId;
@property (nonatomic) NSString  *groupName;
@property (nonatomic) NSString  *couponValue;
@property (nonatomic) NSString  *couponTag;
@property (nonatomic) NSString  *begin;
@property (nonatomic) NSString  *end;
@property (nonatomic) BOOL  chronic;
@property (nonatomic) BOOL  pick;
@property (nonatomic) BOOL  empty;
@property (nonatomic) NSInteger  scope; //券类型。1.通用代金券，2.慢病专享代金券，4.礼品券，5.商品券,
@property (nonatomic) NSString  *giftImgUrl;
@property (nonatomic) NSString  *distance;//距离
@property (nonatomic) NSString *couponRemark;
@property (nonatomic, assign) NSInteger status; //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期
@property (nonatomic) NSInteger limitLeftCounts;        //剩余领取次数
@property (nonatomic) NSString *priceInfo;//优惠商品券

@end

@interface CouponPickVoModel : BaseAPIModel

@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *myCouponId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *begin;
@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSString *cityOpenStatus;//城市服务状态：1.城市未开通服务 2.城市未开通微商 3.城市开通微商

@end

@interface UseMyCouponVoModel : BaseAPIModel

@property (nonatomic) NSString  *myCouponId;
@property (nonatomic) NSString  *code;
@property (nonatomic) NSString  *orderId;

@end


/**
 *  3.15.2	[用户端][扫码]查询优惠活动
 */
@interface CouponEnjoyModel : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *remark;
@property (nonatomic) NSString *limitPersonTimes;
@property (nonatomic) NSString *limitTotal;
@property (nonatomic) NSString *statTotal;
@property (nonatomic) NSString *statPro;
@property (nonatomic) NSString *statBranch;
@property (nonatomic) NSString *validBegin;
@property (nonatomic) NSString *validEnd;
@property (nonatomic) NSString *factory;
@property (nonatomic) NSString *proId;
@property (nonatomic) NSString *proName;
@property (nonatomic) NSString *spec;
@property (nonatomic) NSString *unit;
@property (nonatomic) NSString *useTimes;
@property (nonatomic) NSString *useTotal;
@property (nonatomic) NSString *largess;
@property (nonatomic) NSString *over;
@property (nonatomic) NSString *orderCreateTime;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *msg;
@property (nonatomic) NSString  * price;

@end

@interface GenerateQRcode : BaseAPIModel

@property (nonatomic) NSString *status;
@property (nonatomic) NSString *views;
@property (nonatomic) NSString *priceMax;
@property (nonatomic) NSString *priceMin;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *msg;

@end


//新的优惠码验证
@interface NewGenerateQRcode : BaseAPIModel
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *views;
@end

@interface diseaseDetaileIos : BaseAPIModel

@property (nonatomic,strong)NSString *diseaseId;//疾病ID
@property (nonatomic,strong)NSString *name;//疾病名称
@property (nonatomic,strong)NSString *desc;//疾病描述
@property (nonatomic,strong)NSString *relatedSymption;//相关症状
@property (nonatomic,strong)NSString *relatedDisease;//相关疾病
@property (nonatomic,strong)NSString *hiddenSymption;//隐藏症状
@property (nonatomic,strong)NSString *hiddenDisease;//隐藏疾病
@property (nonatomic,strong)NSString *diseaseTraitTitle;//疾病特点（标题）
@property (nonatomic,strong)NSString *diseaseTraitContent;//疾病特点
@property (nonatomic,strong)NSString *similarDiseaseTitle;//易混淆疾病（标题）
@property (nonatomic,strong)NSString *similarDiseaseContent;//易混淆疾病
@property (nonatomic,strong)NSString *treatRuleTitle;//治疗原则（标题）
@property (nonatomic,strong)NSString *treatRuleContent;//治疗原则
@property (nonatomic,strong)NSString *goodHabitTitle;//合理生活习惯（标题）
@property (nonatomic,strong)NSString *goodHabitContent;//合理生活习惯
@property (nonatomic,strong)NSString *diseaseCauseTitle;//病因（标题）
@property (nonatomic,strong)NSString *diseaseCauseContent;//病因
@property (nonatomic,strong)NSString *preventContent;//预防
@property (nonatomic,strong)NSString *diseaseSummarize;//综述 C类疾病
@property (nonatomic,strong)NSString *type;//疾病类型 A: 类型A  B:类型B  C:类型C
@property (nonatomic,strong)NSArray  *formulaList;//组方列表 jsonArray
@property (nonatomic,strong)NSArray  *formulaDetail;//组方详细 jsonArray

@end
/**
 *  3.15.15	[用户端]订单检测 – 详细
 */
@interface barnchInfo : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *views;
@property (nonatomic) NSString *useTimes;
@property (nonatomic) NSString *useTotal;
@property (nonatomic) NSString *status;

@end


@interface PromotionBarnchInfo : BaseAPIModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *avgStar;
@property (nonatomic) NSString *star;
@property (nonatomic) NSString *tel;
@property (nonatomic) NSArray  *tags;
@property (nonatomic) NSString *promotionSign;
@property (nonatomic) NSString *active;
@property (nonatomic) NSString *accountId;
@property (nonatomic) NSString *shortName;

@property (nonatomic) NSString *isStar;
@end

@interface PromotionBarnchInfoTag : BaseAPIModel

@property (nonatomic) NSString *key;
@property (nonatomic) NSString *tag;

@end

//药房详情获取优惠券列表 add by lijian 2.2.0
@interface pharmacyCouponQuanList : BaseModel

@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *totalRecords;
@property (nonatomic,strong) NSArray *list;

@end
//药房详情获取优惠券 add by lijian 2.2.0
@interface pharmacyCouponQuan : BaseModel

@property (nonatomic,strong) NSString *tag;
@property (nonatomic,strong) NSString *giftImgUrl;
@property (nonatomic,strong) NSString *myCouponId;
@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *couponValue;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *groupName;
@property (nonatomic,strong) NSString *chronic;
@property (nonatomic,strong) NSString *over;//是否已领完
@property (nonatomic,strong) NSString *pick;//是否已领取(需要Token)
@property (nonatomic,strong) NSString *source;
@property (nonatomic,strong) NSString *startDate;
@property (nonatomic,strong) NSString *endDate;
@property (nonatomic,strong) NSString *couponTag;
@property (nonatomic,strong) NSString *scope;//券类型。0.全部，1.通用代金券，2.慢病专享代金券，3.全部代金券，4.礼品券，5.商品券,
@property (nonatomic,strong) NSString *couponRemark; //优惠券备注
@property (nonatomic) NSString *priceInfo;//优惠商品券
@end

//药房详情获取优惠商品 add by lijian 2.2.0
@interface pharmacyCouponDrug : BaseModel

@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *proId;
@property (nonatomic,strong) NSString *proName;
@property (nonatomic,strong) NSString *spec;
@property (nonatomic,strong) NSString *factory;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *label;
@property (nonatomic,strong) NSNumber *type;
@property (nonatomic,strong) NSString *promotionId;
@property (nonatomic,strong) NSString *source;
@property (nonatomic,strong) NSString *startDate;
@property (nonatomic,strong) NSString *endDate;

@end

//跑马灯进入详情 add by lijian 2.2.0
@interface activityDetailModel : BaseModel

@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSString *packPromotionId;
@property (nonatomic,strong) NSString *groupName;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSArray *coupons;
@property (nonatomic,strong) NSString *branchName;
@property (nonatomic,strong) NSString *branchImgUrl;

@end

@interface PromotionListModel : BaseModel

@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSArray *list;

@end

//我的优惠商品列表 add by lijian 2.2.0
@interface MyDrugVoList : BaseModel

@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSArray *list;

@end


//我的优惠商品 add by lijian 2.2.0
@interface MyDrugVo : BaseModel

@property (nonatomic,strong) NSString *proDrugId;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *proName;
@property (nonatomic,strong) NSString *label;
@property (nonatomic,strong) NSString *spec;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *beginTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *expiredSoon;
@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *useTime;
@property (nonatomic,strong) NSString *status;//状态（1：已领取 2：已使用 3：已过期）
@property (nonatomic,strong) NSString *frozen;//是否被冻结，只用于已领取
@property (nonatomic,assign) BOOL     open;//是否是公开的优惠商品

@end

//我的优惠商品详情 add by lijian 2.2.0
@interface BranchListVo : BaseModel

@property (nonatomic,strong) NSString *promotionTitle;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSArray *branchVoList;//适用药房、消费药房
@property (nonatomic,strong) NSString *branchCount;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *proId;
@property (nonatomic,strong) NSString *promotionId;

@property (nonatomic,strong) NSString *proDrugId;
@property (nonatomic,strong) NSString *proName;
@property (nonatomic,strong) NSString *label;
@property (nonatomic,strong) NSString *spec;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *beginTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *expiredSoon;
@property (nonatomic,strong) NSString *useTime;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *commnetId;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *star;

@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *frozen;
@property (nonatomic,assign) BOOL open;
@property (nonatomic,assign) BOOL canUserShare;
@end

@interface BranchVo : BaseModel

@property (nonatomic,strong) NSString *branchId;
@property (nonatomic,strong) NSString *branchName;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *star;
@property (nonatomic,strong) NSString *online;
@property (nonatomic,strong) NSString *tel;


@end

@interface DeleteDrugModelR : BaseModel

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *proDrugId;

@end

@interface CouponProBranchListVoModel : BaseAPIModel

@property (nonatomic, strong) NSArray *branchVoList;
@property (nonatomic, strong) NSString *branchCount;

@end

@interface CouponProBranchVoModel : BaseAPIModel

@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *branchName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *online;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *proDiscountPrice;

@end



@interface BranchPromotionProListVo : BaseAPIModel
@property (nonatomic, strong) NSArray *pros;
@end

@interface BranchPromotionProVO : BaseAPIModel
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *factory;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *promotionId;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSArray *categorys;

@property(nonatomic)BOOL isSelect;//是否展开
@end

@interface SuitableMicroMallBranchListVo : BaseAPIModel
@property (nonatomic, strong) NSString *suitableBranchCount;
@property (nonatomic, strong) NSArray *suitableBranchs;
@end

@interface SuitableMicroMallBranchVo : BaseAPIModel
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *branchName;//名称
@property (nonatomic, strong) NSString *address;//地址
@property (nonatomic, strong) NSString *distance;//距离。距您3.1km
@property (nonatomic, strong) NSString *stars;//星级
@property (nonatomic, strong) NSString *type;//类型：1.未开通微商药房 2.社会药房 3.开通微商药房
@end


