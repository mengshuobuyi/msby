//
//  PayInfo.m
//  APP
//
//  Created by garfield on 16/3/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PayInfo.h"

@implementation PayInfo

//支付-获取支付结果,以服务器为准
+(void)getAliPayResult:(PayInfoModelR *)params success:(void(^)(PayInfoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:GetAliPayResult params:[params dictionaryModel] success:^(id obj) {
        PayInfoModel *model = [PayInfoModel parse:obj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//支付-获取微信支付结果,以服务器为准
+(void)getWXPayResult:(PayInfoModelR *)params success:(void(^)(PayInfoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:GetWXPayResult params:[params dictionaryModel] success:^(id obj) {
        PayInfoModel *model = [PayInfoModel parse:obj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

@end
