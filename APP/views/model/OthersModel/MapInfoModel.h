//
//  MapInfoModel.h
//  APP
//
//  Created by garfield on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"
#import <CoreLocation/CLLocation.h>
#import "ConsultStoreModel.h"

@interface MapInfoModel : BaseModel

@property (nonatomic, strong) NSString *formattedAddress; // 格式化地址
@property (nonatomic, strong) NSString *province; // 省
@property (nonatomic, strong) NSString *city; // 市
@property (nonatomic,strong) NSString *village;//小区
@property (nonatomic, strong) CLLocation  *location;    //定位得出的经纬度
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, assign) NSInteger status;//1城市未开通服务 2城市未开通微商 3城市开通微商
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) BOOL      manual;

@property (nonatomic, strong) NSString *name;   //联系人姓名
@property (nonatomic, strong) NSString *tel;    //手机号码
@property (nonatomic, strong) NSString *id;//地址id
@property (nonatomic, assign) NSInteger  locationStatus;
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *branchCityName;
@property (nonatomic, strong) NSString *branchName;
@property (nonatomic, strong) NSString *branchLat;
@property (nonatomic, strong) NSString *branchLon;
@property (nonatomic, strong) NSString *groupId;       //所属商家id,
@property (nonatomic, strong) NSString *logo;       //药房logo
@property (nonatomic, strong) NSString *teamId;     //所属商家圈id,


- (BOOL)isEqualTo:(MapInfoModel *)mapInfo;


@end
