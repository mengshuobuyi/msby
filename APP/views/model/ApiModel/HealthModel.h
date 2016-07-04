//
//  HealthModel.h
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"


@interface HealthModel : BaseAPIModel

@property (nonatomic) NSArray *list;

@property (nonatomic,strong) NSString *normId;

@end


@interface HealthProgramModel : BaseModel

@property (nonatomic) NSString *healthId;         //健康项ID
@property (nonatomic) NSString *name;       //健康项名称
@property (nonatomic) NSString *url;       //明细地址

@end