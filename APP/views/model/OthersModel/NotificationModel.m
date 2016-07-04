//
//  NotificationModel.m
//  APP
//
//  Created by qw on 15/5/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

- (instancetype)fixedStrValueModel
{
    id newModel = [NotificationModel new];
    unsigned int outCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:propertyName];
        if ([value isKindOfClass:[NSArray class]]) {
            [newModel setValue:[((NSArray *)value) firstObject] forKey:propertyName];
        } else {
            [newModel setValue:value forKey:propertyName];
        }
    }
    free(properties);
    return newModel;
}

@end
