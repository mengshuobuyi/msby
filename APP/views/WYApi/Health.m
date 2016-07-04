//
//  Health.m
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Health.h"

@implementation Health

#pragma 健康项查询
+ (void)queryHealthProgramWithParams:param success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
    [HttpClientMgr get:GetHealthPrograms params:param success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([HealthProgramModel class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        HealthModel *scenarionList = [HealthModel parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        
        if (success) {
            success(scenarionList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

@end
