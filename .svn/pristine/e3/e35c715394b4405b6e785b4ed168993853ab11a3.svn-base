//
//  Subject.m
//  APP
//
//  Created by garfield on 15/8/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Subject.h"

@implementation Subject

+ (void)saveComment:(SaveCommentModelR *)param
            success:(void (^)(BaseAPIModel *model))success
            failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:SubjectSaveComment params:[param dictionaryModel] success:^(id obj) {
        BaseAPIModel *model = [BaseAPIModel parse:obj];
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

+ (void)saveInfoDetailComment:(SaveCommentModelR *)param
            success:(void (^)(BaseAPIModel *model))success
            failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:InfoDetailSaveComment params:[param dictionaryModel] success:^(id obj) {
        BaseAPIModel *model = [BaseAPIModel parse:obj];
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
