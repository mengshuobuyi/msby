//
//  Box.m
//  APP
//
//  Created by garfield on 15/3/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Box.h"


@implementation Box

+ (void)queryMyBoxWithParams:(QueryMyboxModelR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:QueryMyBox params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);

        NSArray *myboxModelList = [QueryMyBoxModel parseArray:responseObj[@"list"]];
        if (success) {
            success(myboxModelList);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)queryBoxByKeywordWithParams:(QueryBoxByKeywordModelR *)param
                            success:(void (^)(id))success
                            failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:QueryBoxByKeyword params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        NSArray *array = [QueryMyBoxModel parseArray:responseObj[@"list"]];
        if (success) {
            success(array);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)queryBoxByTagWithParams:(QueryBoxByTagModelR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:QueryBoxByTag params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        NSArray *boxByTagArray = [QueryMyBoxModel parseArray:responseObj[@"list"]];
        if (success) {
            success(boxByTagArray);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)saveOrUpdateMyBoxWithParams:(SaveOrUpdateMyBoxModelR *)param
                            success:(void (^)(id))success
                            failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:SaveOrUpdateMyBox params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        SaveOrUpdateMyBoxModel *myboxModel = [SaveOrUpdateMyBoxModel parse:responseObj];
        if (success) {
            success(myboxModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)GetBoxProductDetailWithParams:(GetBoxProductDetailR *)param
                              success:(void (^)(id))success
                              failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:GetBoxProductDetail params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        GetBoxProductDetailModel *productDetailModel = [GetBoxProductDetailModel parse:responseObj];
        if (success) {
            success(productDetailModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)DeleteBoxProductWithParams:(DeleteBoxProductR *)param
                           success:(void (^)(id))success
                           failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] put:DeleteBoxProduct params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        QueryMyBoxModel *myboxModel = [QueryMyBoxModel parse:responseObj];
        if (success) {
            success(myboxModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)UpdateBoxProductTagWithParams:(UpdateBoxProductTagR *)param
                              success:(void (^)(id))success
                              failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] put:UpdateBoxProductTag params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        QueryMyBoxModel *myboxModel = [QueryMyBoxModel parse:responseObj];
        if (success) {
            success(myboxModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)SimilarDrugWithParams:(SimilarDrugR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:SimilarDrug params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        NSArray *similarDrugList = [SimilarDrugModel parseArray:responseObj[@"list"]];
        if (success) {
            success(similarDrugList);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)QueryAllTagsWithParams:(QueryAllTagsR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:QueryAllTags params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"responseObj===>%@",responseObj);
        QueryAllTagsModel *allTagsModel = [QueryAllTagsModel parse:responseObj Elements:[TagsModel class] forAttribute:@"list"];
        if (success) {
            success(allTagsModel.list);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//+ (void)GetProductUsageWithParams:(QueryMyboxModelR *)param
//                          success:(void (^)(id))success
//                          failure:(void (^)(HttpException *))failure
//{
//    [[HttpClient sharedInstance] post:GetBoxProductDetail params:[param dictionaryModel] success:^(id responseObj) {
//        DebugLog(@"responseObj===>%@",responseObj);
//        QueryMyBoxModel *myboxModel = [QueryMyBoxModel parse:responseObj];
//        if (success) {
//            success(myboxModel);
//        }
//    } failure:^(HttpException *e) {
//        DebugLog(@"%@",e);
//        if (failure) {
//            failure(e);
//        }
//    }];
//}

@end
