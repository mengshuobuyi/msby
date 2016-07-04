//
//  Address.m
//  APP
//
//  Created by qw_imac on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "Address.h"

@implementation Address
//收货地址
+ (void)receiveAddress:(ReceiveAddressR *)model success:(void (^)(ReceiveAddress *))success failure:(void (^)(HttpException *))failure {
    [[HttpClient sharedInstance] get:QueryAddresses params:[model dictionaryModel] success:^(id responseObj) {
        ReceiveAddress *listModel = [ReceiveAddress parse:responseObj Elements:[AddressVo class] forAttribute:@"address"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


//修改或新增地址
+ (void)updateAddress:(UpdateAddressR *)model success:(void (^)(AddressVo *respons))success failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance] post:UpdateAddresses params:[model dictionaryModel] success:^(id responseObj) {
        AddressVo *listModel = [AddressVo parse:responseObj];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//删除地址
+ (void)deleteAddress:(DeleteAddressR *)model success:(void (^)(DeleteAddress *respons))success failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance]post:RemoveAddress params:[model dictionaryModel] success:^(id responseObj) {
        DeleteAddress *listModel = [DeleteAddress parse:responseObj];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
