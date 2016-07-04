//
//  MsgBoxListCell.m
//  APP
//
//  Created by  ChenTaiyu on 16/6/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MsgBoxListCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
#import "MKNumberBadgeView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface MsgBoxListCell ()

@property (nonatomic, strong) NSDictionary *iconImageDict;

@end

@implementation MsgBoxListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImage.layer.cornerRadius = 4.0f;
    self.iconImage.layer.masksToBounds = YES;
    self.titleLabel.font = fontSystem(kFontS3);
    self.titleLabel.textColor = RGBHex(qwColor6);
    self.contentLabel.font = fontSystem(kFontS5);
    self.contentLabel.textColor = RGBHex(qwColor7);
    self.dateLabel.font = fontSystem(kFontS6);
    self.dateLabel.textColor = RGBHex(qwColor8);
    self.redPoint.hidden = YES;
    self.nameIcon.hidden = YES;
    self.unreadCountView.hidden = YES;
}

- (void)setCell:(id)data
{
    MsgBoxListItemModel *msgModel = (MsgBoxListItemModel *)data;

    if (!msgModel.formatShowTime.length) {
        msgModel.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[msgModel.time doubleValue]]];
    }
    self.titleLabel.text = msgModel.title;
    self.contentLabel.text = msgModel.content;
    self.dateLabel.text = msgModel.formatShowTime;
    
    NSInteger unreadCount = [msgModel.unread intValue];

//    MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[self.unreadCountView viewWithTag:888];
//    if(!badgeView) {
//        badgeView = [[MKNumberBadgeView alloc] initWithFrame:self.unreadCountView.bounds];
//        badgeView.shadow = NO;
//        badgeView.tag = 888;
//        badgeView.center = CGPointMake(self.unreadCountView.bounds.size.width/2, self.unreadCountView.bounds.size.height/2);
//    }
//    [self.unreadCountView addSubview:badgeView];
//    badgeView.value = unreadCount;
    if(unreadCount != 0 ) {
        self.redPoint.hidden = NO;
    }else{
        self.redPoint.hidden = YES;
    }
    
    if (msgModel.type.integerValue == MsgBoxListMsgTypeExpertPTP || msgModel.type.integerValue == MsgBoxListMsgTypeShopConsult) {
//        if (unreadCount != 0) {
//            self.unreadCountView.hidden = NO;
//        } else {
//            self.unreadCountView.hidden = YES;
//        }
        if (msgModel.type.integerValue == MsgBoxListMsgTypeShopConsult) {
            if (msgModel.logo.length) {
                [self.iconImage setImageWithURL:[NSURL URLWithString:msgModel.logo] placeholderImage:self.iconImageDict[@(msgModel.type.integerValue)]];
            } else {
                self.iconImage.image = self.iconImageDict[@(msgModel.type.integerValue)];
            }
        } else {
            if (msgModel.logo.length) {
                [self.iconImage setImageWithURL:[NSURL URLWithString:msgModel.logo] placeholderImage:self.iconImageDict[@(msgModel.type.integerValue)]];
            } else {
                self.iconImage.image = self.iconImageDict[@(msgModel.type.integerValue)];
            }
        }

    } else {
        self.iconImage.image = self.iconImageDict[@(msgModel.type.integerValue)];
    }
    
// 处理特殊标志
//    if ([msgModel.type intValue] == 1) {
//        // 全维药事
//        self.nameIcon.hidden = NO;
//        self.nameIcon.image = [UIImage imageNamed:@"official"];
//    }
//    if ([msgModel.type intValue] == MsgBoxListMsgTypeExpertPTP){
        // 即时聊天
//        if ([msgModel.pharType intValue] == 2) {
//            self.nameIcon.hidden = NO;
//            self.nameIcon.image = [UIImage imageNamed:@"img_bg_v"];
//        } else {
//            self.nameIcon.hidden = YES;
//        }
        
        if (!msgModel.isSend) {
            msgModel.isSend = @"0";
        }
        self.sendIndicateImage.hidden = YES;
        [self.activityIndicator stopAnimating];
        switch ([msgModel.isSend intValue]) {
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


- (NSDictionary *)iconImageDict
{
    static id onceDict = nil;
    if (!onceDict) {
        onceDict = @{
                     @(MsgBoxListMsgTypeHealth) : [UIImage imageNamed:@"icon_news_healthy"],
                     @(MsgBoxListMsgTypeExpertPTP) : [UIImage imageNamed:@"icon_news_consulting"],
                     @(MsgBoxListMsgTypeShopConsult) : [UIImage imageNamed:@"icon_news_pharmacy"],
//                     @(MsgBoxListMsgTypeCredit) : [UIImage imageNamed:@"icon_news_notice"],
                     @(MsgBoxListMsgTypeNotice) : [UIImage imageNamed:@"icon_news_notice"],
                     @(MsgBoxListMsgTypeOrder) : [UIImage imageNamed:@"icon_news_order"],
                     @(MsgBoxListMsgTypeCircle) : [UIImage imageNamed:@"icon_news_circle"],
                     };
    }
   return onceDict;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[self.unreadCountView viewWithTag:888];
//    badgeView.value = arc4random()%150;
//    [self insertSubview:self.unreadCountView aboveSubview:self.iconImage];
}


@end
