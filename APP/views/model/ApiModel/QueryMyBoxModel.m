//
//  QueryMyBoxModel.m
//  APP
//
//  Created by garfield on 15/3/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QueryMyBoxModel.h"

@implementation QueryMyBoxModel


+(NSString *)getPrimaryKey
{
    return @"boxId";
}

@synthesize boxId;
@synthesize productName;
@synthesize proId;
@synthesize source;
@synthesize useName;
@synthesize createTime;
@synthesize effect;
@synthesize useMethod;
@synthesize perCount;
@synthesize unit;
@synthesize intervalDay;
@synthesize drugTime;
@synthesize drugTag;
@synthesize productEffect;
@synthesize accType;
@synthesize signCode;
@synthesize type;

@end

@implementation QueryBoxByKeywordModel

+(NSString *)getPrimaryKey
{
    return @"boxId";
}

@synthesize boxId;
@synthesize productName;
@synthesize proId;
@synthesize source;
@synthesize useName;
@synthesize createTime;
@synthesize effect;
@synthesize useMethod;
@synthesize perCount;
@synthesize unit;
@synthesize intervalDay;
@synthesize drugTime;
@synthesize drugTag;
@synthesize productEffect;
@synthesize accType;

@end

@implementation TagsModel
@synthesize tag;

@end

@implementation QueryBoxByTagModel

+(NSString *)getPrimaryKey
{
    return @"boxId";
}

@synthesize boxId;
@synthesize productName;
@synthesize proId;
@synthesize source;
@synthesize useName;
@synthesize createTime;
@synthesize effect;
@synthesize useMethod;
@synthesize perCount;
@synthesize unit;
@synthesize intervalDay;
@synthesize drugTime;
@synthesize drugTag;
@synthesize productEffect;
@synthesize accType;
@synthesize signCode;

@end

@implementation SaveOrUpdateMyBoxModel

@synthesize boId;

@end

@implementation GetBoxProductDetailModel

+(NSString *)getPrimaryKey
{
    return @"boxId";
}

- (id)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.boxId = @"";
    self.productName = @"";
    self.proId = @"";
    self.source = @"";
    self.useName = @"";
    self.createTime = @"";
    
    
    self.effect = @"";
    self.useMethod = @"";
    self.perCount = @"";
    self.unit = @"";
    self.intervalDay = @"";
    self.drugTime = @"";
    self.drugTag = @"";
    self.productEffect = @"";
    self.accType = @"";
    self.signCode = @"";
    self.type = @"";
    
    return self;
}

@synthesize boxId;
@synthesize productName;
@synthesize proId;
@synthesize source;
@synthesize useName;
@synthesize createTime;
@synthesize effect;
@synthesize useMethod;
@synthesize perCount;
@synthesize unit;
@synthesize intervalDay;
@synthesize drugTime;
@synthesize drugTag;
@synthesize productEffect;
@synthesize accType;
@synthesize signCode;
@synthesize type;

@end

@implementation SimilarDrugModel

@synthesize proId;
@synthesize productName;

@end

@implementation QueryAllTagsModel


@end

@implementation GetProductUsage

@synthesize useMethod;
@synthesize perCount;
@synthesize unit;
@synthesize dayPerCount;
@synthesize drugTime;
@synthesize drugTag;

@end

