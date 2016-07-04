//
//  MallCart.h
//  APP
//
//  Created by garfield on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallCartModelR.h"
#import "MallCartModel.h"

@interface MallCart : NSObject


//微商-购物车列表
+(void)queryMMallCart:(MallCartModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

//点击结算按钮事件
+(void)queryMMallCartCheck:(MMallCartCheckModelR *)params success:(void(^)(BaseAPIModel *responseModel))success failure:(void(^)(HttpException *e))failure;

//购物数据变更同步接口
+(void)queryMallCartSync:(MMallCartSyncModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

// 3.1.0 版本 new check接口,点击结算按钮事件
+(void)queryMallCartNewCheck:(MMallCartCheckModelR *)params success:(void(^)(BaseAPIModel *responseModel))success failure:(void(^)(HttpException *e))failure;

// 3.1.0 版本 new sync接口,购物数据变更同步接口
+ (void)queryMallCartNewSync:(MMallCartSyncModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

// 3.1.0 版本 new preview接口,订单提交预览
+(void)queryMallCartNewPreView:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartPreviewVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

// 3.1.0 版本 new submit接口,订单提交
+(void)queryMallCartNewSubmit:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartCompleteVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

// 3.1.0 版本,查询门店下换购活动列表
+(void)queryBranchsByMultiBranch:(MMallRedemptionModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;



//订单提交预览
+(void)queryMallCartPreView:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartPreviewVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

+(void)queryMallCartSubmit:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartCompleteVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

+(void)queryMmallAdvice:(MmallAdviceModelR *)params success:(void(^)(BaseAPIModel *responseModel))success failure:(void(^)(HttpException *e))failure;

//支付-获取订单当前信息,提交成功界面
+(void)getOrderResult:(GetOrderResultModelR *)params success:(void(^)(MicroMallCartCompleteVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;

@end
