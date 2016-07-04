//
//  HisListOutOfDateCell.m
//  APP
//
//  Created by PerryChen on 9/7/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "HisListOutOfDateCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
#import "UIImageView+WebCache.h"
@implementation HisListOutOfDateCell

- (void)setCell:(id)data
{
    HistoryMessages *msgModel = (HistoryMessages *)data;
    self.lblContent.text = msgModel.body;
    
    NSInteger unreadCount = [msgModel.unreadCounts intValue];
    unreadCount+=[msgModel.systemUnreadCounts intValue];
    if(unreadCount != 0 )
    {
        self.imgViewRedPoint.hidden = NO;
    }else{
        self.imgViewRedPoint.hidden = YES;
    }
    self.lblContent.text = @"过期问题";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
