//
//  ReceiveAddress.h
//  APP
//
//  Created by qw_imac on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseModel.h"

//*******
//   3.0
//*******
//收货地址
@interface ReceiveAddress : BaseModel
@property (nonatomic,strong) NSArray *address;

@end

@interface AddressVo : BaseModel
@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSString *id; //收货地址id
@property (nonatomic,strong) NSString *cityName;//城市
@property (nonatomic,strong) NSString *countyName;//区县
@property (nonatomic,strong) NSString *village;//小区,
@property (nonatomic,strong) NSString *address;//详细地址
@property (nonatomic,strong) NSString *mobile;//电话
@property (nonatomic,strong) NSString *sex;//性别 m男 n女
@property (nonatomic,strong) NSString *nick;//名称
@property (nonatomic,strong) NSString *lng;//经度
@property (nonatomic,strong) NSString *lat;//纬度
@property (nonatomic,strong) NSString *flagDefault;// 默认地址：Y/N
@end


//修改或添加地址
@interface UpdateAddress : BaseModel
@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@end

//删除地址
@interface DeleteAddress : BaseModel
@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@end