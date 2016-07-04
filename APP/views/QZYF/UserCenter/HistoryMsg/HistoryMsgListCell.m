//
//  HistoryMsgListCell.m
//  APP
//
//  Created by PerryChen on 6/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "HistoryMsgListCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
#import "MKNumberBadgeView.h"
#import "UIImageView+WebCache.h"
@implementation HistoryMsgListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCell:(id)data
{
//    [self.avatarImage convertIntoCircular];
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = RGBHex(qwColor10);
    [self setSelectedBackgroundView:bgColorView];
    HistoryMessages *msgModel = (HistoryMessages *)data;
    self.lblContent.text = msgModel.body;
   
    self.lblSendTime.text = msgModel.consultFormatShowTime;
    HistoryMessages *hisModel = [HistoryMessages getObjFromDBWithKey:msgModel.relatedid];
    NSInteger unreadCount = [msgModel.unreadCounts intValue];
    unreadCount+=[msgModel.systemUnreadCounts intValue];
    self.viewSendStatus.layer.cornerRadius = 3.0f;
    self.viewSendStatus.layer.masksToBounds = YES;
    if(unreadCount != 0 )
    {
        self.imgViewRedPoint.hidden = NO;
    }else{
        self.imgViewRedPoint.hidden = YES;
    }
    
    //            1等待药师回复、2药师已回复、3问题已过期、4问题已关闭, 5抢而未答
    if (msgModel.consultStatus == nil) {
        msgModel.consultStatus = @"0";
    }
    if ([msgModel.pharType intValue] == 2) {
        self.imgViewStarPharmacy.hidden = NO;
    } else {
        self.imgViewStarPharmacy.hidden = YES;
    }
    self.sendIndicateImage.hidden = YES;
    [self.activityIndicator stopAnimating];

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

    switch ([msgModel.consultStatus intValue]) {
        case 1:
        {
            self.lblPharTitle.text = @"问题已群发";
            self.lblSendStatus.text = @"待回复";
            self.viewSendStatus.backgroundColor = RGBHex(qwColor3);
        }
            break;
        case 2:
        {
            NSString *strTitle = @"";
            if (msgModel.groupName.length > 0) {
                strTitle = [NSString stringWithFormat:@"%@",msgModel.groupName]; //msgModel.groupName;
            } else {
                strTitle = @"药师";
            }
            self.lblPharTitle.text = strTitle;

            self.lblSendStatus.text = @"已回复";
            self.viewSendStatus.backgroundColor = RGBHex(qwColor8);
            if (!self.imgViewRedPoint.hidden) {
                self.lblSendStatus.text = @"新回复";
                self.viewSendStatus.backgroundColor = RGBHex(qwColor3);
            }
            
        }
            break;
        case 3:
        {
            self.lblPharTitle.text = @"过期问题集合";
            self.lblSendStatus.text = @"已过期";
            self.viewSendStatus.backgroundColor = RGBHex(qwColor8);
        }
            break;
        case 4:
        {
            NSString *strTitle = @"";
            if (msgModel.groupName.length > 0) {
                strTitle = [NSString stringWithFormat:@"%@",msgModel.groupName];
            } else {
                strTitle = @"药师";
            }
            self.lblPharTitle.text = strTitle;
            self.lblSendStatus.text = @"已结束";
            self.viewSendStatus.backgroundColor = RGBHex(qwColor8);
        }
            break;
        case 5:
        case 6:
        {
            self.lblPharTitle.text = @"问题已群发";
        }
            break;
        default:
        {
            self.lblPharTitle.text = @"问题已群发";
        }
            break;
    }
}




@end
