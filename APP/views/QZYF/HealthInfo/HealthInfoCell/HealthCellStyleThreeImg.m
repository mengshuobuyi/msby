//
//  HealthCellStyleTopic.m
//  APP
//
//  Created by PerryChen on 1/5/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "HealthCellStyleThreeImg.h"
#import "HealthinfoModel.h"
#import "UIImageView+WebCache.h"
@implementation HealthCellStyleThreeImg

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setCell:(id)data
{
    float ratioScreenW = 320.0f / APP_W;
    MsgArticleVO *model = (MsgArticleVO *)data;
    self.lblHealthContent.font = fontSystem(kFontS2);
    self.lblHealthContent.textColor = RGBHex(qwColor6);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.lblTime.textColor = self.lblReadNum.textColor = RGBHex(qwColor7);
    self.lblHealthContent.text = model.title;
    self.lblTime.text = [NSString stringWithFormat:@"%@",model.publishTime == nil ? @"" : model.publishTime];
    self.lblReadNum.text = [NSString stringWithFormat:@"%@",model.readCount];
    for (int i = 0; i < model.imgURl.count; i++) {
        if (i == 0) {
            [self.imgViewTopicLeft setImageWithURL:[NSURL URLWithString:model.imgURl[0]] placeholderImage:[UIImage imageNamed:@"img_mopicture"]];
        } else if (i == 1) {
            [self.imgViewTopicCenter setImageWithURL:[NSURL URLWithString:model.imgURl[1]] placeholderImage:[UIImage imageNamed:@"img_mopicture"]];
        } else if (i == 2) {
            [self.imgViewTopicRight setImageWithURL:[NSURL URLWithString:model.imgURl[2]] placeholderImage:[UIImage imageNamed:@"img_mopicture"]];
        }
    }
    self.constraintImgHeight.constant = 72.0f / ratioScreenW;
    self.viewTopic.hidden = YES;
    if ([model.isTop isEqualToString:@"Y"]) {
        self.viewTopic.hidden = NO;
        self.lblTag.text = @"置顶";
        self.lblTag.textColor = RGBHex(qwColor7);
        self.imgViewTag.image = [UIImage imageNamed:@"info_bg_gray"];
    }
    if ([model.artType intValue] == 2) {
        self.viewTopic.hidden = NO;
        self.lblTag.text = @"专题";
        self.lblTag.textColor = RGBHex(qwColor2);
        self.imgViewTag.image = [UIImage imageNamed:@"info_bg_orange"];
    }
    
    self.separatorHidden = YES;
}
@end
