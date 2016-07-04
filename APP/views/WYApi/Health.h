//
//  Health.h
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "HealthModel.h"

@interface Health : NSObject


//健康项查询
+ (void)queryHealthProgramWithParams:(NSMutableDictionary *)param
success:(void (^)(id))success
                             failure:(void (^)(HttpException *))failure;


@end
