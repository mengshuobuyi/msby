//
//  MallCartModel.h
//  APP
//
//  Created by garfield on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseAPIModel.h"
#import "BasePrivateModel.h"
#import "ReceiveAddress.h"
@class DeliveryTypeVoModel;
@class PayTypeVoModel;


@interface MallCartModel : BaseAPIModel

@end

/**
 *  套餐List数据 Model add by lijian
 *  V3.1
 */
@interface CartPackageList : BaseAPIModel

@property (nonatomic, strong) NSArray *list;

@end

/**
 *  套餐数据Model add by lijian
 *  V3.1
 */
@interface CartPackageVO : BaseAPIModel

@property (nonatomic, strong) NSString *packageId;//套餐id
@property (nonatomic, strong) NSString *desc;   //套餐描述,
@property (nonatomic, strong) NSString *price;  //套餐价格,
@property (nonatomic, strong) NSString *reduce; //立减价格,
@property (nonatomic, strong) NSArray *druglist;//药品集合

@end

/**
 *  套餐商品数据Model add by lijian
 *  V3.1
 */
@interface CartPackageDrugVO : BaseAPIModel

@property (nonatomic, strong) NSString *branchProId;//商品id
@property (nonatomic, strong) NSString *name;   //药品名称
@property (nonatomic, strong) NSString *spec;   //规格
@property (nonatomic, strong) NSString *imgUrls;//图片
@property (nonatomic, strong) NSString *price;  //价格
@property (nonatomic, strong) NSString *count;  //数量
@end

@interface CartVoModel : BaseAPIModel

@property (nonatomic, strong) NSMutableArray       *branchs;

@end

@interface CartBranchVoModel : BaseAPIModel

@property (nonatomic, strong) NSString          *branchId;      //药店ID
@property (nonatomic, strong) NSString          *branchName;    //药店名称
@property (nonatomic, strong) NSString          *groupName;     //药店所属商家名称
@property (nonatomic, strong) NSMutableArray    *products;      //商品列表
@property (nonatomic, assign) BOOL              supportOnlineTrading;         //是否支持网络交易,
@property (nonatomic, assign) BOOL              choose;         //选中状态
@property (nonatomic, assign) double            timeStamp;      //时间戳
@property (nonatomic, strong) NSMutableArray    *combos;        //套餐列表
@property (nonatomic, strong) NSMutableArray    *redemptions;      //换购列表
@property (nonatomic, strong) NSMutableArray    *availableRedemptions;  //门店换购列表
@end

@interface CartProductVoModel : BaseAPIModel

@property (nonatomic, strong) NSString       *id;
@property (nonatomic, strong) NSString       *code;
@property (nonatomic, strong) NSString       *name;
@property (nonatomic, strong) NSString       *brand;
@property (nonatomic, strong) NSString       *spec;
@property (nonatomic, strong) NSString       *imgUrl;
@property (nonatomic, strong) NSString       *price;

@property (nonatomic, strong) NSMutableArray        *promotions;
@property (nonatomic, strong) NSString       *promotionId;
@property (nonatomic, assign) NSInteger      promotionCounts;
@property (nonatomic, assign) NSInteger      quantity;
@property (nonatomic, assign) NSInteger      stock; //库存
@property (nonatomic, assign) NSInteger      saleStock; //优惠库存
@property (nonatomic, assign) BOOL           choose;
@property (nonatomic, assign) BOOL           sync;
@property (nonatomic, assign) double         timeStamp;
@property (nonatomic, strong) NSString       *barcode;
@property (nonatomic, strong) NSString       *factory;
@property (nonatomic, strong) NSArray        *imgUrls;
@property (nonatomic, assign) BOOL           inPromotion;

@property (nonatomic, strong) NSString       *userScore;//工业品赠送用户积分数

@end

@interface CartPromotionVoModel : BaseAPIModel


