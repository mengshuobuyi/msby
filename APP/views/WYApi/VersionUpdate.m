//
//  VersionUpdate.m
//  APP
//
//  Created by qw on 15/2/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "VersionUpdate.h"
#import "Constant.h"

@implementation VersionUpdate

//读取服务器上最新版本数据
+ (void)checkVersion:(NSString*)version success:(void (^)(Version *))success failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:NW_checkNewVersion
                               params:@{@"version":version,@"platform":@"IOS",@"app":@"CUSTOMER"}
                              success:^(id resultObj) {

                                  Version * vmodel = [Version parse:resultObj];
                                  DDLogVerbose(@"the model is %@",vmodel.apiMessage);
                                  if ([vmodel.apiStatus intValue] == 0) {
                                      if (success) {
                                          success(vmodel);
                                      }
                                  }
                                  
                              }
                              failure:^(HttpException *e) {
                                    DebugLog(@"%@",e);
                                    if (failure) {
                                        failure(e);
                                    }
                                }];
}


//渠道
+ (void)qwChannel:(ChannerModelR*)modelR success:(void (^)(ChannerModel *))success failure:(void (^)(HttpException *))failure{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:PostChannelMark params:[modelR dictionaryModel]
        success:^(id resultObj) {
            
            if (success) {
                success(resultObj);
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
