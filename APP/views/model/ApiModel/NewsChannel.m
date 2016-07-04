//
//  News_Channel.m
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "NewsChannel.h"

@implementation NewsChannel

@synthesize channelId;
@synthesize channelName;
@synthesize sort;

@end


@implementation NewsAdvicel

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

@end

@implementation NewsAdvicelPage

@synthesize currPage;
@synthesize pageSize;
@synthesize totalPage;
@synthesize totalRecord;
@synthesize data;

+ (NSString *)getPrimaryKey
{
    return @"advicePageId";
}
@end

@implementation NewsChannelBanner

@synthesize channelId;
@synthesize adviceId;
@synthesize bannerImgUrl;

+ (NSString *)getPrimaryKey
{
    return @"channelId";
}
@end