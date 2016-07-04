//
//  CouponNotiListRequest.h
//  APP
//
//  Created by PerryChen on 8/17/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouponNotiBaseModel.h"
#import "CouponNotiListModelR.h"
@interface CouponNotiListRequest : NSObject
//p2p  全量拉取优惠券消息
+ (void)getAllCouponNotiList:(CouponNotiListModelR *)param
          success:(void (^)(CouponMessageArrayVo *responModel))succsee
          failure:(void (^)(HttpException *e))failure;

// 增量获取优惠券列表
+ (void)getNewCouponList:(CouponNotiPullListModelR *)param
                  success:(void (^)(CouponMessageArrayVo *responModel))success
                  failure:(void (^)(HttpException *e))failure;

///api/message/coupon/removeByCustomer 客户：删除单条优惠通知
+ (void)removeByCustomer:(RemoveByCustomerCounponR *)param
                 success:(void (^)(id responModel))success
                 failure:(void (^)(HttpException *e))failure;

+ (void)setCouponNotiReadWithMessageId:(NSString *)strMsgId;


+ (void)setCouponNotiRead:(CouponNotiReadR *)param
                  success:(void (^)(id responModel))success
                  failure:(void (^)(HttpException *e))failure;
@end
