//
//  MsgListCell.m
//  APP
//
//  Created by PerryChen on 6/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgListCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
#import "MKNumberBadgeView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@implementation MsgListCell

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
    self.avatarImage.layer.cornerRadius = 4.0f;
    self.avatarImage.layer.masksToBounds = YES;
    PharMsgModel *msgModel = (PharMsgModel *)data;
    self.contentLabel.text = msgModel.content;
    if ([msgModel.formatShowTime length] <= 0) {
        msgModel.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[msgModel.timestamp doubleValue]]];
    }
    self.dateLabel.text = msgModel.formatShowTime;
    
    self.titleLabel.text = msgModel.title;
    
//    MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[self.viewUnreadCount viewWithTag:888];
//    if(!badgeView) {
//        badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(0, 0, self.viewUnreadCount.frame.size.width, self.viewUnreadCount.frame.size.height)];
//        badgeView.shadow = NO;
//        badgeView.tag = 888;
//    } else {
//        [badgeView removeFromSuperview];
//    }
    NSInteger unreadCount = 0;
    if (([msgModel.type intValue] == 2)||([msgModel.type intValue] == 4)||([msgModel.type intValue] == 5)) {
        unreadCount += [msgModel.unreadCounts intValue];
    } else {
        unreadCount += [msgModel.unreadCounts intValue];
        unreadCount += [msgModel.systemUnreadCounts intValue];
    }
    self.titleLabel.font = fontSystem(kFontS4);
    self.contentLabel.font = fontSystem(kFontS5);
    self.contentLabel.textColor = RGBHex(qwColor8);
    self.nameIcon.hidden = YES;
    [self.avatarImage setImage:nil];
    self.imgViewRedPoint.hidden = YES;
    if(unreadCount != 0 )
    {
//        badgeView.value = unreadCount;
//        [self.contentView addSubview:badgeView];
//        [self.viewUnreadCount addSubview:badgeView];
        self.imgViewRedPoint.hidden = NO;
    }else{
//        [badgeView removeFromSuperview];
        self.imgViewRedPoint.hidden = YES;
    }
//    self.viewUnreadCount.hidden = NO;
    if ([msgModel.type intValue] == 1) {
        // 全维药事
        // #999999
        self.titleLabel.textColor = RGBHex(qwColor8);
        self.nameIcon.hidden = NO;
        self.nameIcon.image = [UIImage imageNamed:@"official"];
        [self.avatarImage setImage:[UIImage imageNamed:@"ic_img_icon-1"]];
    } else if ([msgModel.type intValue] == 2) {
        // 咨询
        // #999999
        self.titleLabel.textColor = RGBHex(qwColor8);
        [self.avatarImage setImage:[UIImage imageNamed:@"ic_img_notice-3"]];
    } else if ([msgModel.type intValue] == 3){
        // 即时聊天
        // #333333
        if ([msgModel.pharType intValue] == 2) {
            self.nameIcon.hidden = NO;
            self.nameIcon.image = [UIImage imageNamed:@"img_bg_v"];
        } else {
            self.nameIcon.hidden = YES;
        }

        if (msgModel.issend == nil) {
            msgModel.issend = @"0";
        }
        self.sendIndicateImage.hidden = YES;
        [self.activityIndicator stopAnimating];
        DDLogVerbose(@"##### the is send is %@",msgModel.issend);
        switch ([msgModel.issend intValue]) {
            case 1:
            {
                    // 正在发送
                self.sendIndicateImage.hidden = YES;
                [self.activityIndicator startAnimating];
                self.viewUnreadCount.hidden = YES;
            }
                break;
            case 2:
            {
                    // 发送成功
                self.sendIndicateImage.hidden = YES;
                [self.activityIndicator stopAnimating];
                self.viewUnreadCount.hidden = NO;
            }
                break;
            case 3:
            {
                // 发送失败
                self.sendIndicateImage.hidden = NO;
                [self.activityIndicator stopAnimating];
                self.viewUnreadCount.hidden = YES;
            }
                break;
            default:
                break;
        }
        self.titleLabel.textColor = RGBHex(qwColor6);
        
        [self.avatarImage setImageWithURL:[NSURL URLWithString:msgModel.imgUrl] placeholderImage:[UIImage imageNamed:@"news_icon_default avatar"]];
    } else if ([msgModel.type intValue] == 4) {
        // 优惠券通知列表
        // #999999
        self.titleLabel.textColor = RGBHex(qwColor8);
//        self.titleLabel.text = msgModel.title;//@"优惠券通知";//msgModel.title;
        self.titleLabel.text = @"消息通知";
    } else if ([msgModel.type intValue] == 5) {
        // 系统通知
        self.titleLabel.textColor = RGBHex(qwColor8);
        self.titleLabel.text = @"系统通知，测试用";
    }
    
}
@end