@property (nonatomic, strong) NSString       *id;
@property (nonatomic, strong) NSString       *title;
@property (nonatomic, assign) NSInteger      type;          //1.买赠 2.折扣 3.立减 4.特价 5.抢购 6.礼品,
@property (nonatomic, assign) NSInteger      showType;      //1.券 2.惠 3.抢,
@property (nonatomic, assign) double         value;
@property (nonatomic, assign) double         unitNum;
@property (nonatomic, assign) double         limitConsume;
@property (nonatomic, assign) NSInteger      limitQty;      //限xx件
@property (nonatomic, assign) NSInteger      presentNum;
@property (nonatomic, strong) NSString       *presentUnit;
@property (nonatomic, strong) NSString       *presentName;
@property (nonatomic, assign) NSInteger      presentTotalNum;
@property (nonatomic, assign) NSInteger      timeStatus;
@property (nonatomic, strong) NSString       *rushTitle;
@property (nonatomic, strong) NSString       *validityDate;

@property (nonatomic, assign) NSInteger      times;
@property (nonatomic, assign) BOOL           onlyApp;      //「优惠券专用-微信」是否仅限App使用,
@property (nonatomic, assign) BOOL           enableWx;     //「优惠券专用-微信」是否可用
@property (nonatomic, assign) BOOL           onlySupportOnlineTrading;     //「优惠券专用」是否仅限在线支付使用


@end

@interface CartComboVoModel : BaseAPIModel

@property (nonatomic, strong) NSString       *packageId;        // 套餐ID,
@property (nonatomic, strong) NSString       *desc;             // 商品描述
@property (nonatomic, assign) double         price;             // 套餐价
@property (nonatomic, assign) double         reduce;            // 立减金额,
@property (nonatomic, strong) NSArray        *druglist;         //套餐图片,
@property (nonatomic, assign) double         quantity;          //购买数量
@property (nonatomic, assign) BOOL           choose;

@end

@interface ComboProductVoModel : BaseAPIModel

@property (nonatomic, strong) NSString       *packageId;        // 套餐ID,
@property (nonatomic, strong) NSString       *desc;
@property (nonatomic, assign) double         reduce;            // 立减金额,
@property (nonatomic, assign) double         combosPrice;             // 套餐价
@property (nonatomic, strong) NSString       *branchProId;       //商品ID
@property (nonatomic, strong) NSString       *imgUrl;           //图片
@property (nonatomic, strong) NSString       *spec;             //规格
@property (nonatomic, assign) NSInteger      count;             //套餐内数量
@property (nonatomic, strong) NSString       *name;             //名称
@property (nonatomic, assign) double         price;             //原价
@property (nonatomic, assign) NSInteger      showType;          // 1:顶部   2:中间   3:底部   4:只显示一条
@property (nonatomic, assign) NSInteger         quantity;          //购买数量
@property (nonatomic, assign) BOOL           choose;

@end

@interface CartRedemptionVoModel : BaseAPIModel

@property (nonatomic, strong) NSString       *actId;            //换购活动ID
@property (nonatomic, strong) NSString       *desc;         //换购活动标题
@property (nonatomic, strong) NSString       *proImgUrl;        //商品图片
@property (nonatomic, strong) NSString       *proName;          //商品名称
@property (nonatomic, strong) NSString       *proSpec;          //商品规格
@property (nonatomic, assign) double         price;             //原价
@property (nonatomic, assign) double         salePrice;         //换购价
@property (nonatomic, strong) NSString       *branchProId;        //商品ID
@property (nonatomic, assign) double         limitPrice;        //换购满足金额
@property (nonatomic, assign) NSInteger      quantity;          //购买数量
@property (nonatomic, assign) BOOL           choose;
@property (nonatomic, assign) double         currentConsume;

@end





@interface MicroMallCartPreviewVoModel : BaseAPIModel

@property (nonatomic,assign) double         accounts;
@property (nonatomic,assign) double         discountAccounts;
@property (nonatomic,strong) NSString       *couponDiscountAccounts;
@property (nonatomic,assign) double         deliveryFee;
@property (nonatomic,assign) double         payableAccounts;
@property (nonatomic, strong) NSArray       *coupons;       //CartPromotionVo  数组
@property (nonatomic, strong) NSArray       *deliveryTypes; //DeliveryTypeVo   数组
@property (nonatomic, strong) NSArray       *branchs;       //CartBranchVo     数组
@property (nonatomic, strong) DeliveryTypeVoModel       *selectedDeliveryType;      //本次选择的配送方式
@property (nonatomic,strong) NSString       *deliveryBegin;
@property (nonatomic,strong) NSString       *deliveryEnd;
@property (nonatomic, strong) NSArray       *payTypes;
@property (nonatomic, strong) PayTypeVoModel            *selectedPayType;           //本次选择的支付方式
@property (nonatomic,strong) NSString       *orderPmt;// 订单优惠
@property (nonatomic,strong) NSArray        *couponList;    //券列表。店铺优惠，新
@property (nonatomic,strong) NSString       *cityName;// (java.lang.String): 药房所在城市
@property (nonatomic,strong) AddressVo      *address;
@end

