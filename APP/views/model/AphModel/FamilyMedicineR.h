//
//  FamilyMedicineR.h
//  APP
//
//  Created by carret on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface FamilyMedicineR : BaseModel

@end

@interface AddFamilyMemberR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *slowId;
@property (nonatomic,strong) NSString *slowIds;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *unit;//年龄的单位
@property (nonatomic,strong) NSString *allergy;//是否有药物过敏史(1:有，2:无)
@property (nonatomic,strong) NSString *pregnancy;//是否怀孕(1:有，2:无)
@end

@interface GetMemberInfoR : BaseModel
@property (nonatomic,strong) NSString *memberId;


@end

@interface AnalystByMemberModelR : BaseModel
@property (nonatomic,strong) NSString *token;


@end

@interface AnalystByTypeModelR : BaseModel
@property (nonatomic,strong) NSString *token;


@end

@interface QueryAllMedicineR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSString *pageSize;
@end



@interface QueryFamilyMembersR : BaseModel
@property (nonatomic,strong) NSString *token;

@end



@interface QueryMemberSlowDiseaseR : BaseModel
@property (nonatomic,strong) NSString *memberId;


@end



@interface UpdateFamilyMemberR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *slowId;
@property (nonatomic, strong) NSString *slowIds;    // 选择的慢病列表
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *unit;//年龄的单位
@property (nonatomic,strong) NSString *allergy;//是否有药物过敏史(1:有，2:无)
@property (nonatomic,strong) NSString *pregnancy;//是否怀孕(1:有，2:无)
@property (nonatomic,strong) NSString *job;//是否怀孕(1:有，2:无)
@end

@interface UpdateMemberSlowDiseaseR : BaseModel
@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *slowId;

@end



@interface UpdateUseOrResultR : BaseModel
@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *proId;
@property (nonatomic,strong) NSString *perCount;
@property (nonatomic,strong) NSString *unit;//年龄的单位
@property (nonatomic,strong) NSString *intervalDay;//是否有药物过敏史(1:有，2:无)
@property (nonatomic,strong) NSString *drugTime;//次数
@property (nonatomic,strong) NSString *effect;//药效
@end


@interface UpdateUsePeopleR : BaseModel
@property (nonatomic,strong) NSString *medicineId;
@property (nonatomic,strong) NSString *usePeopleIds;

@end


 

@interface QueryMemberMedicinesR : BaseModel

@property (nonatomic,strong) NSString *memberId;

@end


@interface DeleteFamilyMemberR : BaseModel
@property (nonatomic,strong) NSString *memberId;


@end
///api/familyMedicine/queryNoCompleteMedicine 查询待完善的用药列表
@interface QueryNoCompleteMedicineR : BaseModel
@property (nonatomic,strong) NSString *token;

@end

/////api/familyMedicine/completeMemberMedicine 完善用药
@interface CompleteMemberMedicineR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *boId;
@property (nonatomic,strong) NSString *proId;
@property (nonatomic,strong) NSString *perCount;//单次用量
@property (nonatomic,strong) NSString *proName;//商品名称
@property (nonatomic,strong) NSString *intervalDay;//是否有药物过敏史(1:有，2:无)
@property (nonatomic,strong) NSString *drugTime;//次数
@property (nonatomic,strong) NSString *unit;//单次单位
@property (nonatomic,strong) NSString *useMethod;//服用方法
@property (nonatomic,strong) NSString *memberIds;//使用者字符串，分隔符老规矩
@end

/////api/familyMedicine/medicineDetail 查询完善药详情

@interface MedicineDetailR : BaseModel
@property (nonatomic,strong) NSString *boId;

@end



@interface AddMemberMedicineR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *proId;
@property (nonatomic,strong) NSString *perCount;//单次用量
@property (nonatomic,strong) NSString *proName;//商品名称
@property (nonatomic,strong) NSString *intervalDay;//是否有药物过敏史(1:有，2:无)
@property (nonatomic,strong) NSString *drugTime;//次数
@property (nonatomic,strong) NSString *unit;//单次单位
@property (nonatomic,strong) NSString *useMethod;//服用方法

@end

@interface SearchByTagR : BaseModel
@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *tag;
@end

@interface  ByKeywordR: BaseModel
@property (nonatomic,strong) NSString *memberId;
@property (nonatomic,strong) NSString *keyword;
@end

@interface QueryTagsR : BaseModel
@property (nonatomic,strong) NSString *memberId;
@end

@interface UpdateTagR : BaseModel
@property (nonatomic,strong) NSString *boxId;
@property (nonatomic,strong) NSString *tag;
@end

@interface DeleteMemberMedicineR : BaseModel
@property (nonatomic,strong) NSString *boId;
@end