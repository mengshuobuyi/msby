//
//  PromotionOrderModel.h
//  APP
//
//  Created by 李坚 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface PromotionOrderListModel : BaseAPIModel

@property (nonatomic) NSArray *list;
@property (nonatomic) NSString *page;
@property (nonatomic) NSString *pageSize;
@property (nonatomic) NSString *pageSum;
@property (nonatomic) NSString *totalRecords;
@property (nonatomic) NSString *msg;

@end

@interface PromotionOrderModel : BaseAPIModel

@property (nonatomic) NSString *id;         //订单id
@property (nonatomic) NSString *title;      //优惠标题
@property (nonatomic) NSString *desc;       //优惠描述
@property (nonatomic) NSString *banner;     //活动banner图片地址
@property (nonatomic) NSString *type;       //优惠券类型（1:折扣券,2:代金券,3:买赠券）
@property (nonatomic) NSString *remark;     //类型描述
@property (nonatomic) NSString *receipt;        //小票url
@property (nonatomic) NSString *date;       //订单日期（已格式化）
@property (nonatomic) NSString *proName;        //商品名称
@property (nonatomic) NSString *branch;     //药店名称
@property (nonatomic) NSString *price;      //单价
@property (nonatomic) NSString *quantity;       //数量
@property (nonatomic) NSString *empty;      //是否上传小票，1是0否
@property (nonatomic) NSString *nick;       //用户昵称
@property (nonatomic) NSString *count;      //该门店接收订单总数
@property (nonatomic) NSString *emptyCount; //该门店接收未上传小票订单总数
@property (nonatomic) NSString *useTimes;   //订单优惠次数
@property (nonatomic) NSString *discount;   //优惠值
@property (nonatomic) NSString *inviter;    //推荐人手机号
@property (nonatomic) NSString *pay;        //实付
@property (nonatomic) NSString *totalLargess;//赠送总数

@end
