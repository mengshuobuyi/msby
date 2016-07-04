//
//  ConfigInfoModelR.h
//  APP
//
//  Created by garfield on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ConfigInfoModelR : BaseModel

@end

@interface ConfigInfoQueryTemplateModelR : BaseModel

@property (nonatomic, strong) NSString    *province;
@property (nonatomic, strong) NSString    *city;
@property (nonatomic, assign) NSInteger    pos;

@end


@interface ConfigInfoQueryModelR : BaseModel

@property (nonatomic, strong) NSString    *province;
@property (nonatomic, strong) NSString    *city;
@property (nonatomic, strong) NSString    *branchId;
@property (nonatomic, strong) NSString    *place;
@property (nonatomic, assign) NSInteger   deviceType;
@property (nonatomic, assign) NSInteger    platform;
@property (nonatomic, assign) NSInteger    pos;
@property (nonatomic, strong) NSString    *channelId;
@property (nonatomic, strong) NSString    *v;
@property (nonatomic, strong) NSString    *source;

@end

@interface ConfigInfoQueryBannerModelR : BaseModel

@property (nonatomic, strong) NSString    *province;
@property (nonatomic, strong) NSString    *city;
@property (nonatomic, strong) NSString    *place;

@end

@interface ConfigInfoSearchWordModelR : BaseModel

@property (nonatomic, strong) NSString    *province;
@property (nonatomic, strong) NSString    *city;

@end