//
//  MapInfoModel.m
//  APP
//
//  Created by garfield on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MapInfoModel.h"

@implementation MapInfoModel

@synthesize formattedAddress; // 格式化地址
@synthesize province; // 省
@synthesize city; // 市
@synthesize location;    //定位得出的经纬度

- (id)init
{
    self = [super init];
    formattedAddress = @"";
    province = @"";
    city = @"";
    location = nil;
    return self;
}

- (BOOL)isEqualTo:(MapInfoModel *)mapInfo
{
    if(!mapInfo || !mapInfo.province || !mapInfo.city)
        return false;
    if([mapInfo.city isEqualToString:self.city] && [mapInfo.province isEqualToString:self.province]) {
        return true;
    }else{
        return false;
    }
}

@end
