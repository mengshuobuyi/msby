//
//  Orders.h
//  APP
//
//  Created by qw_imac on 16/1/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryOrdersR.h"
#import "OrdersModel.h" 
//3.0订单相关
@interface Orders : NSObject
/********
 * 请求订单列表
 ********/

+(void)queryOrders:(QueryOrdersR *)params success:(void(^)(OrderList *responseModel))success failure:(void(^)(HttpException *e))failure;
/********
 * 操作订单
 ********/

+(void)operateUserOrder:(OperateUseOrderR *)params success:(void(^)(OperateUseOrderModel *model))success failure:(void(^)(HttpException *e))failure;

/********
 * 订单详情
 ********/
+(void)queryOrderDetail:(QueryUserOrderDetailR *)params success:(void(^)(UserOrderDetialVO *model))success failure:(void(^)(HttpException *e))failure;
/********
 * 订单取消理由
 ********/
+(void)queryCancelReason:(QueryCancelReasonR *)params success:(void(^)(CancelReasonModel *model))success failure:(void(^)(HttpException *e))failure;

/********
 * 订单评价接口
 ********/
+(void)evaluateOrder:(OrderEvaluateModelR *)params  success:(void(^)(OrderAppriseModel *model))success failure:(void(^)(HttpException *e))failure;
@end
