//
//  OpeartionStatic.h
//  APP
//
//  Created by qw_imac on 16/6/28.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpeartionStaticR.h"
//用户行为统计
@interface OpeartionStatic : NSObject
+(void)operateRpt:(OpeartionStaticR *)modelR successs:(void(^)())success failure:(void(^)(HttpException *e))failure;

@end
