//
//  OrdersModel.h
//  APP
//
//  Created by qw_imac on 16/1/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseModel.h"
#import "BaseAPIModel.h"

@interface OrdersModel : BaseModel

@end
@interface OrderList : BaseAPIModel
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *pageSum;
@property (nonatomic,strong) NSString *totalRecords;
@end

@interface MicroMallOrderVO : BaseModel
@property(nonatomic,strong)NSString* orderId;//订单Id
@property(nonatomic,strong)NSString* orderCode;//订单Code
@property(nonatomic,strong)NSString* branchName;//门店名称,
@property(nonatomic,strong)NSString* branchMobile;// 门店联系方式，多个手机号用逗号隔开,
@property(nonatomic,strong)NSString* deliver;//配送方式（1:到店自提 2:送货上门 3:快递）,
@property(nonatomic,strong)NSString* orderStatus;//用户订单显示状态（1:已提交、2:待配送、3:配送中、 6:待取货、8:已取消、9:已收货、10:待付款）,
@property(nonatomic,strong)NSString* workStart;// 门店营业开始时间,
@property(nonatomic,strong)NSString* workEnd ;// 门店营业结束时间,
@property(nonatomic,strong)NSString* deliverStart; // 门店配送开始时间,
@property(nonatomic,strong)NSString* deliverEnd;//门店配送结束时间,
@property(nonatomic,strong)NSString* finalAmount;// 商品总额,
@property(nonatomic,strong)NSString* waybillNo;// 快递单号,
@property(nonatomic,strong)NSString* expressCompany;//快递公司,
@property(nonatomic,strong)NSString* appraiseStatus;// 评价状态（1:待评价 2:已评价）,
@property(nonatomic,strong)NSArray* microMallOrderDetailVOs;// 订单商品列表
@property(nonatomic,strong)NSString *payType;//支付方式（1：当面付款 2：在线支付）
@property(nonatomic,strong)NSString *deliverLast;//门店最晚发货时间
@property(nonatomic,strong)NSString *serviceTel;// 客服电话
@end

@interface MicroMallOrderDetailVO : BaseModel//列表用的
@property (nonatomic,strong) NSString *productCode; //商品编码
@property (nonatomic,strong) NSString *imgUrl;//商品图片
@end

@interface OperateUseOrderModel : BaseAPIModel

@end

@interface UserOrderDetialVO : BaseAPIModel
@property (nonatomic,strong) NSString *orderId ;// 订单id,
@property (nonatomic,strong) NSString *orderCode; // 订单编码,
@property (nonatomic,strong) NSString *branchName; // 门店名称,
@property (nonatomic,strong) NSString *branchId;//门店id
@property (nonatomic,strong) NSString *branchMobile; // 门店联系方式,
@property (nonatomic,strong) NSString *orderStatus; // 用户订单显示状态（1:已提交、2:待配送、3:配送中、 6:待取货、8:已取消、9:已收货）,
@property (nonatomic,strong) NSString *workStart; // 营业开始时间,
@property (nonatomic,strong) NSString *workEnd; // 营业结束时间,
@property (nonatomic,strong) NSString *deliverStart; // 配送开始时间,
@property (nonatomic,strong) NSString *deliverEnd; // 配送结束时间,
@property (nonatomic,strong) NSString *finalAmount; // 合计金额,
@property (nonatomic,strong) NSString *create; //下单时间,
@property (nonatomic,strong) NSString *receiver; // 收货人姓名,
@property (nonatomic,strong) NSString *receiverTel;// 收货人手机号,
@property (nonatomic,strong) NSString *deliverType; // 配送方式（1:到店自提 2:送货上门 3:快递）,
@property (nonatomic,strong) NSString *deliverStatus; // 配送状态（1:待配送 2:配送中 3:已配送）,
@property (nonatomic,strong) NSString *waybillNo;// 快递单号,
@property (nonatomic,strong) NSString *expressCompany; // 快递公司名称,
@property (nonatomic,strong) NSString *receiveCode; //收获码,
@property (nonatomic,strong) NSString *receiveAddr;//收货人地址,
@property (nonatomic,strong) NSString *payType; //支付方式（1:当面支付 2:网上支付）,
@property (nonatomic,strong) NSString *proAmount ;// 商品总额,
@property (nonatomic,strong) NSString *discountAmount; //优惠多少钱,
@property (nonatomic,strong) NSString *deliverAmount; // 配送费,
@property (nonatomic,strong) NSString *actTitle; // 优惠标题,
@property (nonatomic,strong) NSString *giftName;//赠品名称，暂时未使用
@property (nonatomic,strong) NSString *orderDescUser; // 卖家备注,
@property (nonatomic,strong) NSString *branchLot; // 门店经度,
@property (nonatomic,strong) NSString *branchLat; //门店纬度,
@property (nonatomic,strong) NSString *branchAddr; // 门店地址,
@property (nonatomic,strong) NSString *orderDesc; //订单状态描述,
@property (nonatomic,strong) NSString *appraiseStatus;//订单是否评价
@property (nonatomic,strong) NSString *createStr;//格式化后的下单时间,
@property (nonatomic,strong) NSString *branchPmt;//店铺优惠,
@property (nonatomic,strong) NSString *branchType;//药房类型
@property (nonatomic,strong) NSArray *microMallOrderDetailVOs;//订单商品列表
@property (nonatomic,strong) NSString *refundStatus; //在线支付退款状态（0:无 1:退款中 2:已退款）,
@property (nonatomic,strong) NSArray *orderComboVOs;// 套餐列表,
@property (nonatomic,strong) NSArray *redemptionPro;//换购列表
@property (nonatomic,strong) NSString *paySeconds;
@property (nonatomic,strong) NSString *serviceTel;// 客服电话,
@property (nonatomic,strong) NSString *deliverLast;// 门店最晚发货时间,
@property (nonatomic,strong) NSString *orderPmt;//  订单优惠
@end

@interface UserMicroMallOrderDetailVO : BaseModel
@property (nonatomic,strong) NSString *productCode;// 商品编码,
@property (nonatomic,strong) NSString *imgUrl;// 商品图片地址,
@property (nonatomic,strong) NSString *proName;// 商品名称,
@property (nonatomic,strong) NSString *price;// 商品价格,
@property (nonatomic,strong) NSString *priceDiscount;// 优惠价,
@property (nonatomic,strong) NSString *actType;// 微商优惠活动类型（1:微商优惠商品 2:抢购 3:优惠券）,
@property (nonatomic,strong) NSString *actId;// 优惠活动ID,
@property (nonatomic,strong) NSString *actTitle;// 优惠活动标题,
@property (nonatomic,strong) NSString *proAmount;// 商品件数
@property (nonatomic,strong) NSString *freeBieQty;// 赠品数量,
@property (nonatomic,strong) NSString *freeBieName;// 赠品名称
@property (nonatomic,strong) NSString *spec;//规格
@property (nonatomic,strong) NSString *actDesc;//优惠活动描述
@property (nonatomic,strong) NSString *branchProId;
@end
@interface OrderComboVo : BaseModel
@property (nonatomic,strong)NSString *comboName;    //套餐名字
@property (nonatomic,strong)NSString *comboPrice;   //套餐价格
@property (nonatomic,strong)NSString *comboAmount;  //套餐数量
@property (nonatomic,strong)NSArray *microMallOrderDetailVOs; //套餐商品列表
@end
@interface CancelReasonModel : BaseAPIModel
@property (nonatomic,strong) NSArray *list;
@end

@interface OrderAppriseModel : BaseAPIModel
@property (nonatomic, strong) NSString *taskChanged;
@end





