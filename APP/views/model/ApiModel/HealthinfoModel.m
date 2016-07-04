//
//  HealthinfoModel.m
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "HealthinfoModel.h"

@implementation HealthinfoChannel

@synthesize channelId;
@synthesize channelName;
@synthesize sort;
@synthesize isRecommend;

@end


@implementation HealthinfoAdvicel

@synthesize adviceId;
@synthesize iconUrl;
@synthesize imgUrl;
@synthesize introduction;
@synthesize likeNumber;
@synthesize pariseNum;
@synthesize publishTime;
@synthesize publisher;
@synthesize readNum;
@synthesize source;
@synthesize title;

+ (NSString *)getPrimaryKey
{
    return @"adviceId";
}

@end

@implementation HealthinfoAdvicelPage

@synthesize page;
@synthesize pageSize;
@synthesize pageSum;
@synthesize totalRecords;
@synthesize list;

+ (NSString *)getPrimaryKey
{
    return @"advicePageId";
}
@end

@implementation HealthInfoReadCountModel

@end

@implementation HealthinfoChannelBanner

@synthesize channelId;
@synthesize adviceId;
@synthesize bannerImgUrl;

+ (NSString *)getPrimaryKey
{
    return @"channelId";
}
@end

@implementation SubjectOrDisvionAreaVO

@end

@implementation ChannelSubjectsVO

@end

@implementation DisvionVO

@end

@implementation DivisionAreaVo

@end

@implementation DivisionAreaVoList

@end

@implementation MsgArticleListVO
@end

@implementation MsgArticleVO

@end

@implementation MsgChannelListVO

@end

@implementation MsgChannelVO
+ (NSString *)getPrimaryKey
{
    return @"channelID";
}
@end
