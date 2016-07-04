//
//  FactoryModel.h
//  APP
//
//  Created by caojing on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface FactoryModel : BaseModel

@end


@interface FactoryListModel : BaseAPIModel

@property (nonatomic, strong) NSString *page;
@property (nonatomic) NSArray *list;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageSum;
@property (nonatomic, strong) NSString *totalRecords;

@property (nonatomic, strong) NSString *factoryId;


@end


//厂家详情
@interface FactoryDetailModel : BaseAPIModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *auth;

@end

@interface FactoryInfoModel: BaseAPIModel

@property (strong, nonatomic) FactoryDetailModel *FactoryInfo;

@end






/**厂家商品列表
 json返回参数	描述
 proId	产品编码
 proName	产品名称
 spec	产品规格
 factoryName	厂家名称
 */
@interface FactoryProductList : BaseAPIModel
@property (nonatomic, strong) NSString *page;
@property (nonatomic) NSArray *list;
@property (nonatomic, strong) NSString *pageSum;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *totalRecords;

@end



@interface FactoryProduct  : BaseModel

@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *factory;
@property (nonatomic, strong) NSString *promotionType;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址

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

@end








