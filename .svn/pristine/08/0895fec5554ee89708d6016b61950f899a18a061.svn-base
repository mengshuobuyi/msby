//
//  Activity.m
//  APP
//
//  Created by Meng on 15/3/19.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Activity.h"


@implementation Activity

+ (void)getActivityFromBanner:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:GetActivityInfoFromBanner params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([ActivityImgsModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"imgs"];
        
        ActivityDataModel *bodyModel = [ActivityDataModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (succsee) {
            succsee(bodyModel);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+(void)grabBusinessActivityList:(GrabActivityHomePageModelR *)param
                        success:(void (^)(GrabActivityVoModel *responModel))success
                        failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] getWithoutProgress:H5ACTRUSH params:[param dictionaryModel] success:^(id responseObj) {
        
        GrabActivityVoModel *listModel = [GrabActivityVoModel parse:responseObj Elements:[GrabPromotionProductVoModel class] forAttribute:@"promotionProducts"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

// 首页抢购数据
+(void)grabHomePageActivityList:(GrabActivityHomePageModelR *)param
                        success:(void (^)(GrabActivityVoModel *responModel))success
                        failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] getWithoutProgress:GrabHomePageActivity params:[param dictionaryModel] success:^(id responseObj) {

        GrabActivityVoModel *listModel = [GrabActivityVoModel parse:responseObj Elements:[GrabPromotionProductVoModel class] forAttribute:@"promotionProducts"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//首页频道活动
+(void)channelHomeActivity:(ChannelHomeModelR *)param
                   success:(void (^)(ChannelActivityArrayVoModel *responModel))success
                   failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] getWithoutProgress:ChannelHomeActivity params:[param dictionaryModel] success:^(id responseObj) {
        
        ChannelActivityArrayVoModel *listModel = [ChannelActivityArrayVoModel parse:responseObj Elements:[ChannelActivityVOModel class] forAttribute:@"channelList"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)getActivityWithParam:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:GetActivityInfo params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([ActivityImgsModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"imgs"];
        
        ActivityDataModel *bodyModel = [ActivityDataModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (succsee) {
            succsee(bodyModel);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)getBannerActivityWithParam:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:GetActivityFromBanner params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([ActivityImgsModel class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"imgs"];
        
        ActivityDataModel *bodyModel = [ActivityDataModel parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (succsee) {
            succsee(bodyModel);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


/**
 *  获取指定药店的优惠活动
 */
+ (void)getStoreBranchPromotion:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] getWithoutProgress:StoreBranchPromotion params:[param dictionaryModel] success:^(id responseObj) {
        /*
         NSMutableArray *keyArr = [NSMutableArray array];
         [keyArr addObject:NSStringFromClass([StoreNearByModel class])];
         [keyArr addObject:NSStringFromClass([StoreNearByTagModel class])];
         NSMutableArray *valueArr = [NSMutableArray array];
         [valueArr addObject:@"list"];
         [valueArr addObject:@"tags"];
         StoreNearByListModel *listModel = [StoreNearByListModel parse:responseObj ClassArr:keyArr Elements:valueArr];
         */
        BranchPromotionListModel *listModel = [BranchPromotionListModel parse:responseObj Elements:[BranchPromotionModel class] forAttribute:@"list"];
        if (succsee) {
            succsee(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/**
 *  获取抢购商品信息
 **/
+(void)getGrabPromotionProduct:(GrabActivityModelR *)param
                       success:(void (^)(GrabProductListVo *responModel))success
                       failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance] get:GrabPromotionProduct params:[param dictionaryModel] success:^(id responseObj) {
        GrabProductListVo *listModel = [GrabProductListVo parse:responseObj Elements:[GrabPromotionProductVo class] forAttribute:@"productList"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
/**
 *  抢购商品动作
 **/

+(void)postPurchaseProduct:(ChannelHomeModelR *)param
                   success:(void (^)(PurchaseGrabProduct *responModel))success
                   failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance]post:GrabAction params:[param dictionaryModel] success:^(id responseObj) {
        PurchaseGrabProduct *listModel = [PurchaseGrabProduct parse:responseObj];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
/**
 *  频道活动商品
 **/
+(void)getChannelProductList:(ChannelProductListR *)param
                     success:(void (^)(ChannelProductArrayVo *responModel))success
                     failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance] get:ChannelProductList params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([ChannelProductVo class])];
        [keyArr addObject:NSStringFromClass([ActivityCategoryVo class])];
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"productList"];
        [valueArr addObject:@"promotionList"];
        ChannelProductArrayVo *listModel = [ChannelProductArrayVo parse:responseObj ClassArr:keyArr Elements:valueArr];
        
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



/**
 *  活动维度的商品详情
 **/
+(void)getActivityPurchList:(ActivityPurchListR *)param
                     success:(void (^)(ChannelProductVo *responModel))success
                     failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance] get:activityPurch params:[param dictionaryModel] success:^(id responseObj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([ActivityCategoryVo class])];
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"promotionList"];
        ChannelProductVo *listModel = [ChannelProductVo parse:responseObj ClassArr:keyArr Elements:valueArr];
        
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



//+ (void)getActivityFromBanner:(id)param success:(void (^)(id))succsee failure:(void (^)(HttpException *))failure
//{
//    [[HttpClient sharedInstance] get:GetActivityInfoFromBanner params:[param dictionaryModel] success:^(id responseObj) {
//        
//        NSMutableArray *keyArr = [NSMutableArray array];
//        [keyArr addObject:NSStringFromClass([ActivityImgsModel class])];
//        
//        NSMutableArray *valueArr = [NSMutableArray array];
//        [valueArr addObject:@"imgs"];
//        
//        ActivityDataModel *bodyModel = [ActivityDataModel parse:responseObj ClassArr:keyArr Elements:valueArr];
//        if (succsee) {
//            succsee(bodyModel);
//        }
//        
//    } failure:^(HttpException *e) {
//        if (failure) {
//            failure(e);
//        }
//    }];
//}
/**
 *  请求中奖纪录
 **/
+(void)getWonAwards:(QueryWonAwardsR *)param
            success:(void (^)(LuckdrawAwardListVo *responModel))success
            failure:(void (^)(HttpException *e))failure {
    [[HttpClient sharedInstance]get:QueryWonAwards params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([LuckdrWonAwardVo class])];
        [keyArr addObject:NSStringFromClass([LuckdrWonAwardVo class])];
        [keyArr addObject:NSStringFromClass([LuckdrWonAwardVo class])];
        [keyArr addObject:NSStringFromClass([LuckdrWonAwardVo class])];
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"awards"];
        [valueArr addObject:@"used"];
        [valueArr addObject:@"overdue"];
        [valueArr addObject:@"grant"];
        
        LuckdrawAwardListVo *listModel =  [LuckdrawAwardListVo parse:responseObj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
/**
 *  请求微商开通情况下抢购商品详情
 **/
+(void)getRushProductList:(QueryRushProductR *)param success:(void(^)(GrabActivityRushVo *model))success failure:(void(^)(HttpException *e))failure {
    [[HttpClient sharedInstance] get:GrabActivityRushPro params:[param dictionaryModel] success:^(id responseObj) {
        GrabActivityRushVo *listModel = [GrabActivityRushVo parse:responseObj Elements:[RushProductVo class] forAttribute:@"productList"];
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

