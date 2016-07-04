//
//  SysNotiListModelR.h
//  APP
//
//  Created by PerryChen on 8/18/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"

@interface SysNotiListModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *view;
@end


@interface SysNotiPullListModelR : BaseModel

@property (nonatomic, strong) NSString *token;
@end

@interface OrderNotiListModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *view;
@end

@interface OrderNotiPullListModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@end

@interface RemoveByCustomerOrderR : BaseModel
@property (nonatomic, strong) NSString *messageId;
@end

@interface OrderNotiReadR : BaseModel
@property (nonatomic, strong) NSString *messageId;
@end