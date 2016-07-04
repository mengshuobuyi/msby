//
//  News_QueryChannel.h
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "NewsChannel.h"

@interface News : NSObject

+ (void)QueryChannelsuccess:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+ (void)QueryHealthAdviceListWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+ (void)queryChannelBannerWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

@end
