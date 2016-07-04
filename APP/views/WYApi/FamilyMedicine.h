//
//  FamilyMedicine.h
//  APP
//
//  Created by carret on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyMedicineR.h"
#import "FamilyMedicineModel.h"


@interface FamilyMedicine : NSObject
///新增家庭成员
+ (void)addFamilyMember:(AddFamilyMemberR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;
///api/familyMedicine/getMemberInfo 获取家庭成员详细信息
+ (void)getMemberInfo:(GetMemberInfoR *)param
                success:(void (^)(id))success
                failure:(void (^)(HttpException *))failure;
///api/familyMedicine/queryAllMedicine 家庭药箱，查询所有药品
+ (void)queryAllMedicine:(QueryAllMedicineR *)param
              success:(void (^)(id))success
              failure:(void (^)(HttpException *))failure;

+ (void)checkChronicDiseaseUser:(QueryFamilyMembersR *)param
                        success:(void (^)(ChronicDiseaseUserVoModel *modelR))success
                        failure:(void (^)(HttpException *))failure;

+ (void)analystByType:(AnalystByTypeModelR *)param
              success:(void (^)(AnalystByTypeList *model))success
              failure:(void (^)(HttpException *))failure;

+ (void)analystByMember:(AnalystByMemberModelR *)param
                success:(void (^)(AnalystByMemberList *model))success
                failure:(void (^)(HttpException *))failure;

///api/familyMedicine/queryFamilyMembers 查询家庭成员列表
+ (void)queryFamilyMembers:(QueryFamilyMembersR *)param
                 success:(void (^)(id))success
                 failure:(void (^)(HttpException *))failure;
///api/familyMedicine/queryMemberMedicines 查询家人用药列表
+ (void)queryMemberMedicines:(QueryMemberMedicinesR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure;
///api/familyMedicine/queryMemberSlowDisease 查询家庭成员的慢病
+ (void)queryMemberSlowDisease:(QueryMemberSlowDiseaseR *)param
                     success:(void (^)(id))success
                     failure:(void (^)(HttpException *))failure;

///api/familyMedicine/updateFamilyMember 修改家庭成员

+ (void)updateFamilyMember:(UpdateFamilyMemberR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure;
///api/familyMedicine/updateMemberSlowDisease 更新家庭成员的慢病。若已关注则取消，反之则关注

+ (void)updateMemberSlowDisease:(UpdateMemberSlowDiseaseR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure;
///api/familyMedicine/updateUseOrResult 修改家庭成员用药的用法用量，药效

+ (void)updateUseOrResult:(UpdateUseOrResultR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure;
///api/familyMedicine/updateUsePeople 更新家庭药箱药品的使用人

+ (void)updateUsePeople:(UpdateUsePeopleR *)param
                  success:(void (^)(id))success
                  failure:(void (^)(HttpException *))failure;

///api/familyMedicine/deleteFamilyMember 删除家庭成员
+ (void)deleteFamilyMember:(DeleteFamilyMemberR *)param
                success:(void (^)(id))success
                failure:(void (^)(HttpException *))failure;

///api/familyMedicine/queryNoCompleteMedicine 查询待完善的用药列表
+ (void)queryNoCompleteMedicine:(QueryNoCompleteMedicineR *)param
                   success:(void (^)(id))success
                   failure:(void (^)(HttpException *))failure;

///api/familyMedicine/completeMemberMedicine 完善用药
+ (void)completeMemberMedicine:(CompleteMemberMedicineR *)param
                        success:(void (^)(id))success
                        failure:(void (^)(HttpException *))failure;


///api/familyMedicine/medicineDetail 查询完善药详情
+ (void)medicineDetail:(MedicineDetailR *)param
                       success:(void (^)(id))success
                       failure:(void (^)(HttpException *))failure;


///api/familyMedicine/addMemberMedicine 添加用药
+ (void)addMemberMedicine:(AddMemberMedicineR *)param
               success:(void (^)(id))success
               failure:(void (^)(HttpException *))failure;

///api/familyMedicine/searchByTag 根据tag搜索家庭成员用药
+ (void)searchByTag:(SearchByTagR *)param
                  success:(void (^)(id))success
                  failure:(void (^)(HttpException *))failure;


///api/familyMedicine/byKeyword 根据关键字查询我的用药

+ (void)byKeyword:(ByKeywordR *)param
            success:(void (^)(id))success
            failure:(void (^)(HttpException *))failure;

///api/familyMedicine/queryTags 查询家庭成员的所有标签

+ (void)queryTags:(QueryTagsR *)param
          success:(void (^)(id))success
          failure:(void (^)(HttpException *))failure;

///api/familyMedicine/updateTag 标记药效

+ (void)updateTag:(UpdateTagR *)param
          success:(void (^)(id))success
          failure:(void (^)(HttpException *))failure;

// /api/familyMedicine/deleteMemberMedicine 删除用药
+ (void)deleteMemberMedicine:(DeleteMemberMedicineR *)param
          success:(void (^)(id))success
          failure:(void (^)(HttpException *))failure;
@end
