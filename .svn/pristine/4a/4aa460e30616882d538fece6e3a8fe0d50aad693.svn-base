//
//  Favorite.m
//  APP
//
//  Created by qw on 15/3/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Favorite.h"
#import "Constant.h"
#import "FavoriteModel.h"
#import "QWGlobalManager.h"
@implementation Favorite
//我关注的药店
+ (void)queryStoreCollectListWithParams:(FavoriteModelR *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure
{
    
    [[HttpClient sharedInstance] get:GetStoreCollects params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyarr = [NSMutableArray array];
        [keyarr addObject:NSStringFromClass([MyFavStoreModel class])];
        [keyarr addObject:NSStringFromClass([MyFavStoreTagListModel class])];
        NSMutableArray *valuearr = [NSMutableArray array];
        [valuearr addObject:@"list"];
        [valuearr addObject:@"tags"];
        MyFavListModel *model =   [MyFavListModel parse:responseObj ClassArr:keyarr Elements:valuearr];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


//我收藏的商品
+ (void)queryProductCollectListWithParams:(FavoriteModelR *)param
                                  success:(void(^)(id DFUserModel))success
                                  failure:(void(^)(HttpException * e))failure{
    [[HttpClient sharedInstance] get:GetProductCollects params:[param dictionaryModel] success:^(id responseObj) {
        MyFavListModel *model =   [MyFavListModel parse:responseObj Elements:[MyFavProductListModel class] forAttribute:@"list"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


//我收藏的症状
+ (void)querySpmCollectListWithParams:(FavoriteModelR *)param
                              success:(void(^)(id DFUserModel))success
                              failure:(void(^)(HttpException * e))failure{
    [[HttpClient sharedInstance] get:GetSpmCollects params:[param dictionaryModel] success:^(id responseObj) {
        MyFavListModel *model =   [MyFavListModel parse:responseObj Elements:[MyFavSpmListModel class] forAttribute:@"list"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


//我收藏的疾病
+ (void)queryDiseaseCollectListWithParams:(FavoriteModelR *)param
                                  success:(void(^)(id DFUserModel))success
                                  failure:(void(^)(HttpException * e))failure{
    [[HttpClient sharedInstance] get:GetDiseaseCollects params:[param dictionaryModel] success:^(id responseObj) {
        MyFavListModel *model =   [MyFavListModel parse:responseObj Elements:[MyFavDiseaseListModel class] forAttribute:@"list"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


//我收藏的资讯
+ (void)queryAdviceCollectListWithParams:(FavoriteModelR *)param
                                 success:(void(^)(id DFUserModel))success
                                 failure:(void(^)(HttpException * e))failure{
    [[HttpClient sharedInstance] get:GetAdviceCollects params:[param dictionaryModel] success:^(id responseObj) {
        MyFavListModel *model =   [MyFavListModel parse:responseObj Elements:[MyFavAdviceListModel class] forAttribute:@"list"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


//添加取消收藏---model
+ (void)collectWithParam:(FavoriteCollectR *)param
                 success:(void(^)(id))success
                 failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] postWithoutProgress:Collect
                               params:[param dictionaryModel]
                              success:^(id resultObj) {
               CancleResult *model =   [CancleResult parse:resultObj Elements:[CancleResult class]];
                                  if (success) {
                                      success(model);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}


// 健康咨询检查点赞
+ (void)checkAdviceCollectWithParams:(AdviceFavoriteCollectR *)param
                             success:(void(^)(id DFUserModel))success
                             failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:CheckAdviceFavorite
                              params:[param dictionaryModel]
                             success:^(id resultObj) {
                                 AdviceCollectResult *model =   [AdviceCollectResult parse:resultObj];
                                 if (success) {
                                     success(model);
                                 }
                             }
                             failure:^(HttpException *e) {
                                 DebugLog(@"%@",e);
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}

+ (void)getMyCollectMsgWithParams:(FavRequestModelR *)param
                          success:(void(^)(MyFavMsgLists *model))success
                          failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:InfoGetMyFav
                              params:[param dictionaryModel]
                             success:^(id resultObj) {
                                 MyFavMsgLists *model =   [MyFavMsgLists parse:resultObj Elements:[MyFavMsgListModel class] forAttribute:@"list"];
                                 if (success) {
                                     success(model);
                                 }
                             }
                             failure:^(HttpException *e) {
                                 DebugLog(@"%@",e);
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}

// 我的收藏 删除 V300
+(void)DelMyCollection:(DelCollectionR *)param success:(void(^)(DelCollectionModel *model))success failure:(void(^)(HttpException * e))failure {
    [[HttpClient sharedInstance]post:DeleteUserCollection params:[param dictionaryModel] success:^(id responseObj) {
        DelCollectionModel *modelList = [DelCollectionModel parse:responseObj];
        if (success) {
            success(modelList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }

    }];
}
@end
