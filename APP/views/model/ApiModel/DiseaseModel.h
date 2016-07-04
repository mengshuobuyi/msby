//
//  DiseaseModel.h
//  APP
//
//  Created by carret on 15/3/3.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface DiseaseModel : BaseAPIModel

@end

//疾病搜索--------------------------------------------------------------------------------------------
@interface Diseasekwid : BaseAPIModel
@property (strong, nonatomic) NSString          *page;
@property (strong, nonatomic) NSString          *pageSize;
@property (strong, nonatomic) NSString          *pageSum;
@property (strong, nonatomic) NSString          *totalRecords;
@property (strong, nonatomic) NSArray           *list;
@end


@interface Diseaseclasskwid : BaseModel
@property (strong,nonatomic) NSString *diseaseId;//疾病ID
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *nodeDesc;
@property (strong,nonatomic) NSString *sortNo;
@property (strong,nonatomic) NSString *type;

@end


//疾病分类（疾病的第一步）

@interface DiseaseClassModel : DiseaseModel

@property (nonatomic ,strong) NSArray *list;

@end

@interface DiseaseClassListModel : BaseModel

@property (strong, nonatomic) NSString          *classId;           //分类ID
@property (strong, nonatomic) NSString          *name;              //分类名称
@property (nonatomic ,strong) NSString          *isFinalNode;
@property (nonatomic ,strong) NSString *imgUrl;
@property (strong, nonatomic) NSArray           *subClass;          //疾病分类下的疾病 jsonArray格式
@end

//疾病下的疾病分类（子分类2）
@interface DiseaseSubClassModel : BaseModel

@property (strong, nonatomic) NSString          *name;         //分类描述
@property (strong, nonatomic) NSString          *diseaseId;         //疾病ID
@property (strong, nonatomic) NSString          *type;              //疾病名称

@end

//症状关联的疾病
@interface PossibleDiseasePage : BaseAPIModel
@property (strong,nonatomic) NSString *page;
@property (strong,nonatomic) NSString *pageSize;
@property (strong,nonatomic) NSString *pageSum;
@property (strong,nonatomic) NSString *totalRecords;
@property (strong,nonatomic) NSArray  *list;
@end

@interface PossibleDisease : BaseModel
@property (strong,nonatomic) NSString *diseaseId;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *desc;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *sortNo;
@end


//--------------------------------------------------------------------------------------------












//@interface DiseaseSpmbykwid : BaseAPIModel
//@property (strong, nonatomic) NSString          *page;
//@property (strong, nonatomic) NSString          *pageSize;
//@property (strong, nonatomic) NSString          *pageSum;
//@property (strong, nonatomic) NSString          *totalRecords;
//@property (strong, nonatomic) NSArray           *list;
//@end
//疾病百科 按字母芬类
//@interface DiseaseViKiModel : BaseAPIModel
//@property (strong, nonatomic) NSString          *charKey;
//@property (strong, nonatomic) NSArray           *charValue;
//@end
//@interface DiseaseDetailIos : BaseAPIModel
//@property (nonatomic,strong)NSString *diseaseId;
//@property (nonatomic,strong)NSString *name;
//@property (nonatomic,strong)NSString *desc;
//@property (nonatomic,strong)NSString *relatedSymption;
//@property (nonatomic,strong)NSString *relatedDisease;
//@property (nonatomic,strong)NSString *hiddenSymption;
//@property (nonatomic,strong)NSString *hiddenDisease;
//@property (nonatomic,strong)NSString *diseaseTraitTitle;
//@property (nonatomic,strong)NSString *diseaseTraitContent;
//@property (nonatomic,strong)NSString *similarDiseaseTitle;
//@property (nonatomic,strong)NSString *similarDiseaseContent;
//@property (nonatomic,strong)NSString *treatRuleTitle;
//@property (nonatomic,strong)NSString *treatRuleContent;
//@property (nonatomic,strong)NSString *goodHabitTitle;
//@property (nonatomic,strong)NSString *goodHabitContent;
//@property (nonatomic,strong)NSString *diseaseCauseTitle;
//@property (nonatomic,strong)NSString *diseaseCauseContent;
//
//@property (nonatomic,strong)NSString *preventContent;
//@property (nonatomic,strong)NSString *diseaseSummarize;
//@property (nonatomic,strong)NSArray  *formulaList;
//@property (nonatomic,strong)NSArray  *formulaDetail;
//
//@end
////疾病百科
//@interface DiseaseViKiPage : BaseAPIModel
//@property (strong, nonatomic) NSString          *currPage;
//@property (strong, nonatomic) NSString          *pageSize;
//@property (strong, nonatomic) NSString          *totalPage;
//@property (strong, nonatomic) NSString          *totalRecord;
//@property (strong, nonatomic) NSArray           *data;
//@end
//
////疾病百科 疾病名
//@interface DiseaseViKiSubModel : BaseAPIModel
//@property (strong, nonatomic) NSString          *diseaseId;        //疾病ID  字符
//@property (strong, nonatomic) NSString          *name;             //疾病名称
//@property (strong, nonatomic) NSString          *type;             //疾病类别  A:类别A   B:类别B   C:类别C
//@end




