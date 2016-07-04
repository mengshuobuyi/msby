//
//  MsgBoxOfficialCell.m
//  APP
//
//  Created by PerryChen on 8/4/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgBoxOfficialCell.h"
#import "QWMessage.h"
#import "QWGlobalManager.h"
#import "MKNumberBadgeView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@implementation MsgBoxOfficialCell

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
    
//    MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[self.contentView viewWithTag:888];
//    if(!badgeView) {
//        badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(30, 0, 40, 40)];
//        badgeView.shadow = NO;
//        badgeView.tag = 888;
//    } else {
//        [badgeView removeFromSuperview];
//    }
    NSInteger unreadCount = 0;
    if ([msgModel.type intValue] == 2) {
        unreadCount += [msgModel.unreadCounts intValue];
    } else {
        unreadCount += [msgModel.unreadCounts intValue];
        unreadCount += [msgModel.systemUnreadCounts intValue];
    }
    
    self.nameIcon.hidden = YES;
    [self.avatarImage setImage:nil];
    if(unreadCount != 0 )
    {
//        badgeView.value = unreadCount;
//        [self.contentView addSubview:badgeView];
    }else{
//        [badgeView removeFromSuperview];
    }
    if ([msgModel.type intValue] == 1) {
        // 全维药事
        
        self.nameIcon.hidden = NO;
        self.nameIcon.image = [UIImage imageNamed:@"official"];
        [self.avatarImage setImage:[UIImage imageNamed:@"ic_img_icon-1"]];
    } else if ([msgModel.type intValue] == 2) {
        // 咨询
        [self.avatarImage setImage:[UIImage imageNamed:@"ic_img_notice-3"]];
    } else if ([msgModel.type intValue] == 3){
        // 即时聊天
        
        if ([msgModel.pharType intValue] == 2) {
            self.nameIcon.hidden = NO;
            self.nameIcon.image = [UIImage imageNamed:@"ic_img_medal"];
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
        
        [self.avatarImage setImageWithURL:[NSURL URLWithString:msgModel.imgUrl] placeholderImage:[UIImage imageNamed:@"news_icon_default avatar"]];
    } else {
        [self.avatarImage setImage:[UIImage imageNamed:@"ic_img_notice-3"]];
    }
    
}

@end
