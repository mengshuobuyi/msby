//
//  OperateModelR.h
//  APP
//
//  Created by PerryChen on 10/13/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "BaseModel.h"

@interface OperateModelR : BaseModel
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *type;         
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *deviceCode;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) NSInteger userType;

@end
