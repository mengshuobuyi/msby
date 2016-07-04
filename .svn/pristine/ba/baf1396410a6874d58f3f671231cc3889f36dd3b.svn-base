//
//  DrugModelR.h
//  APP
//
//  Created by Meng on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface DrugModelR : BaseModel


@end
//健康指标------------
@interface HealthyScenarioModelR : BaseModel

@property (nonatomic) NSString *currClassId;
@property (nonatomic) NSString *currPage;
@property (nonatomic) NSString *pageSize;

@end


@interface HealthyScenarioDiseaseModelR : BaseModel

@property (nonatomic) NSString *classId;
@property (nonatomic) NSString *currPage;
@property (nonatomic) NSString *pageSize;

@end


@interface HealthyScenarioDrugModelR : BaseModel

@property (nonatomic) NSString  *classId;
@property (nonatomic) NSNumber *currPage;
@property (nonatomic) NSNumber *pageSize;

@property (nonatomic) NSString  *province;
@property (nonatomic) NSString  *city;
@property (nonatomic) NSString  *v;

@end
//-----------------------


//药品------------
@interface QueryProductFirstModelR : BaseModel

@property (nonatomic ,strong) NSString *currPage;
@property (nonatomic ,strong) NSString *pageSize;

@end



@interface QueryProductSecondModelR : BaseModel

@property (nonatomic ,strong) NSString *currClassId;

@end

@interface QueryProductByClassModelR : BaseModel

@property (nonatomic ,strong) NSString *classId;
@property (nonatomic ,strong) NSString *factory;
@property (nonatomic ,strong) NSNumber *currPage;
@property (nonatomic ,strong) NSNumber *pageSize;

@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *v;

@end

@interface FetchProFactoryByClassModelR : BaseModel

@property (nonatomic ,strong) NSString *classId;
@property (nonatomic ,strong) NSNumber *currPage;
@property (nonatomic ,strong) NSNumber *pageSize;

@end
@interface DrugDetailModelR : BaseModel

@property (nonatomic ,strong) NSString *proId;

@end


//3.3.40	根据关键字ID获取商品列表
@interface productBykwIdR : BaseModel
@property (nonatomic,strong)NSString *kwId;
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic,strong)NSString *type;
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *v;
@end
@interface GetSearchKeywordsR : BaseModel
@property (nonatomic,strong)NSString *keyword;
@property (nonatomic,strong)NSString *type;//（0:商品, 1:疾病, 2:症状）
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;
@end

//疾病组方的请求商品的参数
@interface DiseaseFormulaPruductR : BaseModel
@property (nonatomic,strong)NSString *diseaseId;//疾病ID，字符串，必填项
@property (nonatomic,strong)NSString *formulaId;//组方配方ID，字符串，必填项
@property (nonatomic,strong)NSString *currPage;//
@property (nonatomic,strong)NSString *pageSize;

@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *v;

@end

//3.3.19	疾病（治疗用药）
@interface DiseaseProductListR : DrugModelR
@property (nonatomic,strong)NSString *diseaseId;//所属疾病Id，字符串，必填项
@property (nonatomic,strong)NSString *type;//疾病关联类型，字符串，必填项（1:治疗用药, 2:保健食品, 3:医疗用品）
@property (nonatomic,strong)NSString *currPage;//当前页数（分页使用）整型
@property (nonatomic,strong)NSString *pageSize;//每页显示数据条数（分页使用，不使用分页时候可以传入0）整型

@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *v;

@end

//-------------------------

//************其他人的接口********************************
//我的用药
@interface QueryProductByKeywordModelR : BaseModel

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *type;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;

@end

//我的商品的获取用法用量
@interface GetProductUsageModelR : BaseModel

@property (nonatomic, strong) NSString *proId;

@end
//畅销商品
@interface SellWellProductsR : DrugModelR

@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSNumber *currPage;
@property (nonatomic ,strong) NSNumber *pageSize;

@end

//************************************************************



@interface SimilarDrugsR : DrugModelR

@property (nonatomic ,strong) NSString *proId;
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *currPage;
@property (nonatomic ,strong) NSString *pageSize;
@end

@interface DrugSearchModelR: DrugModelR

@property (nonatomic ,strong) NSString *keyword;//搜索关键字
@property (nonatomic ,strong) NSString *type;//关联类型(0:商品, 1:疾病, 2:症状 )
@property (nonatomic ,strong) NSNumber *currPage;
@property (nonatomic ,strong) NSNumber *pageSize;

@end

