//
//  drug.h
//  APP
//
//  Created by carret on 15/3/3.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface DrugModel : BaseAPIModel
@property (nonatomic,strong) NSArray  *list;

@property (nonatomic,strong) NSString *medcineSubId;
@end
//健康方案
@interface HealthyScenarioListModel : BaseAPIModel

@property (nonatomic) NSString *page;
@property (nonatomic) NSArray  *list;
@property (nonatomic) NSString *pageSize;
@property (nonatomic) NSString *pageSum;
@property (nonatomic) NSString *totalRecords;

@property (nonatomic,strong) NSString *scenarioId;


@end

@interface HealthyScenarioModel : BaseModel

@property (nonatomic) NSString *id;         //编号
@property (nonatomic) NSString *name;       //分类名称
@property (nonatomic) NSString *desc;       //分类描述
@property (nonatomic) NSString *imgPath;	//图片路径
@property (nonatomic) NSString *elementId;	//成分编码



@end

@interface HealthyScenarioDiseaseModel : BaseModel
@property (nonatomic) NSString *question;       //问题
@property (nonatomic) NSString *answer;       //答案
@end

@interface HealthyScenarioDrugModel : BaseModel

@property (nonatomic,strong) NSString *proId;         //商品ID
@property (nonatomic,strong) NSString *id;       //商品编码
@property (nonatomic,strong) NSString *proName;       //全维商品过程
@property (nonatomic,strong) NSString *factory;         //生产厂家
@property (nonatomic,strong) NSString *spec;       //规格
@property (nonatomic,strong) NSString *promotionType;	//优惠标注
@property (nonatomic,strong) NSString *promotionId;     //优惠id
@property (nonatomic,strong) NSString *classId;	//优惠标注

@property (nonatomic,strong) NSString *proIdSceno;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

@property (nonatomic,assign) BOOL gift;
@property (nonatomic,assign) BOOL discount;
@property (nonatomic,assign) BOOL voucher;
@property (nonatomic,assign) BOOL special;
@property (nonatomic,strong) NSString *label;

@end
//-----------

//商品一级列表

@interface QueryProductClassModel : BaseAPIModel
@property (nonatomic,strong) NSString *page;
@property (nonatomic,strong) NSArray  *list;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *pageSum;
@property (nonatomic,strong) NSString *totalRecords;


@property (nonatomic,strong) NSString *medcineId;
@end

@interface QueryProductFirstModel : BaseModel

@property (nonatomic,strong) NSString *classDesc;
@property (nonatomic,strong) NSString *classId;
@property (nonatomic,strong) NSString *name;

@end

@interface QueryProductSecondModel : BaseModel

@property (nonatomic,strong) NSString *classDesc;
@property (nonatomic,strong) NSString *classId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *size;
@property (nonatomic,strong) NSString *isFinalNode;
@property (nonatomic,strong) NSArray  *children;

@end

@interface QueryProductByClassItemModel : DrugModel

@property (nonatomic ,strong) NSString *price;
@property (nonatomic ,strong) NSString *proId;
@property (nonatomic ,strong) NSString *proName;
@property (nonatomic ,strong) NSString *registerNo;
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *spec;
@property (nonatomic ,strong) NSString *factory;
@property (nonatomic ,strong) NSString *promotionType;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

@property (nonatomic,strong) NSString *classId;

@property (nonatomic,assign) BOOL gift;
@property (nonatomic,assign) BOOL discount;
@property (nonatomic,assign) BOOL voucher;
@property (nonatomic,assign) BOOL special;
@property (nonatomic,strong) NSString *label;

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *promotionId;
@property (nonatomic,strong)NSString *multiPromotion;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *startDate;
@property (nonatomic,strong)NSString *endDate;
@property (nonatomic,strong)NSString *source;

@end

@interface FetchProFactoryByClassModel : BaseAPIModel

@property (nonatomic ,strong) NSString *factory;

@end

@interface DrugDetailModel : BaseAPIModel
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *shortName;
@property (nonatomic ,strong) NSString *spec;
@property (nonatomic ,strong) NSString *registerNo;
@property (nonatomic ,strong) NSString *unit;
@property (nonatomic ,strong) NSString *signCode;
@property (nonatomic ,strong) NSString *factoryCode;
@property (nonatomic ,strong) NSString *factory;
@property (nonatomic ,strong) NSString *factoryAuth;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *isContainEphedrine;
@property (nonatomic ,strong) NSArray  *useNotice;
@property (nonatomic ,strong) NSString *knowledgeTitle;
@property (nonatomic ,strong) NSString *knowledgeContent;
@property (nonatomic, strong) NSString *promotionId;
@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

@end

@interface DrugDetailUseModel : BaseAPIModel
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *content;
@end

//--------------


//--------搜索的商品-----
@interface GetSearchKeywordsModel : BaseAPIModel
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic,strong)NSString *pageSum;
@property (nonatomic,strong)NSString *totalRecords;
@property (nonatomic,strong)NSArray  *list;
@end

@interface GetSearchKeywordsclassModel : DrugModel
@property(nonatomic,strong)NSString *gswId;
@property(nonatomic,strong)NSString *gswCname;
@property(nonatomic,strong)NSString *gswPym;
@end

@interface productclassBykwId : DrugModel

