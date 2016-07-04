//
//  MemberDiseaseListViewController.h
//  APP
//
//  Created by PerryChen on 8/21/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "FamilyMedicineModel.h"

@protocol MemberDiseaseListDelegate <NSObject>

- (void)savedMemberDiseaseList:(NSArray *)arrDisease;

@end

@interface MemberDiseaseListViewController : QWBaseVC
@property (nonatomic, strong) FamilyMemberDetailVo *modelMember;
@property (nonatomic, weak) id<MemberDiseaseListDelegate> diseaseDelegate;
@property (nonatomic, assign) BOOL isEditMode;                  // 是否是编辑状态
@property (nonatomic, strong) NSMutableArray *arrSelected;      // 所选择的慢病接口
@end
