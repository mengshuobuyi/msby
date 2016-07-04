//
//  SpmModel.h
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface SpmModel : BaseAPIModel

@end

//获取症状列表page------------------------------------------------------------------------------------
@interface SpmListPage : BaseAPIModel

@property (strong, nonatomic) NSString          *page;
@property (strong, nonatomic) NSString          *pageSize;
@property (strong, nonatomic) NSString          *pageSum;
@property (strong, nonatomic) NSString          *totalRecords;
@property (strong, nonatomic) NSArray           *list;

@end


@interface SpmSearchId : BaseModel
@property (strong,nonatomic) NSString *spmCode;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *liter;
@property (strong,nonatomic) NSString *usual;
@property (strong,nonatomic) NSString *sortNo;
@property (strong,nonatomic) NSString *sex;
@property (strong,nonatomic) NSString *population;

@end


//部位下症状的page
@interface SpmListByBodyPage : BaseAPIModel

@property (strong, nonatomic) NSArray               *list;

@end


//部位头部model
@interface SpmBodyHeadModel : BaseModel

@property (strong, nonatomic) NSString              *bodyCode;              // 部位编码  字符
@property (strong, nonatomic) NSString              *name;                  //部位名称  字符
@property (strong, nonatomic) NSString              *population;            //人群  0:全部1:成人2:儿童  整型数字
@property (strong, nonatomic) NSString              *position;              //正反面 0:全部  1:正面 2:反面  整型数字
@property (strong, nonatomic) NSString              *sex;                   //性别  0:全部 1: 男 2:女  整型数字


@property (strong, nonatomic) NSString              *topKey;
@end


//症状列表model
@interface SpmListModel : BaseModel

@property (strong, nonatomic) NSString              *liter;                  //症状索引字母 字符
@property (strong, nonatomic) NSString              *name;                   //症状名称  字符
@property (strong, nonatomic) NSString              *population;             //人群  0:全部1:成人2:儿童  整型数字
@property (strong, nonatomic) NSString              *sex;                    //性别  0:全部 1: 男 2:女  整型数字
@property (strong, nonatomic) NSString              *sortNo;                 //排序号  整型数字
@property (strong, nonatomic) NSString              *spmCode;                //症状编码  字符
@property (strong, nonatomic) NSString              *usual;                  //是否常见症状 0:否  1:是 整型数字

@property (strong, nonatomic) NSString              *detailSpm;
@property (strong, nonatomic) NSString              *spmCodeSpm;
@end


//3.3.35	症状明细
@interface spminfoDetail : BaseModel
@property (nonatomic,strong)NSString *spmCode;//症状编码 字符
@property (nonatomic,strong)NSString *name;//症状名称 字符
@property (nonatomic,strong)NSString *intro;//症状简介(touch专用) 字符
@property (nonatomic,strong)NSString *desc;//症状描述 字符
@property (nonatomic,strong)NSString *imgUrl;//症状图片url 字符
@property (nonatomic,strong)NSArray  *properties;//症状属性列表 是个jsonArray对象
@property (nonatomic,strong)NSString *title;//属性标题  properties列表字段 字符
@property (nonatomic,strong)NSString *content;//属性内容  properties列表字段 字符
@property (nonatomic,strong)NSString *sex;//性别  0:全部 1: 男 2:女  整型数字
@property (nonatomic,strong)NSString *population;//人群  0:全部1:成人2:儿童  整型数字
@end


@interface spminfoDetailPropertiesModel : BaseModel
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;
@end

//----------------------------------------------------------------------------------------------------------------



