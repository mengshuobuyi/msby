//
//  FamilyMedicine.m
//  APP
//
//  Created by carret on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FamilyMedicine.h"

#import "QueryMyBoxModel.h"
@implementation FamilyMedicine



+ (void)addFamilyMember:(AddFamilyMemberR *)param
                success:(void (^)(id))success
                failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] post:AddFamilyMember params:[param dictionaryModel] success:^(id obj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([SlowDiseaseVo class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"slowDiseases"];
        
        FamilyMemberDetailVo *familyMemberDetailVo = [FamilyMemberDetailVo parse:obj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(familyMemberDetailVo);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)analystByType:(AnalystByTypeModelR *)param
              success:(void (^)(AnalystByTypeList *model))success
              failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:AnalystByType params:[param dictionaryModel] success:^(id obj) {
        
        AnalystByTypeList *list = [AnalystByTypeList parse:obj Elements:[AnalystByTypeVOModel class] forAttribute:@"list"];
        if (success) {
            success(list);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)analystByMember:(AnalystByMemberModelR *)param
                success:(void (^)(AnalystByMemberList *model))success
                failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:AnalystByMember params:[param dictionaryModel] success:^(id obj) {
        AnalystByMemberList *list = [AnalystByMemberList parse:obj Elements:[AnalystByMemberVOModel class] forAttribute:@"list"];
        if (success) {
            success(list);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}



+ (void)getMemberInfo:(GetMemberInfoR *)param
              success:(void (^)(id))success
              failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:GetMemberInfo params:[param dictionaryModel] success:^(id obj) {
//        FamilyMemberDetailVo *familyMemberDetailVo = [FamilyMemberDetailVo parse:obj];
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([SlowDiseaseVo class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"slowDiseases"];
        
        FamilyMemberDetailVo *familyMemberDetailVo = [FamilyMemberDetailVo parse:obj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(familyMemberDetailVo);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)checkChronicDiseaseUser:(QueryFamilyMembersR *)param
                        success:(void (^)(ChronicDiseaseUserVoModel *modelR))success
                        failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:CheckChronicDiseaseUser params:[param dictionaryModel] success:^(id obj) {
        ChronicDiseaseUserVoModel *familyMemberDetailVo = [ChronicDiseaseUserVoModel parse:obj];
        if (success) {
            success(familyMemberDetailVo);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)queryAllMedicine:(QueryAllMedicineR *)param
                 success:(void (^)(id))success
                 failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:QueryAllMedicine params:[param dictionaryModel] success:^(id obj) {
        BoxMedicine   *boxMedicine = [BoxMedicine parse:obj];
        if (success) {
            success(boxMedicine);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)queryFamilyMembers:(QueryFamilyMembersR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:QueryFamilyMembers params:[param dictionaryModel] success:^(id obj) {

        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([FamilyMembersVo class])];
        [keyArr addObject:NSStringFromClass([SlowDiseaseVo class])];
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"list"];
        [valueArr addObject:@"slowDiseases"];
                  QueryFamilyMembersModel *allTagsModel = [QueryFamilyMembersModel parse:obj ClassArr:keyArr Elements:valueArr];
  
        if (success) {
            success(allTagsModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)queryMemberMedicines:(QueryMemberMedicinesR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get :QueryMemberMedicines params:[param dictionaryModel] success:^(id obj) {
            NSArray *myboxModelList = [QueryMyBoxModel parseArray:obj[@"list"]];
        
        
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

+ (void)queryMemberSlowDisease:(QueryMemberSlowDiseaseR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:QueryMemberSlowDisease params:[param dictionaryModel] success:^(id obj) {
         if (success) {
             SlowDiseaseVoList *listModel = [SlowDiseaseVoList parse:obj Elements:[SlowDiseaseVo class] forAttribute:@"list"];
            success(listModel.list);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)updateFamilyMember:(UpdateFamilyMemberR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:UpdateFamilyMember params:[param dictionaryModel] success:^(id obj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([SlowDiseaseVo class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"slowDiseases"];
        
        FamilyMemberDetailVo *familyMemberDetailVo = [FamilyMemberDetailVo parse:obj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(familyMemberDetailVo);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)updateMemberSlowDisease:(UpdateMemberSlowDiseaseR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:UpdateMemberSlowDisease params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)updateUseOrResult:(UpdateUseOrResultR *)param
                  success:(void (^)(id))success
                  failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:UpdateUseOrResult params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)updateUsePeople:(UpdateUsePeopleR *)param
                success:(void (^)(id))success
                failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:UpdateUseOrResult params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)deleteFamilyMember:(DeleteFamilyMemberR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:DeleteFamilyMember params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
+ (void)queryNoCompleteMedicine:(QueryNoCompleteMedicineR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:QueryNoCompleteMedicine params:[param dictionaryModel] success:^(id obj) {
        
           QueryNoCompleteMedicineModel *allTagsModel = [QueryNoCompleteMedicineModel parse:obj Elements:[MemberMedicine class] forAttribute:@"list"];
        
        if (success) {
            success(allTagsModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)completeMemberMedicine:(CompleteMemberMedicineR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:CompleteMemberMedicine params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
//        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)medicineDetail:(MedicineDetailR *)param
               success:(void (^)(id))success
               failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:MedicineDetail params:[param dictionaryModel] success:^(id obj) {
        
  
        
        if (success) {
            success([MedicineDetailModel parse:obj]);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)addMemberMedicine:(AddMemberMedicineR *)param
                  success:(void (^)(id))success
                  failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] post :AddMemberMedicine params:[param dictionaryModel] success:^(id obj) {
        
        
        
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
+ (void)searchByTag:(SearchByTagR *)param
            success:(void (^)(id))success
            failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:SearchByTag params:[param dictionaryModel] success:^(id obj) {
        
        
        NSArray *boxByTagArray = [QueryMyBoxModel parseArray:obj[@"list"]];
        if (success) {
            success(boxByTagArray);
        }
    } failure:^(HttpException *e) {
     
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)byKeyword:(ByKeywordR *)param
          success:(void (^)(id))success
          failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:ByKeyword params:[param dictionaryModel] success:^(id obj) {
        
        
        NSArray *boxByTagArray = [QueryMyBoxModel parseArray:obj[@"list"]];
        if (success) {
            success(boxByTagArray);
        }
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)queryTags:(QueryTagsR *)param
          success:(void (^)(id))success
          failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] get:QueryTags params:[param dictionaryModel] success:^(id obj) {
        
        
        QueryAllTagsModel *allTagsModel = [QueryAllTagsModel parse:obj Elements:[TagsModel class] forAttribute:@"list"];
        if (success) {
            success(allTagsModel.list);
        }
    } failure:^(HttpException *e) {
        
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)updateTag:(UpdateTagR *)param
          success:(void (^)(id))success
          failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:UpdateTag params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)deleteMemberMedicine:(DeleteMemberMedicineR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;

    [[HttpClient sharedInstance] put:DeleteMemberMedicine params:[param dictionaryModel] success:^(id obj) {
        if (success) {
            success(obj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
@end
