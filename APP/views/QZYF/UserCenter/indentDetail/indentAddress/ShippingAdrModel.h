//
//  ShippingAdrModel.h
//  APP
//
//  Created by PerryChen on 1/18/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "BaseModel.h"

@interface ShippingAdrModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *addressDetail;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *longitude;//经度
@property (nonatomic, strong) NSString *latitude;//纬度
@end
