//
//  Credit.h
//  APP
//
//  Created by Martin.Liu on 15/12/4.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditModelR.h"
#import "CreditModel.h"
@interface Credit : NSObject
// 个人积分详情
+ (void)getCreditDetail:(CreditModelR *)param
               success:(void (^)(CreditModel *responModel))success
               failure:(void (^)(HttpException *e))failure;

// 个人积分明细（积分的历史记录）
+ (void)getCreditRecords:(CreditRecordsR *)param
                 success:(void (^)(CreditRecordsModel *recordsmodel))success
                 failure:(void (^)(HttpException *e))failure;
// 签到
+ (void)sign:(SignR *)param
     success:(void(^)(SignModel *responModel))success
     failure:(void(^)(HttpException *e))failure;


//会员等级
+(void)getMyLevelDetailVo:(MyLevelR *)param
                  success:(void(^)(MyLevelDetailVo *responModel))success
                  failure:(void (^)(HttpException *e))failure;

// 获取积分奖励规则
+ (void)queryTaskRulesSuccess:(void (^)(CreditTaskRulesModel *creditTaskRules))success
                      failure:(void (^)(HttpException *e))failure;

// 每月等级奖励
+ (void)doUpgradeTaskWithToken:(DoUpgradeTaskR *)token
                       success:(void (^)(BaseTaskVo *responModel))success
                       failure:(void (^)(HttpException *e))failure;

@end
