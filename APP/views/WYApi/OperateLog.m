//
//  OperateLog.m
//  APP
//
//  Created by PerryChen on 10/13/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "OperateLog.h"

@implementation OperateLog
+ (void)saveOperateLog:(OperateModelR *)param
                 success:(void (^)(BaseModel *responModel))success
                 failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled= NO;
    [[HttpClient sharedInstance] post:OperateSaveLog params:[param dictionaryModel] success:^(id responseObj) {
        BaseModel *model = [BaseModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
