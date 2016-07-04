//
//  ConfigInfo.m
//  APP
//
//  Created by garfield on 15/8/21.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ConfigInfo.h"
#import "SBJson.h"
@implementation ConfigInfo


+ (void)configInfoQueryBanner:(ConfigInfoQueryModelR *)param
                      success:(void (^)(BannerInfoListModel *responModel))success
                      failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:ConfigInfoQueryBanner params:[param dictionaryModel] success:^(id responseObj) {
        HttpClientMgr.progressEnabled = NO;
        BannerInfoListModel *listModel = [BannerInfoListModel parse:responseObj Elements:[BannerInfoModel class] forAttribute:@"list"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)configInfoQueryHomePageBanner:(ConfigInfoQueryModelR *)param
                              success:(void (^)(BannerInfoListModel *responModel))success
                              failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:ConfigInfoQueryHomePageBanner params:[param dictionaryModel] success:^(id responseObj) {
        HttpClientMgr.progressEnabled = NO;
        BannerInfoListModel *listModel = [BannerInfoListModel parse:responseObj Elements:[BannerInfoModel class] forAttribute:@"list"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


//运营点接口
//启动页
//下拉刷新图片
//icon
//通告栏
//优惠封面图片ICON
//通告的状态有1，2；启动页状态有1,9；封面图片专题有7，8
+ (void)configInfoQuery:(ConfigInfoQueryModelR *)param
                success:(void (^)(id responModel))success
                failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:ConfigInfoQuery params:[param dictionaryModel] success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//3.0.0 微商营销点
+ (void)configInfoQueryOpTemplates:(ConfigInfoQueryModelR *)param
                           success:(void (^)(TemplateListVoModel *responModel))success
                           failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:ConfigInfoQueryOpTemplates params:[param dictionaryModel] success:^(id responseObj) {
        TemplateListVoModel *listModel = [TemplateListVoModel parse:responseObj Elements:[TemplateVoModel class] forAttribute:@"templates"];
        
        for(TemplateVoModel *model in listModel.templates)
        {
            model.pos = [TemplatePosVoModel parseArray:model.pos];
        }
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)configInfoQueryForumArea:(BaseAPIModel *)param
                         success:(void (^)(ForumAreaInfoListModel *responModel))success
                         failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:ConfigInfoQueryForumArea params:[param dictionaryModel] success:^(id responseObj) {
        ForumAreaInfoListModel *listModel = [ForumAreaInfoListModel parse:responseObj Elements:[ForumAreaInfoModel class] forAttribute:@"list"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//2.2.3 新接口,首页运营点数据
+ (void)queryConfigInfos:(ConfigInfoQueryModelR *)param
                 success:(void (^)(ConfigInfoListVoModel *responModel))success
                 failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryConfigInfos params:[param dictionaryModel] success:^(id responseObj) {
        ConfigInfoListVoModel *listModel = [ConfigInfoListVoModel parse:responseObj Elements:[ConfigInfoVoModel class] forAttribute:@"configInfos"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//2.2.3 专题专区模板
+ (void)queryTemplete:(ConfigInfoQueryTemplateModelR *)param
              success:(void (^)(TemplateListVoModel *responModel))success
              failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryTemplete params:[param dictionaryModel] success:^(id responseObj) {
        TemplateListVoModel *listModel = [TemplateListVoModel parse:responseObj Elements:[TemplateVoModel class] forAttribute:@"templates"];
        
        for(TemplateVoModel *model in listModel.templates)
        {
            model.pos = [TemplatePosVoModel parseArray:model.pos];
        }
        
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];

}


@end
