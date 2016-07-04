//
//  ConsultDoctorModelR.h
//  APP
//
//  Created by caojing on 15/5/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface ConsultDoctorModelR : BaseModel

@end

@interface ConsultDocModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrls;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *branchId;
@end
