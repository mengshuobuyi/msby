//
//  Address.h
//  APP
//
//  Created by qw_imac on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiveAddressR.h"
#import "ReceiveAddress.h"
#import "QWapi.h"
@interface Address : NSObject

//收货地址
+ (void)receiveAddress:(ReceiveAddressR *)model success:(void (^)(ReceiveAddress *))success failure:(void (^)(HttpException *))failure;


//修改或新增地址
+ (void)updateAddress:(UpdateAddressR *)model success:(void (^)(AddressVo *respons))success failure:(void (^)(HttpException *e))failure;


//删除地址
+ (void)deleteAddress:(DeleteAddressR *)model success:(void (^)(DeleteAddress *respons))success failure:(void (^)(HttpException *e))failure;
@end
