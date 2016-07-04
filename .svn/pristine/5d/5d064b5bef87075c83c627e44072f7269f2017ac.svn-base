//
//  Product.m
//  APP
//
//  Created by garfield on 16/5/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "Product.h"

@implementation Product

+(void)queryProFoodTaboos:(ProductOrderModelR *)params success:(void(^)(ProFoodTabooListVoModel *responseModel))success failure:(void(^)(HttpException *e))failure;
{
    [[HttpClient sharedInstance] get:QueryProFoodTaboos params:[params dictionaryModel] success:^(id obj) {
        ProFoodTabooListVoModel *model = [ProFoodTabooListVoModel parse:obj Elements:[ProductTabooVoModel class] forAttribute:@"tips"];
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
