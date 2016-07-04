//
//  FamilyMedicineModel.h
//  APP
//
//  Created by carret on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"
#import "BaseAPIModel.h"
@interface FamilyMedicineModel : BaseModel

@end
 

@interface FamilyMemberDetailVo : BaseAPIModel
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSArray *slowDiseases;
@property (nonatomic, strong) NSString *allergy;
@property (nonatomic, strong) NSString *pregnancy;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *unit;
@end

@interface ChronicDiseaseUserVoModel : BaseAPIModel

@property (nonatomic, strong) NSString *isChronicDiseaseUser;

@end

@interface AnalystByTypeList : BaseAPIModel

@property (nonatomic, strong) NSArray   *list;

@end

@interface AnalystByMemberList : BaseAPIModel

@property (nonatomic, strong) NSArray   *list;

@end

@interface AnalystByTypeVOModel : BaseModel

@property (nonatomic, strong) NSString   *medicineType;
@property (nonatomic, strong) NSString   *amount;

@end

@interface AnalystByMemberVOModel : BaseModel

@property (nonatomic, strong) NSString   *name;
@property (nonatomic, strong) NSString   *amount;

@end



@interface BoxMedicine : BaseModel
@property (nonatomic, strong) NSString *medicineId;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *spec;//gui ge
@property (nonatomic, strong) NSString *usePeople;// 使用人

@end

@interface FamilyMembersVo : BaseModel
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *drugCount;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSArray *slowDiseases;
@property (nonatomic, strong) NSString *allergy;
@property (nonatomic, strong) NSString *pregnant;
@property (nonatomic, strong) NSString *isComplete;
@property (nonatomic, strong) NSString *isSelf;
@property (nonatomic, strong) NSString *unit;
@end

@interface QueryFamilyMembersModel : BaseAPIModel
@property (nonatomic, strong) NSArray *list;//用药id,
@end
@interface MemberMedicineVo : BaseModel
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *usePeople;
@property (nonatomic, strong) NSString *useMethodAndCount;
@end

@interface MemberMedicineVoModel : BaseAPIModel
@property (nonatomic, strong) NSArray *list;//用药id,
@end
/////api/familyMedicine/queryNoCompleteMedicine 查询待完善的用药列表
@interface MemberMedicine : BaseModel
@property (nonatomic, strong) NSString *boId;//用药id,
@property (nonatomic, strong) NSString *proId;//商品id,
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *medicineTag;//标签,
@property (nonatomic, strong) NSString *useMethod;//  服用方法,

@property (nonatomic, strong) NSString *perCount;//单次用量,
@property (nonatomic, strong) NSString *unit;//单次单位,
@property (nonatomic, strong) NSString *intervalDays;//间隔天数,
@property (nonatomic, strong) NSString *drugTime;// 次数,
@property (nonatomic, strong) NSString *effect;//  药效,
@property (nonatomic, strong) NSString *spec;// 规格,
@property (nonatomic, strong) NSString *imgUrl;// 头像地址
@end

@interface SlowDiseaseVoList : BaseModel
@property (nonatomic, strong) NSArray *list;
@end

@interface SlowDiseaseVo : BaseAPIModel
@property (nonatomic, strong) NSString *slowId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isFocus;

@end

@interface QueryNoCompleteMedicineModel : BaseAPIModel
@property (nonatomic, strong) NSArray *list;//用药id,
@end
/////api/familyMedicine/medicineDetail 查询完善药详情

@interface MedicineDetailModel : BaseModel
@property (nonatomic, strong) NSString *boId;//用药id,
@property (nonatomic, strong) NSString *proId;//商品id,
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *medicineTag;//标签,
@property (nonatomic, strong) NSString *useMethod;//  服用方法,

@property (nonatomic, strong) NSString *perCount;//单次用量,
@property (nonatomic, strong) NSString *unit;//单次单位,
@property (nonatomic, strong) NSString *intervalDays;//间隔天数,
@property (nonatomic, strong) NSString *drugTime;// 次数,
@property (nonatomic, strong) NSString *effect;//  药效,
@property (nonatomic, strong) NSString *spec;// 规格,
@property (nonatomic, strong) NSString *imgUrl;// 头像地址
@property (nonatomic, strong) NSString *nickName;
@end

///api/familyMedicine/addMemberMedicine 添加用药

@interface AddMemberMedicineModel : BaseAPIModel
@end