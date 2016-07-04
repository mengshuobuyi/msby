//
//  PromotionOrder.h
//  APP
//
//  Created by 李坚 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"
#import "HttpClient.h"
#import "PromotionOrderModel.h"
#import "PromotionOrderModelR.h"

@interface PromotionOrder : BaseModel

/**
 *  3.15.12	[用户端] 查询优惠订单列表
 */
+ (void)promotionOrderWithParams:(PromotionOrderModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;

@end
