//
//  NewsDataManager.m
//  APP
//
//  Created by qw on 15/3/2.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "NewsDataManager.h"
#import "NewsChannel.h"
#import "News.h"


@implementation NewsDataManager

+ (void)getChannelList:(void (^)(id))success failure:(void (^)(id))failure;
{
    //先从缓存读取数据
    __block NSArray* arrChannel = [NewsChannel getArrayFromDBWithWhere:nil];
    
    //从服务器读取数据
    if([arrChannel count] == 0 || arrChannel == nil)//没有数据 向网络进行请求
    {
        [News QueryChannelsuccess:^(id obj){
                                if ([obj isKindOfClass:[NSArray class]]) {
                                    arrChannel = (NSArray*)obj;
                                    //保存数据到数据库
                                    [NewsChannel saveObjToDBWithArray:arrChannel];
                                    if(success)
                                    {
                                        success(arrChannel);
                                    }
                                }
                            }
                            failure:^(HttpException *e){
                                NSLog(@"fail");
                                if(failure)
                                {
                                    failure(e);
                                }
                            }];
    }
    else
    {
        if(success)
        {
            success(arrChannel);
        }
    }
}

+ (void)getAdvicelListWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(id))failure;
{
    NSString * key = [NSString stringWithFormat:@"%@_%@",params[@"channelId"],params[@"currPage"]];
    
    NewsAdvicelPage* page = [NewsAdvicelPage getObjFromDBWithKey:key];
    
    if (page) {
        if(success)
        {
            success(page);
        }
    }
    else
    {
        [News QueryHealthAdviceListWithParams:params
                                      success:^(id obj){
                                         
                                         if (obj) {
                                             NewsAdvicelPage* page = obj;
                                             page.advicePageId = key;
                                             [NewsAdvicelPage saveObjToDB:page];
                                             if(success)
                                             {
                                                 success(page);
                                             }
                                         }
                                     }
                                     failure:^(HttpException *e){
                                         NSLog(@"fail");
                                         if(failure)
                                         {
                                             failure(e);
                                         }
                                     }];
    }
}

+ (void)getChannelBannerWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(id))failure
{
    NSString * where = [NSString stringWithFormat:@"channelId = '%@'",params[@"channelId"]];
    NSArray *modelArray = [NewsChannelBanner getArrayFromDBWithWhere:where];
    
    if (modelArray && [modelArray count]>0) {
        if(success)
        {
            success(modelArray);
        }
    }
    else
    {
        [News queryChannelBannerWithParams:params
                                  success:^(id obj){
                                      NSArray *modelArray = obj;
                                      if (modelArray) {
                                          
                                          for (NewsChannelBanner *banner in modelArray)
                                          {
                                              banner.channelId = params[@"channelId"];
                                          }
                                          
                                          [NewsChannelBanner saveObjToDBWithArray:modelArray];
                                          if(success)
                                          {
                                              success(modelArray);
                                          }
                                      }
                                  }
                                  failure:^(HttpException *e){
                                      NSLog(@"fail");
                                      if(failure)
                                      {
                                          failure(e);
                                      }
                                  }];
    }
}

@end
