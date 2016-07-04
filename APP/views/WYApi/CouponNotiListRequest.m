//
//  CouponNotiListRequest.m
//  APP
//
//  Created by PerryChen on 8/17/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "CouponNotiListRequest.h"

@implementation CouponNotiListRequest
+ (void)getAllCouponNotiList:(CouponNotiListModelR *)param
                     success:(void (^)(CouponMessageArrayVo *responModel))succsee
                     failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MsgBoxListCouponNotiList params:[param dictionaryModel] success:^(id responseObj) {
        CouponMessageArrayVo *listModel = [CouponMessageArrayVo parse:responseObj Elements:[CouponMessageVo class] forAttribute:@"messages"];
        if (succsee) {
            succsee(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)getNewCouponList:(CouponNotiPullListModelR *)param
                 success:(void (^)(CouponMessageArrayVo *responModel))success
                 failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MsgBoxListPullCouponNotiList params:[param dictionaryModel] success:^(id responseObj) {
        CouponMessageArrayVo *listModel = [CouponMessageArrayVo parse:responseObj Elements:[CouponMessageVo class] forAttribute:@"messages"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)removeByCustomer:(RemoveByCustomerCounponR *)param
                 success:(void (^)(id responModel))success
                 failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] put:RemoveByCustomer_coupon params:[param dictionaryModel] success:^(id responseObj) {
 
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)setCouponNotiReadWithMessageId:(NSString *)strMsgId
{
    CouponNotiReadR *modelR = [CouponNotiReadR new];
    modelR.messageId = strMsgId;
    [CouponNotiListRequest setCouponNotiRead:modelR success:^(id responModel) {
        
    } failure:^(HttpException *e) {
        
    }];
}

+ (void)setCouponNotiRead:(CouponNotiReadR *)param
                  success:(void (^)(id responModel))success
                  failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:CouponNotiMsgRead params:[param dictionaryModel] success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
