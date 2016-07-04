//
//  ImInfo.h
//  APP
//  和聊天相关的网络交互接口
//  Created by qw on 15/2/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"

@interface ImInfo : NSObject

//未读数据列表
+ (void)alternativeIMSelect:(NSDictionary *)condition
                    success:(void (^)(id resultObj))success
                    failure:(void (^)(HttpException *))failure;

//心跳数据
+ (void)heartBeat:(NSDictionary *)condition
          success:(void (^)(id resultObj))success
          failure:(void (^)(HttpException *))failure;

//接收的数据
+ (void)imSetReceived:(NSDictionary *)condition
              success:(void (^)(id resultObj))success
              failure:(void (^)(HttpException *))failure;
@end
