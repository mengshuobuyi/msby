//
//  OrderBase.m
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "OrderBase.h"

@implementation OrderBase

+ (void)orderBaseComment:(OrderBaseCommentModelR *)param
                 success:(void (^)(OrderBaseCommentModel *responModel))success
                 failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] post:OrderBaseComment params:[param dictionaryModel] success:^(id responseObj) {
        OrderBaseCommentModel *model = [OrderBaseCommentModel parse:responseObj];
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
