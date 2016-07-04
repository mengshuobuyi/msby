//
//  StoreModel.m
//  APP
//
//  Created by chenzhipeng on 3/6/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

@end

@implementation SearchStorehModel

@end

@implementation StoreNearByListModel

@end

@implementation StoreNearByModel

+ (NSString *)getPrimaryKey
{
    return @"accountId";
}

@end

@implementation StoreNearByTagModel

@end

@implementation StoreSearchOpenCityCheckModel

@synthesize city,cityName,code,id,open,province,provinceName,remark;

@end


@implementation StoreSearchRegionModel


@end

@implementation GroupModel


@end


@implementation StoreNearBySearchModel

+ (NSString *)getPrimaryKey
{
    return @"id";
}

@end

@implementation StoreComplaintTypeModel

@end


@implementation RecommendStoreModel

@end