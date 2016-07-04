//
//  MsgNotifyListCell.m
//  APP
//
//  Created by PerryChen on 6/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgNotifyListCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
@implementation MsgNotifyListCell

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
    MsgNotifyListModel *msgModel = (MsgNotifyListModel *)data;
//    NSString *strShowTitle = @"";
//    if ([msgModel.title length] > 12) {
//        strShowTitle = [msgModel.title substringToIndex:12];
//        strShowTitle = [NSString stringWithFormat:@"%@...",strShowTitle];
//    } else {
//        strShowTitle = msgModel.title;
//    }
    self.lblContent.text = msgModel.consultShowTitle;
    self.lblTime.text = msgModel.formatShowTime;
    if ([msgModel.showRedPoint intValue] == 1) {
        self.imgViewRedPoint.hidden = NO;
    } else {
        self.imgViewRedPoint.hidden = YES;
    }
    
//    switch ([msgModel.consultStatus intValue]) {
//        case 2:
//        {
//            self.lblContent.text = [NSString stringWithFormat:@"%@的药师回复了您的问题",msgModel.pharShortName];
//        }
//            break;
//        case 3:
//        {
//            self.lblContent.text = [NSString stringWithFormat:@"您的问题\"%@\" 已过期",strShowTitle];
//        }
//            break;
//        case 4:
//        {
//            self.lblContent.text = [NSString stringWithFormat:@"%@为您提供的免费咨询服务已经结束",msgModel.pharShortName];
//        }
//            break;
//        default:
//        {
//        }
//            break;
//    }
    
}


@end
