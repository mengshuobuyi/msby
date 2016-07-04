//
//  ConfigInfo.h
//  APP
//
//  Created by garfield on 15/8/21.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfoModelR.h"
#import "ConfigInfoModel.h"

@interface ConfigInfo : NSObject

// 增量获取系统消息列表
+ (void)configInfoQueryBanner:(ConfigInfoQueryModelR *)param
                      success:(void (^)(BannerInfoListModel *responModel))success
                      failure:(void (^)(HttpException *e))failure;


+ (void)configInfoQuery:(ConfigInfoQueryModelR *)param
                success:(void (^)(id responModel))success
                failure:(void (^)(HttpException *e))failure;
+ (void)configInfoQueryHomePageBanner:(ConfigInfoQueryModelR *)param
                              success:(void (^)(BannerInfoListModel *responModel))success
                              failure:(void (^)(HttpException *e))failure;
//3.0.0 微商营销点
+ (void)configInfoQueryOpTemplates:(ConfigInfoQueryModelR *)param
                           success:(void (^)(TemplateListVoModel *responModel))success
                           failure:(void (^)(HttpException *e))failure;

+ (void)configInfoQueryForumArea:(BaseAPIModel *)param
                         success:(void (^)(ForumAreaInfoListModel *responModel))success
                         failure:(void (^)(HttpException *e))failure;
//2.2.3 新接口,首页运营点数据
+ (void)queryConfigInfos:(ConfigInfoQueryModelR *)param
                 success:(void (^)(ConfigInfoListVoModel *responModel))success
                failure:(void (^)(HttpException *e))failure;

//2.2.3 专题专区模板
+ (void)queryTemplete:(ConfigInfoQueryTemplateModelR *)param
              success:(void (^)(TemplateListVoModel *responModel))success
              failure:(void (^)(HttpException *e))failure;



@end
