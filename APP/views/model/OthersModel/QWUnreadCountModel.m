//
//  QWUnreadCountModel.m
//  wenYao-store
//
//  Created by PerryChen on 6/11/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWUnreadCountModel.h"

@implementation QWUnreadCountModel
+ (NSString *)getPrimaryKey
{
    return @"passport";
}
@end

@implementation QWUnreadFlagModel

+ (NSString *)getPrimaryKey
{
    return @"passport";
}

- (void)setShopConsultUnreadCount:(NSInteger)shopConsultUnreadCount
{
    _shopConsultUnreadCount = shopConsultUnreadCount > 0 ? : 0;
    self.shopConsultUnread = shopConsultUnreadCount > 0;
}

- (void)setExpertPTPMsgUnreadCount:(NSInteger)expertPTPMsgUnreadCount
{
    _expertPTPMsgUnreadCount = expertPTPMsgUnreadCount > 0 ? : 0;
    self.expertPTPMsgUnread = expertPTPMsgUnreadCount > 0;
}

@end