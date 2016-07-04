//
//  Promotion.m
//  APP
//
//  Created by qw on 15/3/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Promotion.h"
#import "HttpClient.h"

@implementation Promotion

+ (void)queryBannerWithParams:(PromotionModelR *)param
                      success:(void(^)(id obj))success
                      failure:(void(^)(HttpException * e))failure
{
    [HttpClientMgr get:PromotionBanner params:[param dictionaryModel] success:^(id responseObj) {
        
        BannerModel *model = [BannerModel parse:responseObj];
        if (success) {
            success(model);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
    
}

//附近优惠商品列表 add by lijian 2.2.0
+ (void)queryNearByPromotionListWithParams:(NearByPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{

    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:NearByPromotion params:[param dictionaryModel] success:^(id responseObj) {
    
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([DrugVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        NearByPromotionListModel *promotionList = [NearByPromotionListModel parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(promotionList);
        }
        
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}




//筛选条件：商品标签列表 add by lijian 2.2.0
+ (void)queryNearByPromotionTagWithParams:(TagModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:CityTag params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([TagFilterVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        TagFilterList *List = [TagFilterList parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(List);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}
//筛选条件：商品标签列表 add by lijian 2.2.0
+ (void)queryNearByPromotionGroupTagWithParams:(TagModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:GroupTag params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([GroupFilterVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        GroupFilterList *List = [GroupFilterList parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(List);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

//商品所属活动适用药房列表 add by lijian 2.2.0
+ (void)queryPromotionBranchWithParams:(PromotionGroupModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    [HttpClientMgr get:PromotionDrugBranch params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([BranchVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"list"];
        
        BranchListVo *List = [BranchListVo parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(List);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];

}

//商品所属商家列表 add by lijian 2.2.0
+ (void)queryPromotionGroupWithParams:(PromotionGroupModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    [HttpClientMgr get:PromotionDrugGroup params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([GroupVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"groupVoList"];
        
        GroupVoList *List = [GroupVoList parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(List);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

//领取优惠 add by lijian 2.2.0
+ (void)pickPromitionDrug:(PickPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    [HttpClientMgr post:PickPromotionDrug params:[param dictionaryModel] success:^(id responseObj) {
        
        DrugGetVo *vo = [DrugGetVo parse:responseObj];
        
        if (success) {
            success(vo);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

//生成code add by lijian 2.2.0
+ (void)createVerifyCode:(CreateVerifyCodeModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    [HttpClientMgr post:CreateVerifyCode params:[param dictionaryModel] success:^(id responseObj) {
        
        OrderCreateVo *vo = [OrderCreateVo parse:responseObj];
        
        if (success) {
            success(vo);
        }
        
    } failure:^(HttpException *e) {
        		
        if (failure) {
            failure(e);
        }
    }];
}

//轮询订单是否被商家验证 add by lijian 2.2.0
+ (void)loopCheck:(LoopCheckModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:BaseLoopCheck params:[param dictionaryModel] success:^(id responseObj) {
        
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([CouponGiftVoModel class])];
        [keyArray addObject:NSStringFromClass([PresentPromotionVo class])];
        [keyArray addObject:NSStringFromClass([PresentCouponVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"gifts"];
        [valueArray addObject:@"presentPromotions"];
        [valueArray addObject:@"presentCoupons"];
        
        LoopCheckVo *model = [LoopCheckVo parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(model);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

//评价 add by lijian 2.2.0
+ (void)baseComment:(commnetModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    [HttpClientMgr post:Comment params:[param dictionaryModel] success:^(id responseObj) {
        
        BaseAPIModel *model = [BaseAPIModel parse:responseObj];
        
        if (success) {
            success(model);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

//查看我的评价 add by lijian 2.2.0
+ (void)checkMyComment:(commnetModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    [HttpClientMgr get:GetMyComment params:[param dictionaryModel] success:^(id responseObj) {
        
        CommentVo *model = [CommentVo parse:responseObj];
        
        if (success) {
            success(model);
        }
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}





//附近优惠商品列表 add by cj 2.2.3
+ (void)queryNewNearByPromotionListWithParams:(NewNearByPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:GetNearbyWithSearch params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:NSStringFromClass([ChannelProductVo class])];
        [keyArray addObject:NSStringFromClass([ActivityCategoryVo class])];
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:@"normalPromotionList"];
        [valueArray addObject:@"promotionList"];
        
        PromotionProductArrayVo *promotionList = [PromotionProductArrayVo parse:responseObj ClassArr:keyArray Elements:valueArray];
        
        if (success) {
            success(promotionList);
        }
        
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)queryNewNearByTwoListWithParams:(NewNearByPromotionModelR *)param success:(void(^)(id obj))success failure:(void(^)(HttpException * e))failure{
    
//    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:GetNearbyWithSearch params:[param dictionaryModel] success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
        
        
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}


@end
