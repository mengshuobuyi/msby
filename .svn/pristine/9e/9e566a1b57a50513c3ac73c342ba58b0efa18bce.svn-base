//
//  MsgNotifyOrderCell.m
//  APP
//
//  Created by PerryChen on 1/19/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "MsgNotifyOrderCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
@implementation MsgNotifyOrderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    self.titleLabel.textColor = RGBHex(qwColor6);
    self.titleLabel.font = fontSystem(kFontS3);
    self.contentLabel.textColor = RGBHex(qwColor8);
    self.contentLabel.font = fontSystem(kFontS5);
    self.timeLabel.textColor = RGBHex(qwColor8);
    self.timeLabel.font = fontSystem(kFontS6);
}

- (void)setCell:(id)data
{
    //    [super setCell:data];
    OrderNotiModel *msgModel = (OrderNotiModel *)data;
    self.titleLabel.text = msgModel.title;
    self.contentLabel.text = msgModel.content;
    self.timeLabel.text = msgModel.showTime;

    if ([msgModel.showRedPoint intValue] == 1) {
        self.imgViewRedPoint.hidden = NO;
    } else {
        self.imgViewRedPoint.hidden = YES;
    }
    
}
@end
