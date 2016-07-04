//
//  SpmModelR.h
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface SpmModelR : BaseModel

@end

//搜索症状时的请求参数
@interface DiseaseSpmbykwidR : BaseModel

@property (nonatomic,strong)NSString *kwId;
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic, strong) NSString  *type;

@end

//症状百科
@interface SpmListModelR : BaseModel

@property (strong, nonatomic) NSString *currPage;
@property (strong, nonatomic) NSString *pageSize;

@end
//根据部位查询相关症状
@interface SpmListByBodyModelR : BaseModel

@property (strong, nonatomic) NSString      *currPage;
@property (strong, nonatomic) NSString      *pageSize;
@property (strong, nonatomic) NSString      *bodyCode;           //部位编码
@property (strong, nonatomic) NSString      *population;         //人群  0：全部  1：成人  2：儿童  字符
@property (strong, nonatomic) NSString      *position;
@property (strong, nonatomic) NSString      *sex;                //性别  0：全部  1：男 2：女 字符

@end
//头部的请求参数
@interface SpmBodyHeadModelR : BaseModel

@property (strong, nonatomic) NSString      *sex;
@property (strong, nonatomic) NSString      *population;
@property (strong, nonatomic) NSString      *position;
@property (strong, nonatomic) NSString      *bodyCode;

@end

//3.3.35	症状明细
@interface spminfoDetailR : BaseModel
@property (nonatomic,strong)NSString *spmCode;
@end
