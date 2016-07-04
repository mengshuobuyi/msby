//
//  FactoryModel.m
//  APP
//
//  Created by caojing on 15-3-13.
//  Copyright (c) 2015年 carret. All rights reserved.
//


#import "FactoryModel.h"
@implementation FactoryModel
@end

@implementation FactoryListModel

@synthesize factoryId;
+ (NSString *)getPrimaryKey
{
    return @"factoryId";
}
@end



@implementation FactoryProductList
@synthesize list;
@end

@implementation FactoryProduct

@synthesize proId;
@synthesize proName;
@synthesize spec;
@synthesize factory;

@end



@implementation FactoryDetailModel

@synthesize code;
@synthesize name;
@synthesize desc;
@synthesize imgUrl;
@synthesize address;
@synthesize site;
@synthesize auth;

@end


@implementation FactoryInfoModel

@synthesize FactoryInfo;

@end

