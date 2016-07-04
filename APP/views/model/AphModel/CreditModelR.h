//
//  CreditModelR.h
//  APP
//
//  Created by Martin.Liu on 15/12/4.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface CreditModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@end

@interface CreditRecordsR : BaseModel
@property (nonatomic, strong) NSString *token;

@end

@interface SignR : BaseModel
@property (nonatomic,strong) NSString *token;
@end

@interface MyLevelR : BaseModel
@property (nonatomic,strong) NSString *token;
@end

@interface DoUpgradeTaskR : BaseModel
@property (nonatomic,strong) NSString *token;
@end