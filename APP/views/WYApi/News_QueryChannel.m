//
//  News_QueryChannel.m
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "News_QueryChannel.h"
#import "Constant.h"

@implementation News_QueryChannel

+ (void)QueryChannelsuccess:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance] post:QueryChannelList
                               params:param
                              success:^(id resultObj) {
                                  
                                  NSArray *modelArray = [News_Channel parseArray:resultObj[@"data"]];
                                  if (success) {
                                      success(modelArray);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}
@end
