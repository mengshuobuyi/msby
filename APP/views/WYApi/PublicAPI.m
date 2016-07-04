//
//  PublicAPI.m
//  APP
//
//  Created by Meng on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "PublicAPI.h"
#import "PublicModel.h"
@implementation PublicAPI

/**
 *  @brief 3.8.2	获取省市区的编码
 */
//+ (void)getAreaCodeWithParam:(id)param
//                     success:(void (^)(id DFModel))success
//                     failure:(void(^)(HttpException *e))failure
//{
//    [[HttpClient sharedInstance] get:Store_getAreaCode params:[param dictionaryModel] success:^(id responseObj) {
//        PharmacyGetAreaCodeModel *model = [PharmacyGetAreaCodeModel parse:responseObj];
//        
//        if (success) {
//            success(model);
//        }
//    } failure:^(HttpException *e) {
//        if (failure) {
//            failure(e);
//        }
//    }];
//}


@end
