//
//  ConfigureModel.m
//  APP
//
//  Created by qw on 15/3/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

@synthesize userToken;
@synthesize passPort;
@synthesize userName;
@synthesize passWord;
@synthesize nickName;
@synthesize avatarUrl;
@synthesize lastTimestamp;

- (id)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.userToken = @"";
    self.passPort = @"";
    self.userName = @"";
    self.passWord = @"";
    self.nickName = @"";
    self.avatarUrl = @"";
    self.firstTPAL = NO;
    self.setPwd = NO;
    self.mobile = @"";
    self.full = NO;
    self.inviteCode = @"";
    self.forceSecurityVerifyCode = YES;
    return self;
}

- (NSString*)getMyUsername
{
    if (!StrIsEmpty(self.nickName)) {
        return self.nickName;
    }
    if (!StrIsEmpty(self.mobile)) {
        return self.mobile;
    }
    if (!StrIsEmpty(self.userName)) {
        return self.userName;
    }
    return @"";
}

@end


@implementation UserInfoModelPrivate

@synthesize userToken;
@synthesize passPort;
@synthesize userName;
@synthesize passWord;
@synthesize nickName;
@synthesize avatarUrl;

- (id)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    self.userToken = @"";
    self.passPort = @"";
    self.userName = @"";
    self.passWord = @"";
    self.nickName = @"";
    self.avatarUrl = @"";
    
    return self;
}

@end

@implementation receiveMessage
@end
@implementation medicineClock
@end
@implementation SaveMemberInfo
@end