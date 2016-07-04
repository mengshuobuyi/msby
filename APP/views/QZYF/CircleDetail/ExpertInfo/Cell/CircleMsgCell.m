//
//  CircleMsgCell.m
//  APP
//
//  Created by PerryChen on 3/9/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "CircleMsgCell.h"
#import "UIImageView+WebCache.h"
#import "QWGlobalManager.H"
@implementation CircleMsgCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)UIGlobal
{
    self.circleMsgExpertNameLbl.font = fontSystem(kFontS1);
    self.circleMsgExpertNameLbl.textColor = RGBHex(qwColor6);
    self.circleMsgExpertContent.font = fontSystem(kFontS5);
    self.circleMsgExpertContent.textColor = RGBHex(qwColor8);
    self.circleTagLabel.font = fontSystem(kFontS4);
//    self.circleTagLabel.textColor = RGBHex(qwColor6);
    self.circleMsgTime.font = fontSystem(kFontS5);
    self.circleMsgTime.textColor = RGBHex(qwColor8);
    self.circleMsgAvatarImgView.layer.cornerRadius = self.circleMsgAvatarImgView.frame.size.width / 2;
    self.circleMsgAvatarImgView.layer.masksToBounds = YES;

}

- (void)setCell:(id)data
{
    CircleChatPointModel * model = (CircleChatPointModel *)data;
    self.circleMsgExpertNameLbl.text = [NSString stringWithFormat:@"%@",model.nickName];
    self.circleMsgExpertContent.text = [NSString stringWithFormat:@"%@",model.respond];;
    [self.circleMsgAvatarImgView setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"userCenterHeader"]];
    self.circleMsgTime.text = model.displayDate;
    if (model.readFlag) {
        self.circleMsgRedPoint.hidden = YES;
    } else {
        self.circleMsgRedPoint.hidden = NO;
    }
    self.circleMsgExpertGenderImgView.hidden = YES;
    self.circleTagLabel.hidden = YES;
    if ([model.userType intValue] == 3) {
        // 药师
        self.circleTagLabel.text = @"药师";
        self.circleTagLabel.hidden = NO;
//        self.circleMsgExpertGenderImgView.hidden = NO;
//        self.circleMsgExpertGenderImgView.image = [UIImage imageNamed:@"pharmacist"];
    } else if ([model.userType intValue] == 4) {
        // 营养师
        self.circleTagLabel.text = @"营养师";
        self.circleTagLabel.hidden = NO;
//        self.circleMsgExpertGenderImgView.hidden = NO;
//        self.circleMsgExpertGenderImgView.image = [UIImage imageNamed:@"ic_expert"];
    }
}

@end
