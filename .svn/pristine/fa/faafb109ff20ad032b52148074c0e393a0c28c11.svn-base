//
//  Credit.m
//  APP
//
//  Created by Martin.Liu on 15/12/4.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "Credit.h"
#import "HttpClient.h"

@implementation Credit

+ (void)getCreditDetail:(CreditModelR *)param
                success:(void (^)(CreditModel *responModel))success
                failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:GetCreditDetail params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([CreditTaskModel class])];
        [keyArr addObject:NSStringFromClass([CreditTaskModel class])];
        [keyArr addObject:NSStringFromClass([CreditTaskModel class])];
        [keyArr addObject:NSStringFromClass([CreditTaskModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
//        [valueArr addObject:@"taskListVO"];
        [valueArr addObject:@"onceTasks"];
        [valueArr addObject:@"dailyTasks"];
        [valueArr addObject:@"monthlyTasks"];
        [valueArr addObject:@"teamTasks"];
        
        CreditModel *model = [CreditModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        
        if (success) {
            success(model);
        };
    } failure:^(HttpException *e) {
        ;
    }];
}

+ (void)getCreditRecords:(CreditRecordsR *)param
                 success:(void (^)(CreditRecordsModel *recordsmodel))success
                 failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:GetCreditRecords params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([CreditRecordModel class])];

        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"list"];
        
        CreditRecordsModel *recordsmodel = [CreditRecordsModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        
        if (success) {
            success(recordsmodel);
        }
    } failure:^(HttpException *e) {
        ;
    }];
}

+ (void)queryTaskRulesSuccess:(void (^)(CreditTaskRulesModel *responModel))success
                      failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] getWithoutProgress:QueryTaskRules params:nil success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([CreditTaskModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"ruels"];

        CreditTaskRulesModel* taskRuels = [CreditTaskRulesModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(taskRuels);
        }
    } failure:^(HttpException *e) {
        DDLogError(@"get task rules error : %@", e);
    }];
}

+ (void)doUpgradeTaskWithToken:(DoUpgradeTaskR *)token
                       success:(void (^)(BaseTaskVo *responModel))success
                       failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] post:DoUpgradeTask params:[token dictionaryModel] success:^(id responseObj) {
        BaseTaskVo *responseModel = [BaseTaskVo parse:responseObj];
        if (success) {
            success(responseModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)sign:(SignR *)param
     success:(void(^)(SignModel *responModel))success
     failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance] post:Sign params:[param dictionaryModel] success:^(id responseObj) {
        SignModel *responseModel = [SignModel parse:responseObj];
        if (success) {
            success(responseModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+(void)getMyLevelDetailVo:(MyLevelR *)param
                  success:(void(^)(MyLevelDetailVo *responModel))success
                  failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance] get:MemBerLevel params:[param dictionaryModel] success:^(id responseObj) {
        MyLevelDetailVo *responseModel = [MyLevelDetailVo parse:responseObj];
        if (success) {
            success(responseModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
