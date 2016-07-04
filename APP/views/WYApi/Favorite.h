//
//  Favorite.h
//  APP
//
//  Created by qw on 15/3/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "FavoriteModelR.h"
#import "FavoriteModel.h"
@interface Favorite : NSObject

//我关注的药房
+ (void)queryStoreCollectListWithParams:(FavoriteModelR *)param
                                success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;

//添加取消收藏
+ (void)collectWithParam:(FavoriteCollectR *)param
                  success:(void(^)(id))success
                  failure:(void(^)(HttpException * e))failure;

//我收藏的商品
+ (void)queryProductCollectListWithParams:(FavoriteModelR *)param
                                success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;


//我收藏的症状
+ (void)querySpmCollectListWithParams:(FavoriteModelR *)param
                                success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;


//我收藏的疾病
+ (void)queryDiseaseCollectListWithParams:(FavoriteModelR *)param
                                success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;


//我收藏的资讯 (弃用)
+ (void)queryAdviceCollectListWithParams:(FavoriteModelR *)param
                                success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;


+ (void)checkAdviceCollectWithParams:(AdviceFavoriteCollectR *)param
                             success:(void(^)(id DFUserModel))success
                             failure:(void(^)(HttpException * e))failure;

// 我收藏的资讯列表 V300
+ (void)getMyCollectMsgWithParams:(FavRequestModelR *)param
                          success:(void(^)(MyFavMsgLists *model))success
                          failure:(void(^)(HttpException * e))failure;

// 我的收藏 删除 V300
+(void)DelMyCollection:(DelCollectionR *)param success:(void(^)(DelCollectionModel *model))success failure:(void(^)(HttpException * e))failure;
@end
