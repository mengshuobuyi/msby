//
//  Disease.m
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Disease.h"


@implementation Disease


//疾病搜索------------------------------------------------------------------------------------------------------------
+(void)queryDiseasekwIdWithParam:(id)param success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryDiseaseBykwid
                              params:[param dictionaryModel]
                             success:^(id resultObj) {
         Diseasekwid *kwid=[Diseasekwid parse:resultObj Elements:[Diseaseclasskwid class] forAttribute:@"list"];
         if (success) {
             success(kwid);
         }
                             }
                             failure:^(HttpException *e) {
                                 DebugLog(@"%@",e);
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}




//常见疾病的加载（1）
+ (void)queryDiseaseClassWithParams:(DiseaseClassModelR *)param
                            success:(void (^)(id))success
                            failure:(void (^)(HttpException *))failure
{
    
    [[HttpClient sharedInstance] get:Disease_diseaseClass params:[param dictionaryModel] success:^(id responseObj) {
        
        NSMutableArray *valueArray = [NSMutableArray array];
        [valueArray addObject:NSStringFromClass([DiseaseClassListModel class])];
        [valueArray addObject:NSStringFromClass([DiseaseSubClassModel class])];
        
        NSMutableArray *keyArray = [NSMutableArray array];
        [keyArray addObject:@"list"];
        [keyArray addObject:@"subClass"];
        
        DiseaseClassModel *diseaseClassModel = [DiseaseClassModel parse:responseObj ClassArr:valueArray Elements:keyArray];
        
        
        
        if (success) {
            success(diseaseClassModel);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
//疾病百科（2）
+ (void)queryAllDiseaseWithParams:(DiseaseViKiModelR *)param
                          success:(void (^)(id obj))success
                          failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] get:Disease_diseaseAll params:[param dictionaryModel] success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];}



//3.3.12	疾病明细查询

+ (void)getDiseaseDetailIOSWithParam:(id)param
                             success:(void (^)(id))success
                             failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get:Disease_diseaseDetailIOS params:[param dictionaryModel] success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

//根据症状关联的疾病

+ (void)queryAssociationDiseaseWithParams:(PossibleDiseaseR *)param
                                  success:(void (^)(id))success
                                  failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] get: QueryAssociationDisease
                              params:[param dictionaryModel]
                             success:^(id resultObj) {
                                 
                                 
                                 PossibleDiseasePage *page = [PossibleDiseasePage parse:resultObj Elements:[PossibleDisease class] forAttribute:@"list"];
                                 if (success) {
                                     success(page);
                                 }
                                 
                             }
                             failure:^(HttpException *e) {
                                 if (failure) {
                                     failure(e);
                                 }
                             }];
}
//------------------------------------------------------------------------------------------------------------








@end
