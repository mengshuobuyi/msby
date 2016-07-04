//
//  DiseaseModelR.h
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface DiseaseModelR : BaseModel

@end
//疾病模块---------------------------------------------------------------------------------------------------------
@interface DiseaseClassModelR : BaseModel

@property (strong, nonatomic) NSString          *currPage;
@property (strong, nonatomic) NSString          *pageSize;

@end

@interface DiseaseViKiModelR : BaseModel

@property (strong, nonatomic) NSString          *currPage;
@property (strong, nonatomic) NSString          *pageSize;

@end


//搜索疾病时的请求参数
@interface DiseasekwidR : BaseModel
@property (nonatomic,strong)NSString *kwId;
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic, strong) NSString *type;

@end
//疾病的详情的请求参数
@interface DiseaseDetailIosR : BaseModel
@property (nonatomic,strong)NSString *diseaseId;

@end

//症状关联的可能的疾病
@interface PossibleDiseaseR : DiseaseModelR

@property (nonatomic,strong)NSString *spmCode;
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;
@end

//------------------------------------------------------------------------------------------------------------------------------









