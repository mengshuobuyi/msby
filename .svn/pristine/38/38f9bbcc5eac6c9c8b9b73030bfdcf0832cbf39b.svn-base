//
//  ProblemModelR.h
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

//问题类型
@interface ProblemModuleR : BaseModel
@property (strong, nonatomic) NSString          *moduleId;               //模块Id
@end

//首页问题模块
@interface ProblemHomeModuleR : BaseModel
@end


//常见用药问题列表
@interface ProblemListModelR : BaseModel

@property (strong, nonatomic) NSString          *classId;               //类型Id
@property (strong, nonatomic) NSString          *currPage;              //查询当前页码  选填  默认1
@property (strong, nonatomic) NSString          *pageSize;              //查询数  选填  默认10

@end

//问题详情
@interface ProblemDetailModelR : BaseModel

@property (strong, nonatomic) NSString          *classId;              //类型 id 字符串 必填
@property (strong, nonatomic) NSString          *teamId;               //问题组 id 字符串 必填
@property (strong, nonatomic) NSString          *currPage;             //查询当前页码  选填  默认1
@property (strong, nonatomic) NSString          *pageSize;             //查询数 选填 默认 10

@end
//3.3.36	获取症状关联的疾病
@interface spmAssociationDiseaseR : BaseModel
@property (nonatomic,strong)NSString *spmCode;
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;

@end
