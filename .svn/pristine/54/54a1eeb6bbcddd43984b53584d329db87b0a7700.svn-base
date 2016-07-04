//
//  ReceiveAddressR.h
//  APP
//
//  Created by qw_imac on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseModel.h"
//收货地址
@interface ReceiveAddressR : BaseModel
@property (nonatomic,strong) NSString *token;
@end
//修改和保存地址
@interface UpdateAddressR : BaseModel
@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *id;   //收货地址id optional
@property (nonatomic,strong)NSString *city; //城市名
@property (nonatomic,strong)NSString *county;//区/县名
@property (nonatomic,strong)NSString *village;//小区
@property (nonatomic,strong)NSString *address;//详细地址
@property (nonatomic,strong)NSString *mobile;//联系电话
@property (nonatomic,strong)NSString *sex;//性别M男N女 optional
@property (nonatomic,strong)NSString *longitude;//经度
@property (nonatomic,strong)NSString *latitude;//纬度
@property (nonatomic,strong)NSString *nick;//名称
@property (nonatomic,strong)NSString *flagDefault;
@end

//删除地址
@interface DeleteAddressR : BaseModel
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *token;
@end