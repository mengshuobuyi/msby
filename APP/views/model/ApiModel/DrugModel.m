//
//  drug.m
//  APP
//
//  Created by carret on 15/3/3.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DrugModel.h"
@implementation DrugModel
+(NSString *)getPrimaryKey{
    
    return @"medcineSubId";
}
@end
//健康方案
@implementation HealthyScenarioModel
@synthesize id;
@synthesize name;
@synthesize desc;
@synthesize imgPath;
@synthesize elementId;
@end

@implementation HealthyScenarioListModel

+ (NSString *)getPrimaryKey
{
    return @"scenarioId";
}

@end

@implementation HealthyScenarioDiseaseModel
@synthesize question;
@synthesize answer;
@end

@implementation HealthyScenarioDrugModel


+(NSString *)getPrimaryKey{
    
    return @"proIdSceno";
}

@end
//-----------------


//药品
@implementation QueryProductClassModel

+(NSString *)getPrimaryKey{
    
    return @"medcineId";
}

@end
@implementation QueryProductFirstModel

@end
@implementation QueryProductSecondModel

@end
@implementation QueryProductByClassItemModel

+(NSString *)getPrimaryKey{
    
    return @"proId";
}

@end

@implementation FetchProFactoryByClassModel

@synthesize factory;

@end

@implementation DrugDetailUseModel


@end

@implementation DrugDetailModel


@end

//------------


//搜索----
@implementation GetSearchKeywordsModel


@end
@implementation GetSearchKeywordsclassModel


@end

@implementation productclassBykwId


@end

@implementation DiseaseFormulaPruduct

@end

@implementation DiseaseFormulaPruductclass


@end
//-------------------------------------------------------------------------------------


//其他人用到的模块的接口************************************************************
@implementation QueryProductByKeywordModel


@end

@implementation ProductModel

@synthesize factory;
@synthesize proId;
@synthesize proName;
@synthesize spec;

@end

@implementation ProductUsage

@synthesize dayPerCount;
@synthesize drugTag;
@synthesize perCount;
@synthesize unit;
@synthesize useMethod;
@end

@implementation DrugSellWellProductsModel

@end

@implementation DrugSellWellProductsFactoryModel


@end

@implementation DrugScanModel

@end
//******************************************************************************



@implementation SimpleProductWithPromotionVOModel

@end
@implementation SimilarDrugsModel

@end


 