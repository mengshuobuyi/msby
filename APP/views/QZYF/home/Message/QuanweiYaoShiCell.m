//
//  HomePageTableViewCell.m
//  wenyao
//
//  Created by Pan@QW on 14-9-25.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QuanweiYaoShiCell.h"
#import "UIView+Extension.h"
#import "MKNumberBadgeView.h"

@implementation QuanweiYaoShiCell

- (void)awakeFromNib
{
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(id)data
{
    [self.avatarImage convertIntoCircular];
    self.sendIndicateImage.hidden = YES;
    self.titleLabel.text = @"全维药事";
    [self.avatarImage setImage:[UIImage imageNamed:@"news_icon_quwei"]];
    self.nameIcon.image = [UIImage imageNamed:@"official"];
    OfficialMessages* msg = [OfficialMessages getObjFromDBWithWhere:nil WithorderBy:@"timestamp desc"];
    if (msg) {
        self.contentLabel.text = msg.body;
        double timestamp = [msg.timestamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        self.dateLabel.text = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:date];
    }else{
        self.contentLabel.text = WELCOME_MESSAGE;
        NSDate *dateNow = [NSDate date];
        self.dateLabel.text = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:dateNow];
    }
    NSInteger intUnread = [OfficialMessages getcountFromDBWithWhere:@"issend = 0"];
    MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[self.contentView viewWithTag:888];
    if(!badgeView) {
        badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(35, -5, 40, 40)];
        badgeView.shadow = NO;
        badgeView.tag = 888;
    }
    if(intUnread != 0 )
    {
        badgeView.value = intUnread;
        [self.contentView addSubview:badgeView];
    }else{
        [badgeView removeFromSuperview];
    }
}

@end
