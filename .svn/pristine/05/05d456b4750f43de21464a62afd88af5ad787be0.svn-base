//
//  OpeartionStatic.m
//  APP
//
//  Created by qw_imac on 16/6/28.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "OpeartionStatic.h"

@implementation OpeartionStatic
+(void)operateRpt:(OpeartionStaticR *)modelR successs:(void(^)())success failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance] post:OperateChannelMark params:[modelR dictionaryModel] success:^(id responseObj) {
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
