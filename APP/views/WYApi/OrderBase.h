//
//  OrderBase.h
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderBaseModelR.h"
#import "OrderBaseModel.h"
@interface OrderBase : NSObject

+ (void)orderBaseComment:(OrderBaseCommentModelR *)param
                 success:(void (^)(OrderBaseCommentModel *responModel))success
                 failure:(void (^)(HttpException *e))failure;

@end
