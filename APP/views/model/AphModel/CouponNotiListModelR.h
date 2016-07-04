//
//  CouponNotiListModelR.h
//  APP
//
//  Created by PerryChen on 8/17/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"

@interface CouponNotiListModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *view;
@end

@interface CouponNotiPullListModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@end

@interface RemoveByCustomerCounponR : BaseModel
@property (nonatomic, strong) NSString *messageId;
@end

@interface CouponNotiReadR : BaseModel
@property (nonatomic, strong) NSString *messageId;
@end