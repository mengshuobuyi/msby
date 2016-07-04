//
//  Orders.m
//  APP
//
//  Created by qw_imac on 16/1/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "Orders.h"

@implementation Orders
/********
 * 请求订单列表
 ********/

+(void)queryOrders:(QueryOrdersR *)params success:(void(^)(OrderList *responseModel))success failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance]get:QueryOrdersList params:[params dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([MicroMallOrderVO class])];
        [keyArr addObject:NSStringFromClass([MicroMallOrderDetailVO class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"list"];
        [valueArr addObject:@"microMallOrderDetailVOs"];
        OrderList *listModel = [OrderList parse:responseObj ClassArr:keyArr Elements:valueArr];
        
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+(void)operateUserOrder:(OperateUseOrderR *)params success:(void(^)(OperateUseOrderModel *model))success failure:(void(^)(HttpException *e))failure {
    HttpClientMgr.progressEnabled = YES;
    [[HttpClient sharedInstance] post:OperateOrders params:[params dictionaryModel] success:^(id responseObj) {
        OperateUseOrderModel *listModel = [OperateUseOrderModel parse:responseObj];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];

}

/********
 * 订单详情
 ********/
+(void)queryOrderDetail:(QueryUserOrderDetailR *)params success:(void(^)(UserOrderDetialVO *model))success failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance]get:QueryUserOrderDetailInfo params:[params dictionaryModel] success:^(id responseObj) {
//        UserOrderDetialVO *modelList = [UserOrderDetialVO parse:responseObj Elements:[UserMicroMallOrderDetailVO class] forAttribute:@"microMallOrderDetailVOs"];
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([UserMicroMallOrderDetailVO class])];
        [keyArr addObject:NSStringFromClass([OrderComboVo class])];
        [keyArr addObject:NSStringFromClass([UserMicroMallOrderDetailVO class])];
        [keyArr addObject:NSStringFromClass([UserMicroMallOrderDetailVO class])];
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"microMallOrderDetailVOs"];
        [valueArr addObject:@"orderComboVOs"];
        [valueArr addObject:@"redemptionPro"];
        [valueArr addObject:@"microMallOrderDetailVOs"];
        UserOrderDetialVO *modelList = [UserOrderDetialVO parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(modelList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/********
 * 订单取消理由
 ********/
+(void)queryCancelReason:(QueryCancelReasonR *)params success:(void(^)(CancelReasonModel *model))success failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance]get:QueryUserCancelReasonInfo params:[params dictionaryModel] success:^(id responseObj) {
        CancelReasonModel *modelList = [CancelReasonModel parse:responseObj];
        if (success) {
            success(modelList);
        }

    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/********
 * 订单评价接口
 ********/
+(void)evaluateOrder:(OrderEvaluateModelR *)params  success:(void(^)(OrderAppriseModel *model))success failure:(void(^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] post:UserOrderEvaluate params:[params dictionaryModel] success:^(id responseObj) {
        OrderAppriseModel *modelList = [OrderAppriseModel parse:responseObj];
        if (success) {
            success(modelList);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
