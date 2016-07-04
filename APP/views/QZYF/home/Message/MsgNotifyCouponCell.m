//
//  MsgNotifyListCell.m
//  APP
//
//  Created by PerryChen on 6/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgNotifyCouponCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
@implementation MsgNotifyCouponCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCell:(id)data
{
//    [super setCell:data];
    CouponNotiModel *msgModel = (CouponNotiModel *)data;
    self.lblContent.text = msgModel.content;
    self.lblTime.text = msgModel.formatShowTime;
    self.lblContent.textColor = RGBHex(qwColor6);
    self.lblContent.font = fontSystem(kFontS4);
    self.lblTime.textColor = RGBHex(qwColor8);
    self.lblTime.font = fontSystem(kFontS5);
    if ([msgModel.showRedPoint intValue] == 1) {
        self.imgViewRedPoint.hidden = NO;
    } else {
        self.imgViewRedPoint.hidden = YES;
    }
    
}


@end
