/*!
 @header Drug.m
 @abstract 药品相关接口
 @author .
 @version 1.00 2015/03/06  (1.00)
 */

#import "Drug.h"
@implementation Drug

//-----------------------健康方案----------------------------

#pragma 健康方案

+ (void)queryRecommendClassWithParam:(HealthyScenarioModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
    [HttpClientMgr get:GetRecommendClass params:[params dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:NSStringFromClass([HealthyScenarioModel class])];
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:@"list"];
        
        HealthyScenarioListModel*scenarionList = [HealthyScenarioListModel parse:responseObj ClassArr:valueArray Elements:keyArray];
        
        
        if (success) {
            success(scenarionList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


#pragma 健康方案的药品列表
+ (void)queryRecommendProductByClassWithParam:(HealthyScenarioDrugModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
//    HttpClientMgr.progressEnabled = NO;
    [HttpClientMgr get:GetRecommendProductByClass params:[params dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:NSStringFromClass([HealthyScenarioDrugModel class])];
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:@"list"];
        
        HealthyScenarioListModel *scenarionList = [HealthyScenarioListModel parse:responseObj ClassArr:valueArray Elements:keyArray];
        
        
        if (success) {
            success(scenarionList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


#pragma 健康知识列表
+ (void)queryRecommendKnowledgeWithParam:(HealthyScenarioDiseaseModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure
{
    [HttpClientMgr get:GetRecommendKnowledge params:[params dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *valueArray= [NSMutableArray array];
        [valueArray addObject:NSStringFromClass([HealthyScenarioDiseaseModel class])];
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:@"list"];
        
        HealthyScenarioListModel *scenarionDiseaseList = [HealthyScenarioListModel parse:responseObj ClassArr:valueArray Elements:keyArray];
        
        
        if (success) {
            success(scenarionDiseaseList);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
//-------------------------------------------------------------------------------------------



//------------药品一级分-类-------------------------------------------------------
+ (void)queryProductFirstWithParam:(id)model
                           Success:(void(^)(id DFUserModel))success
                           failure:(void(^)(HttpException * e))failure{
    
    [[HttpClient sharedInstance] get:QueryProductFirst params:[model dictionaryModel] success:^(id responseObj) {
        
        QueryProductClassModel *queryProductClassModel = [QueryProductClassModel parse:responseObj Elements:[QueryProductFirstModel class] forAttribute:@"list"];
        if (success) {
            success(queryProductClassModel);
        }

    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];

}


//药品的二级分类
+(void)queryProductSecondWithParam:(id)model
                                Success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] get:QueryProductSecond params:[model dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:NSStringFromClass([QueryProductSecondModel class])];
        [valueArray addObject:NSStringFromClass([QueryProductFirstModel class])];
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:@"list"];
        [keyArray addObject:@"children"];
        
        DrugModel *model = [DrugModel parse:responseObj ClassArr:valueArray Elements:keyArray];
        if (success) {
            success(model);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
    
}

+ (void)queryProductByClassWithParam:(id)model
                             Success:(void (^)(id))success
                             failure:(void (^)(HttpException *))failure
{
//    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryProductByClass params:[model dictionaryModel] success:^(id responseObj) {
        
        QueryProductClassModel *queryProductClassModel = [QueryProductClassModel parse:responseObj Elements:[QueryProductByClassItemModel class] forAttribute:@"list"];
        if (success) {
            success(queryProductClassModel);
        }
        
        
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
//根据商品分类ID，查找相应的生产厂家
+ (void)fetchProFactoryByClassWithParam:(id)model
                                Success:(void (^)(id))success
                                failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:FetchProFactoryByClass params:[model dictionaryModel] success:^(id responseObj) {
        QueryProductClassModel *queryProductClassModel = [QueryProductClassModel parse:responseObj Elements:[FetchProFactoryByClassModel class] forAttribute:@"list"];
        
        if (success) {
            success(queryProductClassModel);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+(void)queryProductDetailWithParam:(id)model Success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    [[HttpClient sharedInstance] get:QueryProductDetail params:[model dictionaryModel]success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


//--------------------------------------------------------------------------------------------------------------



//-----------搜索的接口---------------------------------------------------------------

+(void)getsearchKeywordsWithParam:(id)model Success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance]get:GetSearchKeywords params:[model dictionaryModel] success:^(id responseObj) {
        
        GetSearchKeywordsModel *searchkey=[GetSearchKeywordsModel parse:responseObj Elements:[GetSearchKeywordsclassModel class] forAttribute:@"list"];
        
        if (success) {
            success(searchkey);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+(void)queryProductByKwIdWithParam:(id)model Success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryProductByKwId params:[model dictionaryModel] success:^(id responseObj) {
        GetSearchKeywordsModel *searchkey=[GetSearchKeywordsModel parse:responseObj Elements:[productclassBykwId class] forAttribute:@"list"];
        
        if (success) {
            success(searchkey);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



//3.3.15	疾病组方配方用药查询(OK)
+(void)queryDiseaseFormulaProductListWithParam:(id)model Success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    [[HttpClient sharedInstance] get:QW_queryDiseaseFormulaProductList params:[model dictionaryModel] success:^(id responseObj) {
        DiseaseFormulaPruduct *s = [DiseaseFormulaPruduct parse:responseObj Elements:[DiseaseFormulaPruductclass class] forAttribute:@"list"];
        if (success) {
            success(s);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//3个的治疗用药
+(void)queryDiseaseProductListWithParam:(id)model Success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    [[HttpClient sharedInstance] get:Disease_queryDiseaseProductList params:[model dictionaryModel] success:^(id responseObj) {
        DiseaseFormulaPruduct *s = [DiseaseFormulaPruduct parse:responseObj Elements:[DiseaseFormulaPruductclass class] forAttribute:@"list"];
        if (success) {
            success(s);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



//----------------------------------------------------------------------------------------------------------












//**czp的扫码的两个接口***************************************************************************************************************

//扫码获取商品信息
+(void)queryProductByBarCodeWithParam:(NSDictionary *)params
                              Success:(void(^)(id DFUserModel))success
                              failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryProductByBarCode params:params success:^(id responseObj) {
        DrugScanModel *modelScan = [DrugScanModel parse:responseObj Elements:[ProductModel class] forAttribute:@"list"];//[DrugScanModel parse:responseObj Elements:@"list"];
//        NSArray* modelArray = [ProductModel parseArray:responseObj[@"list"]];
        if (success) {
            success(modelScan);
        }
        
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
//获取商品的用法用量
+(void)getProductUsageWithParam:(id)model
                        Success:(void(^)(id DFUserModel))success
                        failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] get:QW_GetProductUsage params:model success:^(id responseObj) {
        
            ProductUsage *body = [ProductUsage parse:responseObj];
            if (success) {
                success(body);
            }
        
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//我的用药的添加药品时的接口
+ (void)queryProductByKeywordWithParam:(QueryProductByKeywordModelR *)params
                               Success:(void(^)(id DFUserModel))success
                               failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] get:QueryProductByKeyword params:[params dictionaryModel] success:^(id responseObj) {
        
        NSArray *array = [QueryProductByKeywordModel parseArray:responseObj[@"list"]];
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

//区域畅销商品（附近药店）
+(void)drugSellListWithParam:(id)model
                     Success:(void (^)(id DFModel))success
                     failure:(void (^)(HttpException *e))failure
{
    
    [[HttpClient sharedInstance] getWithoutProgress:Drug_getSellWellProducts params:[model dictionaryModel] success:^(id responseObj) {
        
        DrugSellWellProductsModel *model = [DrugSellWellProductsModel parse:responseObj Elements:[DrugSellWellProductsFactoryModel class] forAttribute:@"list"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
//********************************************************************************************************************************

+(void)similarDrugs:(id)model
            Success:(void (^)(id DFModel))success
            failure:(void (^)(HttpException *e))failure
{
    {
        
        [[HttpClient sharedInstance] getWithoutProgress:SimilarDrugs params:[model dictionaryModel] success:^(id responseObj) {
          
            SimilarDrugsModel *model = [SimilarDrugsModel parse:responseObj Elements:[SimpleProductWithPromotionVOModel class] forAttribute:@"list"];
            if (success) {
                success(model);
            }
        } failure:^(HttpException *e) {
            if (failure) {
                failure(e);
            }
        }];
    }
}


@end
