//
//  MsgConsultCell.m
//  APP
//
//  Created by PerryChen on 6/8/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgConsultCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
#import "MKNumberBadgeView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@implementation MsgConsultCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCell:(id)data
{
    [self.avatarImage convertIntoCircular];
    HistoryMessages *msgModel = (HistoryMessages *)data;
    self.contentLabel.text = msgModel.body;
    double timestamp = [msgModel.timestamp doubleValue];
    timestamp = timestamp / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    self.dateLabel.text = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:date];
    HistoryMessages *hisModel = [HistoryMessages getObjFromDBWithKey:msgModel.relatedid];
    
    MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[self.contentView viewWithTag:888];
    if(!badgeView) {
        badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(25, 0, 40, 40)];
        badgeView.shadow = NO;
        badgeView.tag = 888;
    }
    if ([msgModel.isOutOfDate intValue] == 1) {
        if ([msgModel.isShowRedPoint intValue] > 0) {
//            badgeView.value = 0;
//            [self.contentView addSubview:badgeView];
            self.imgViewOutOfDate.hidden = NO;
        } else {
            self.imgViewOutOfDate.hidden = YES;
        }
    } else {
        self.imgViewOutOfDate.hidden = YES;
        NSInteger unreadCount = [msgModel.unreadCounts intValue];
        unreadCount+=[msgModel.systemUnreadCounts intValue];
        if(unreadCount != 0 )
        {
            badgeView.value = unreadCount;
            [self.contentView addSubview:badgeView];
        }else{
            [badgeView removeFromSuperview];
        }
    }
    
    if (hisModel != nil) {
        //                if (msgModel.issend == nil) {
        //                    msgModel.issend = @"0";
        //                }
        //                NSLog(@"the issend is %@",hisModel.issend);
        if (hisModel.issend == nil) {
            hisModel.issend = @"0";
        }
        switch ([hisModel.issend intValue]) {
            case 1:
            {
                // 正在发送
                self.sendIndicateImage.hidden = YES;
                [self.activityIndicator startAnimating];
            }
                break;
            case 2:
            {
                // 发送成功
                self.sendIndicateImage.hidden = YES;
                [self.activityIndicator stopAnimating];
            }
                break;
            case 3:
            {
                // 发送失败
                self.sendIndicateImage.hidden = NO;
                [self.activityIndicator stopAnimating];
            }
                break;
            default:
                break;
        }
    }
    
    //            1等待药师回复、2药师已回复、3问题已过期、4问题已关闭, 5抢而未答
    self.avatarImage.hidden = NO;
    if (msgModel.consultStatus == nil) {
        msgModel.consultStatus = @"0";
    }
    self.nameIcon.hidden = YES;
    
    switch ([msgModel.consultStatus intValue]) {
        case 1:
        {
            [self.avatarImage setImage:[UIImage imageNamed:@"news_icon_waiting"]];
            self.titleLabel.text = @"等待药师回复";
            self.lblSendStatus.text = @"";
        }
            break;
        case 2:
        {
            NSString *strTitle = @"";
            if (msgModel.groupName.length > 0) {
                strTitle = [NSString stringWithFormat:@"%@药师",msgModel.groupName]; //msgModel.groupName;
            } else {
                strTitle = @"药师";
            }
            self.titleLabel.text = strTitle;
            [self.avatarImage setImageWithURL:[NSURL URLWithString:msgModel.avatarurl] placeholderImage:[UIImage imageNamed:@"news_icon_default avatar"]];
            if ([msgModel.pharType intValue] == 2) {
                self.nameIcon.hidden = NO;
            } else {
                self.nameIcon.hidden = YES;
            }
            self.lblSendStatus.text = @"已回复";
        }
            break;
        case 3:
        {
            // TODO: need update
//            if (msgModel.diffusion) {            // 是问所有药师
                self.titleLabel.text = @"问题已过期";
//            } else {                        // 问某个药师
//                NSString *strTitle = @"";
//                if (msgModel.groupName.length > 0) {
//                    strTitle = [NSString stringWithFormat:@"%@药师",msgModel.groupName]; //msgModel.groupName;
//                } else {
//                    strTitle = @"药师";
//                }
//                self.titleLabel.text = strTitle;
//                if ([msgModel.pharType intValue] == 2) {
//                    self.nameIcon.hidden = NO;
//                } else {
//                    self.nameIcon.hidden = YES;
//                }
//            }
            self.lblSendStatus.text = @"已过期";
            [self.avatarImage setImage:[UIImage imageNamed:@"news_icon_over time"]];
        }
            break;
        case 4:
        {
            NSString *strTitle = @"";
            if (msgModel.groupName.length > 0) {
                strTitle = [NSString stringWithFormat:@"%@药师",msgModel.groupName];
            } else {
                strTitle = @"药师";
            }
            self.titleLabel.text = strTitle;
            [self.avatarImage setImageWithURL:[NSURL URLWithString:msgModel.avatarurl] placeholderImage:[UIImage imageNamed:@"news_icon_default avatar"]];
            if ([msgModel.pharType intValue] == 2) {
                self.nameIcon.hidden = NO;
            } else {
                self.nameIcon.hidden = YES;
            }
            self.lblSendStatus.text = @"已结束";
        }
            break;
        case 5:
        {
            [self.avatarImage setImage:[UIImage imageNamed:@"news_icon_waiting"]];
            if (msgModel.diffusion) {            // 是问所有药师
                self.titleLabel.text = @"等待药师回复";
            } else {                        // 问某个药师
                NSString *strTitle = @"";
                if (msgModel.groupName.length > 0) {
                    strTitle = [NSString stringWithFormat:@"等待%@药师回复",msgModel.groupName]; //msgModel.groupName;
                } else {
                    strTitle = @"等待药师回复";
                }
                self.titleLabel.text = strTitle;
                if ([msgModel.pharType intValue] == 2) {
                    self.nameIcon.hidden = NO;
                } else {
                    self.nameIcon.hidden = YES;
                }
            }
        }
            break;
        default:
        {
            self.titleLabel.text = @"等待药师回复";
            [self.avatarImage setImage:[UIImage imageNamed:@"news_icon_waiting"]];
        }
            break;
    }
}

@end