@interface CartOnlineCouponVoModel : BaseAPIModel

@property (nonatomic, assign) BOOL top;
@property (nonatomic,strong) NSString  *couponId;
@property (nonatomic,strong) NSString  *tag;//标签，新
@property (nonatomic,strong) NSString  *myCouponId;
@property (nonatomic,strong) NSString  *groupId;
@property (nonatomic,strong) NSString  *groupName;
@property (nonatomic,strong) NSString  *couponValue;
@property (nonatomic,strong) NSString  *couponTag;
@property (nonatomic,strong) NSString  *begin;
@property (nonatomic,strong) NSString  *end;
@property (nonatomic) BOOL  chronic;
@property (nonatomic) BOOL  pick;
@property (nonatomic) BOOL  empty;
@property (nonatomic) NSInteger  scope; //券类型。1.通用代金券，2.慢病专享代金券，4.礼品券，5.商品券,
@property (nonatomic,strong) NSString  *giftImgUrl;
@property (nonatomic,strong) NSString  *distance;//距离
@property (nonatomic,strong) NSString *couponRemark;
@property (nonatomic, assign) NSInteger status; //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期
@property (nonatomic, assign) NSInteger limitLeftCounts;        //剩余领取次数
@property (nonatomic, strong) NSString *priceInfo;//优惠商品券
@property (nonatomic, assign) BOOL      onlySupportOnlineTrading;   //仅限在线支付使用
@property (nonatomic, assign) BOOL      onlyApp;            //「优惠券专用-微信」是否仅限App使用
@property (nonatomic, assign) BOOL      enableWx;           //「优惠券专用-微信」是否可用
@property (nonatomic, strong) NSString  *intro;             // 券简介

@end



@interface PayTypeVoModel : BaseAPIModel

@property (nonatomic, strong) NSString      *imgUrl;        //支付图标
@property (nonatomic, strong) NSString      *title;         //支付标题
@property (nonatomic, assign) NSInteger     type;           //支付类型。1.当面支付 2.在线支付

@end


@interface DeliveryTypeVoModel : BaseAPIModel
@property (nonatomic,strong) NSString          *title ;// 标题,
@property (nonatomic,strong) NSString          *timeSliceTip;//服务时间段,
@property (nonatomic,strong) NSString          *feeTip; //费用,
@property (nonatomic,strong) NSString          *manTip ;//包邮提示,
@property (nonatomic,assign) NSInteger         type;//配送方式：1.到店自提 2.送货上门 3.快递,
@property (nonatomic,strong) NSString          *content;// 显示提示,
@property (nonatomic,strong) NSString          *tip;//不可用提示
@property (nonatomic,assign) BOOL              available;//是否可用。ture可用 false不可用,
@property (nonatomic,assign) NSInteger         chooseType;

@end

@interface MicroMallCartCompleteVoModel : BaseAPIModel

@property (nonatomic, strong) NSString      *branchName;
@property (nonatomic, strong) NSString      *orderId;
@property (nonatomic, strong) NSString      *confirmCode;
@property (nonatomic, assign) NSInteger     deliveryType;
@property (nonatomic, assign) double        *payableAccounts;
@property (nonatomic, strong) NSArray       *tips;
@property (nonatomic, strong) NSString      *orderCode;
@property (nonatomic, strong) NSString      *hint;

@end

@interface ProductTabooVoModel : BaseAPIModel

@property (nonatomic, strong) NSString      *proName;
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSString      *tabooContent;
@property (nonatomic, strong) NSString      *result;
@property (nonatomic, strong) NSString      *taboo;        //新的禁忌拼接字段

@end

@interface ProFoodTabooListVoModel : BaseAPIModel

@property (nonatomic, strong) NSArray       *tips;

@end


@interface ChooseStatusModel : BaseModel

@property (nonatomic, assign) NSInteger     quanity;
@property (nonatomic, strong) NSString      *objId;
@property (nonatomic, assign) BOOL          choose;

@end




