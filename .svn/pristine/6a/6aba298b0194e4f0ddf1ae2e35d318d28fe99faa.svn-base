//
//  FamilyMemberInfoViewController.h
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineR.h"
#import "FamilyMedicineModel.h"
// 跳转该页面的类型
typedef NS_ENUM(NSInteger, MemberViewType) {
    MemberViewTypeAdd,          // 添加成员的页面类型
    MemberViewTypeEdit,         // 编辑成员的页面类型
    MemberViewTypeComplete      // 完善资料的页面类型
};

@interface FamilyMemberInfoViewController : QWBaseVC
{
    
}
@property (nonatomic, assign) MemberViewType enumTypeEdit;      // 跳转该页面的类型
//@property (nonatomic, strong) FamilyMembersVo *modelMember;
@property (nonatomic, strong) NSString *strMemID;           // 成员id
@property (nonatomic, assign) BOOL isUserSelf;              // 是用户自己
@property (nonatomic, assign) BOOL isFromConsultDoctor; // 从免费问药进来
@property (nonatomic, strong) NSString *strConsultTitle;    // 咨询的标题
@property (nonatomic, strong) NSArray *arrPhotos;           // 咨询的图片
//MARK: prepare for future
@property (nonatomic, assign) BOOL isLoadFromLocal;         // 未用

@end
