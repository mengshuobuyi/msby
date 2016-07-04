//
//  News_QueryChannel.m
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "News.h"
#import "Constant.h"

@implementation News

+ (void)QueryChannelsuccess:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [[HttpClient sharedInstance] post:QueryChannelList
                               params:param
                              success:^(id resultObj) {
                                  
                                  NSArray *modelArray = [NewsChannel parseArray:resultObj[@"data"]];
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

+ (void)QueryHealthAdviceListWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:QueryHealthAdviceList
                               params:param
                              success:^(id resultObj) {
                                  
                                  NewsAdvicelPage *page = [NewsAdvicelPage parse:resultObj Elements:[NewsAdvicel class]];
                                  
                                  if (success) {
                                      success(page);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)queryChannelBannerWithParams:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:QueryChannelBanner
                               params:param
                              success:^(id resultObj) {
                                  
                                  NSArray *modelArray = [NewsChannelBanner parseArray:resultObj[@"data"]];
                                  
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