@property (nonatomic,strong)NSString *productId;
@property (nonatomic,strong)NSString *proId;
@property (nonatomic,strong)NSString *proName;
@property (nonatomic,strong)NSString *spec;
@property (nonatomic,strong)NSString *factory;
@property (nonatomic,strong)NSString *imgUrl;//商品图片的地址
@property (nonatomic,strong)NSString *gift;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *voucher;
@property (nonatomic,strong)NSString *special;
@property (nonatomic,strong)NSString *label;
@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *promotionId;
@property (nonatomic,strong)NSString *multiPromotion;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *startDate;
@property (nonatomic,strong)NSString *endDate;
@property (nonatomic,strong)NSString *source;

@property (nonatomic,strong)NSString *makeplace;
@property (nonatomic,strong)NSString *promotionType;

@end

//疾病组方 治疗用药
@interface DiseaseFormulaPruduct : BaseAPIModel
@property (nonatomic,strong)NSString *page;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic,strong)NSString *pageSum;
@property (nonatomic,strong)NSString *totalRecords;
@property (nonatomic,strong)NSArray  *list;
@end

@interface DiseaseFormulaPruductclass : BaseModel
@property (nonatomic,strong)NSString *factory;
@property (nonatomic,strong)NSString *proId;
@property (nonatomic,strong)NSString *proName;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *spec;
@property (nonatomic,strong)NSString *promotionType;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

@property (nonatomic,assign) BOOL gift;
@property (nonatomic,assign) BOOL discount;
@property (nonatomic,assign) BOOL voucher;
@property (nonatomic,assign) BOOL special;
@property (nonatomic,strong)NSString *label;

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *promotionId;
@property (nonatomic,strong)NSString *multiPromotion;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *startDate;
@property (nonatomic,strong)NSString *endDate;
@property (nonatomic,strong)NSString *source;

@end

//----------------------------------------------------------------------------------


//其他人用到的模块的接口****************************************************************************************
//扫码获取商品
@interface ProductModel : BaseAPIModel
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *factory;
@property (nonatomic ,strong) NSString *proId;
@property (nonatomic ,strong) NSString *productId;
@property (nonatomic ,strong) NSString *proName;
@property (nonatomic ,strong) NSString *spec;
@property (nonatomic ,strong) NSString *promotionType;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址


@property (nonatomic,assign)BOOL gift;
@property (nonatomic,assign)BOOL discount;
@property (nonatomic,assign)BOOL voucher;
@property (nonatomic,assign)BOOL special;
@property (nonatomic,strong)NSString *label;

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *promotionId;
@property (nonatomic,strong)NSString *multiPromotion;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *startDate;
@property (nonatomic,strong)NSString *endDate;
@property (nonatomic,strong)NSString *source;

@end
//扫码获取商品的用法用量
@interface ProductUsage : BaseAPIModel
@property (nonatomic ,strong) NSString *dayPerCount;
@property (nonatomic ,strong) NSString *drugTag;
@property (nonatomic ,strong) NSString *perCount;
@property (nonatomic ,strong) NSString *unit;
@property (nonatomic ,strong) NSString *useMethod;
@property (nonatomic ,strong) NSString *drugTime;
@end

//扫码获取药品信息
@interface DrugScanModel : BaseAPIModel
@property (nonatomic, strong) NSArray *list;
@end

//我的用药
@interface QueryProductByKeywordModel : DrugModel

@property (nonatomic,strong)NSString *proId;
@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong)NSString *proName;
@property (nonatomic,strong)NSString *spec;
@property (nonatomic,strong)NSString *factory;
@property (nonatomic, strong) NSString *id;
@property (nonatomic,strong)NSString *price;
@property (nonatomic, strong) NSString *registerNo;
@property (nonatomic, strong) NSString *promotionType;

@property (nonatomic, strong) NSString  *imgUrl;

@end

@interface DrugSellWellProductsModel : BaseAPIModel

@property (nonatomic ,strong) NSString *currPage;
@property (nonatomic ,strong) NSString *pageSize;
@property (nonatomic ,strong) NSString *pageSum;
@property (nonatomic ,strong) NSString *totalRecords;
@property (nonatomic ,strong) NSString *page;
@property (nonatomic ,strong) NSArray  *list;

@end

@interface DrugSellWellProductsFactoryModel :BaseModel

@property (nonatomic ,strong) NSString *factory;
@property (nonatomic ,strong) NSString *proId;
@property (nonatomic ,strong) NSString *proName;
@property (nonatomic ,strong) NSString *spec;
@property (nonatomic ,strong) NSString *tag;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址
@end

//*******************************************************************************************************


@interface SimpleProductWithPromotionVOModel :BaseModel

@property (nonatomic ,strong) NSString *productId;
@property (nonatomic ,strong) NSString *proId;
@property (nonatomic ,strong) NSString *proName;
@property (nonatomic ,strong) NSString *spec;
@property (nonatomic ,strong) NSString *factory;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

@property (nonatomic ,strong) NSString *gift;
@property (nonatomic ,strong) NSString *discount;
@property (nonatomic ,strong) NSString *voucher;
@property (nonatomic ,strong) NSString *special;
@property (nonatomic ,strong) NSString *label;

@property (nonatomic,strong) NSString *desc;//商品图片的地址
@property (nonatomic ,strong) NSString *promotionId;
@property (nonatomic ,strong) NSString *multiPromotion;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *startDate;
@property (nonatomic ,strong) NSString *endDate;
@property (nonatomic ,strong) NSString *source;

@end



@interface SimilarDrugsModel : BaseAPIModel
@property (nonatomic ,strong)NSArray *list;
@end
