//
//  PayInfo.h
//  APP
//
//  Created by garfield on 16/3/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayInfoModelR.h"
#import "PayInfoModel.h"

@interface PayInfo : NSObject


//支付-获取支付结果,以服务器为准
+(void)getAliPayResult:(PayInfoModelR *)params success:(void(^)(PayInfoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

//支付-获取微信支付结果,以服务器为准
+(void)getWXPayResult:(PayInfoModelR *)params success:(void(^)(PayInfoModel *responseModel))success failure:(void(^)(HttpException *e))failure;




@end
