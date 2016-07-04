//
//  MbrModelR.h
//  APP
//
//  Created by carret on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface MbrModelR : BaseModel

@end

@interface mbrLoginR : BaseModel
@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *deviceCode;
@property (nonatomic,strong) NSString *device;

@end

@interface MbrInviterCheckR : BaseModel
@property (nonatomic, strong) NSString *token;
@end

@interface MbrInviterR : BaseModel
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *inviter;  //推荐人手机号
@end

@interface MbrRegisterR : BaseModel

@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *device;
@property (strong, nonatomic) NSString *deviceType;
@property (strong, nonatomic) NSString *city;
@property (nonatomic, strong) NSString *branchId;        // 来源药房id
@property (nonatomic, strong) NSString *credentials;
@end

@interface MbrInviterInfoModelR : BaseModel

@end

@interface ChannerModelR : BaseModel

@property (strong, nonatomic) NSString *cKey;
@property (strong, nonatomic) NSString *objId;
@property (strong, nonatomic) NSString *objRemark;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *deviceType;
@property (strong, nonatomic) NSString *deviceCode;

@end

@interface BindModelR : BaseModel

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *openId;

@end

/**
 *  4.0.0 赠送大礼包
 */
@interface PresentGiftR : BaseModel
@property (nonatomic, strong) NSString *token;          // 用户令牌
@property (nonatomic, strong) NSString *branchId;       // 用户令牌 (药房id)
@property (nonatomic, strong) NSString *deviceType;     // 使用设备类型 1:安卓,2:ios,3:h5,4:微信
@end