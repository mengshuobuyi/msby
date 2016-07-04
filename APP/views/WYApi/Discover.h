//
//  Discover.h
//  APP
//
//  Created by qw_imac on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverR.h"
#import "DiscoverModel.h"
@interface Discover : NSObject

+(void)queryDiscover:(DiscoverR *)params success:(void(^)(DiscoverModel *model))success failure:(void(^)(HttpException *e))failure;

@end
