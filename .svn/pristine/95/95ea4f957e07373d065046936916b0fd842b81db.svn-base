//
//  QueryOrdersR.h
//  APP
//
//  Created by qw_imac on 16/1/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface QueryOrdersR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,assign) NSInteger status;//订单状态（0:全部， 1:未完成， 2:待评价）
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;
@end

@interface OperateUseOrderR : BaseModel
@property (nonatomic,strong) NSString *cancelReason;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,assign) NSInteger operate; //用户操作， 1:确认收货，2:取消订单，3:删除订单
@end

@interface QueryUserOrderDetailR : BaseModel
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *token;
@end

@interface QueryCancelReasonR : BaseModel
@property (nonatomic,assign) NSInteger type;
@end

@interface OrderEvaluateModelR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,assign) NSInteger serviceStar;
@property (nonatomic,assign) NSInteger deliveryStar;
@property (nonatomic,strong) NSString *remark;
@end