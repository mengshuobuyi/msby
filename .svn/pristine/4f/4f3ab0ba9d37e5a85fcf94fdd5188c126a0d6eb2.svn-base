//
//  MallCart.m
//  APP
//
//  Created by garfield on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MallCart.h"
#import "SBJson.h"


@implementation MallCart

//微商-购物车列表
+(void)queryMMallCart:(MallCartModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MMallCart params:[params dictionaryModel] success:^(id obj) {
        
        CartVoModel *model = [CartVoModel parse:obj Elements:[CartBranchVoModel class] forAttribute:@"branchs"];
        model.branchs = [NSMutableArray arrayWithArray:model.branchs];
        for(CartBranchVoModel *branchVoModel in model.branchs) {
            branchVoModel.products = [NSMutableArray arrayWithArray:[CartProductVoModel parseArray:branchVoModel.products]];
            branchVoModel.combos = [NSMutableArray arrayWithArray:[CartComboVoModel parseArray:branchVoModel.combos]];
            branchVoModel.redemptions = [NSMutableArray arrayWithArray:[CartRedemptionVoModel parseArray:branchVoModel.redemptions]];
            branchVoModel.availableRedemptions = [NSMutableArray arrayWithArray:[CartRedemptionVoModel parseArray:branchVoModel.availableRedemptions]];
            for(CartProductVoModel *subModel in branchVoModel.products) {
                subModel.promotions = [NSMutableArray arrayWithArray: [CartPromotionVoModel parseArray:subModel.promotions]];
            }
            for(CartComboVoModel *subModel in branchVoModel.combos) {
                subModel.druglist = [NSMutableArray arrayWithArray: [ComboProductVoModel parseArray:subModel.druglist]];
            }
        }
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

//点击结算按钮事件
+(void)queryMMallCartCheck:(MMallCartCheckModelR *)params success:(void(^)(BaseAPIModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:MMallCartCheck params:[params dictionaryModel] success:^(id obj) {
        BaseAPIModel *model = [BaseAPIModel parse:obj];
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

//购物数据变更同步接口
+(void)queryMallCartSync:(MMallCartSyncModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:MMallCartSync params:[params dictionaryModel] success:^(id obj) {
        
        CartVoModel *model = [CartVoModel parse:obj Elements:[CartBranchVoModel class] forAttribute:@"branchs"];
        model.branchs = [NSMutableArray arrayWithArray:model.branchs];
        for(CartBranchVoModel *branchVoModel in model.branchs) {
            branchVoModel.products = [NSMutableArray arrayWithArray:[CartProductVoModel parseArray:branchVoModel.products]];
            for(CartProductVoModel *subModel in branchVoModel.products) {
                subModel.promotions = [NSMutableArray arrayWithArray: [CartPromotionVoModel parseArray:subModel.promotions]];
            }
        }
        
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

// 3.1.0 版本 new check接口,点击结算按钮事件
+(void)queryMallCartNewCheck:(MMallCartCheckModelR *)params success:(void(^)(BaseAPIModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:MMallCartNewCheck params:[params dictionaryModel] success:^(id obj) {
        BaseAPIModel *model = [BaseAPIModel parse:obj];
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

// 3.1.0 版本 new preview接口,订单提交预览
+(void)queryMallCartNewPreView:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartPreviewVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MMallCartNewPreview params:[params dictionaryModel] success:^(id obj) {
//        MicroMallCartPreviewVoModel *model = [MicroMallCartPreviewVoModel parse:obj];
        MicroMallCartPreviewVoModel *model = [MicroMallCartPreviewVoModel parse:obj Elements:[AddressVo class] forAttribute:@"address"];
        model.coupons = [CartPromotionVoModel parseArray:model.coupons];
        model.deliveryTypes = [DeliveryTypeVoModel parseArray:model.deliveryTypes];
        model.branchs = [CartBranchVoModel parseArray:model.branchs];
        model.payTypes = [PayTypeVoModel parseArray:model.payTypes];
        if(obj && obj[@"newCoupons"]) {
            model.couponList = [CartOnlineCouponVoModel parseArray:obj[@"newCoupons"]];
        }
        if(model.branchs.count > 0) {
            for(CartBranchVoModel *branchVoModel in model.branchs) {
                
                branchVoModel.products = [NSMutableArray arrayWithArray:[CartProductVoModel parseArray:branchVoModel.products]];
                branchVoModel.combos = [NSMutableArray arrayWithArray:[CartComboVoModel parseArray:branchVoModel.combos]];
                branchVoModel.redemptions = [NSMutableArray arrayWithArray:[CartRedemptionVoModel parseArray:branchVoModel.redemptions]];
                branchVoModel.availableRedemptions = [NSMutableArray arrayWithArray:[CartRedemptionVoModel parseArray:branchVoModel.availableRedemptions]];
                for(CartProductVoModel *subModel in branchVoModel.products) {
                    subModel.promotions = [NSMutableArray arrayWithArray: [CartPromotionVoModel parseArray:subModel.promotions]];
                }
                for(CartComboVoModel *subModel in branchVoModel.combos) {
                    subModel.druglist = [NSMutableArray arrayWithArray: [ComboProductVoModel parseArray:subModel.druglist]];
                }
            }
        }
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

// 3.1.0 版本,查询门店下换购活动列表
+(void)queryBranchsByMultiBranch:(MMallRedemptionModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:QueryBranchs params:[params dictionaryModel] success:^(id obj) {
        CartVoModel *model = [CartVoModel parse:obj Elements:[CartBranchVoModel class] forAttribute:@"branchs"];
        for(CartBranchVoModel *branchModel in model.branchs) {
            branchModel.availableRedemptions = [CartRedemptionVoModel parseArray:branchModel.availableRedemptions];
        }
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

// 3.1.0 版本 new submit接口,订单提交
+(void)queryMallCartNewSubmit:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartCompleteVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:MMallCartNewSubmit params:[params dictionaryModel] success:^(id obj) {
        MicroMallCartCompleteVoModel *model = [MicroMallCartCompleteVoModel parse:obj];
        model.tips = [ProductTabooVoModel parseArray:model.tips];
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

// 3.1.0 版本 new sync接口,购物数据变更同步接口
+ (void)queryMallCartNewSync:(MMallCartSyncModelR *)params success:(void(^)(CartVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:MMallCartNewSync params:[params dictionaryModel] success:^(id obj) {
        
        CartVoModel *model = [CartVoModel parse:obj Elements:[CartBranchVoModel class] forAttribute:@"branchs"];
        model.branchs = [NSMutableArray arrayWithArray:model.branchs];
        for(CartBranchVoModel *branchVoModel in model.branchs) {
            branchVoModel.products = [NSMutableArray arrayWithArray:[CartProductVoModel parseArray:branchVoModel.products]];
            branchVoModel.combos = [NSMutableArray arrayWithArray:[CartComboVoModel parseArray:branchVoModel.combos]];
            branchVoModel.redemptions = [NSMutableArray arrayWithArray:[CartRedemptionVoModel parseArray:branchVoModel.redemptions]];
            branchVoModel.availableRedemptions = [NSMutableArray arrayWithArray:[CartRedemptionVoModel parseArray:branchVoModel.availableRedemptions]];
            
            for(CartProductVoModel *subModel in branchVoModel.products) {
                subModel.promotions = [NSMutableArray arrayWithArray: [CartPromotionVoModel parseArray:subModel.promotions]];
            }
            for(CartComboVoModel *subModel in branchVoModel.combos) {
                subModel.druglist = [NSMutableArray arrayWithArray: [ComboProductVoModel parseArray:subModel.druglist]];
            }
        }
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

//订单提交预览
+(void)queryMallCartPreView:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartPreviewVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:MMallCartPreview params:[params dictionaryModel] success:^(id obj) {
        MicroMallCartPreviewVoModel *model = [MicroMallCartPreviewVoModel parse:obj];
        model.coupons = [CartPromotionVoModel parseArray:model.coupons];
        model.deliveryTypes = [DeliveryTypeVoModel parseArray:model.deliveryTypes];
        model.branchs = [CartBranchVoModel parseArray:model.branchs];
        if(model.branchs.count > 0) {
            for(CartBranchVoModel *branchVoModel in model.branchs) {
                branchVoModel.products = [NSMutableArray arrayWithArray:[CartProductVoModel parseArray:branchVoModel.products]];
                for(CartProductVoModel *subModel in branchVoModel.products) {
                    subModel.promotions = [NSMutableArray arrayWithArray: [CartPromotionVoModel parseArray:subModel.promotions]];
                }
            }
        }
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

+(void)queryMallCartSubmit:(MMallCartPreviewModelR *)params success:(void(^)(MicroMallCartCompleteVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:MMallCartSubmit params:[params dictionaryModel] success:^(id obj) {
        MicroMallCartCompleteVoModel *model = [MicroMallCartCompleteVoModel parse:obj];
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

+(void)queryMmallAdvice:(MmallAdviceModelR *)params success:(void(^)(BaseAPIModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:MMallAdvice params:[params dictionaryModel] success:^(id obj) {
        BaseAPIModel *model = [BaseAPIModel parse:obj];
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

+(void)getOrderResult:(GetOrderResultModelR *)params success:(void(^)(MicroMallCartCompleteVoModel *responseModel))success failure:(void(^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:GetOrderResult params:[params dictionaryModel] success:^(id obj) {
        MicroMallCartCompleteVoModel *model = [MicroMallCartCompleteVoModel parse:obj];
        model.tips = [ProductTabooVoModel parseArray:model.tips];
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


@end
