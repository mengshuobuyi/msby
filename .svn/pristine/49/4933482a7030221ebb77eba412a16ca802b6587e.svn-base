//
//  QWPrivateMessageModel.m
//  APP
//
//  Created by Martin.Liu on 16/3/10.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWPrivateMessageModel.h"
#import "QWGlobalManager.h"
@implementation QWPrivateMessageModel

- (instancetype)init
{
    if (self = [super init]) {
        self.sendPassport = QWGLOBALMANAGER.configure.passPort;
    }
    return self;
}

+ (NSString *)getPrimaryKey
{
    return @"UUID";
}
@end
