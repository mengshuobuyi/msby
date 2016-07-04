//
//  WYLocalNotifModel.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/3.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "WYLocalNotifModel.h"

@implementation WYLocalNotifModel

- (id)init
{
    self = [super init];
    if (self) {
        self.listTimes=[@[@"07:00"]mutableCopy];//@"08:00",@"09:00",@"12:00",@"14:00",@"16:00",
        self.drugCycle=@"每日";
        self.clockEnabled = YES;
        self.numCycle=@"1";
        self.type=@"DrugClock";
    }
    return self;
}

+ (NSString *)getPrimaryKey
{
    return @"hashValue";
}
@end
