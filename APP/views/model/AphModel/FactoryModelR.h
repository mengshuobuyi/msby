//
//  FactoryModelR.h
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//


#import "BaseModel.h"

@interface FactoryModelR : BaseModel

@property (nonatomic) NSString *currPage;//当前页数（分页使用）
@property (nonatomic) NSString *pageSize;//每页显示数据条数（分页使用，不使用分页时候可以传入0）

@end

@interface FactoryProductListModelR : BaseModel

@property (nonatomic) NSString *factoryCode;
@property (nonatomic) NSString *v;
@property (nonatomic) NSString *currPage;//当前页数（分页使用）
@property (nonatomic) NSString *pageSize;//每页显示数据条数（分页使用，不使用分页时候可以传入0）

@end


@interface FactoryDetailModelR : BaseModel

@property (nonatomic) NSString *factoryCode;//生产厂家编号


@end