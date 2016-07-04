//
//  HealthCellStyleTwo.m
//  APP
//
//  Created by PerryChen on 1/5/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "HealthCellStyleLargeImg.h"
#import "HealthinfoModel.h"
#import "UIImageView+WebCache.h"
@implementation HealthCellStyleLargeImg

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
    self.lblTime.text = [NSString stringWithFormat:@"%@",model.publishTime == nil ? @"" : model.publishTime];;
    self.lblReadNum.text = [NSString stringWithFormat:@"%@",model.readCount];
    if (model.imgURl.count > 0) {
        [self.imgViewContent setImageWithURL:[NSURL URLWithString:model.imgURl[0]] placeholderImage:[UIImage imageNamed:@"img_mopicturebig"]];
//        [self.imgViewContent setImage:[UIImage imageNamed:@"img_mopicturebig"]];
    }
    self.constraintImgHeight.constant = 100.0f / ratioScreenW;
    self.constraintImgWidth.constant = 2.9 * (100.0f / ratioScreenW);
    [self.imgViewContent setNeedsLayout];
    [self.imgViewContent layoutIfNeeded];
    self.viewTop.hidden = YES;
    if ([model.isTop isEqualToString:@"Y"]) {
        self.viewTop.hidden = NO;
        self.lblTag.text = @"置顶";
        self.lblTag.textColor = RGBHex(qwColor7);
        self.imgViewTag.image = [UIImage imageNamed:@"info_bg_gray"];
    }
    if ([model.artType intValue] == 2) {
        self.viewTop.hidden = NO;
        self.lblTag.text = @"专题";
        self.lblTag.textColor = RGBHex(qwColor2);
        self.imgViewTag.image = [UIImage imageNamed:@"info_bg_orange"];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.separatorHidden = YES;
}

@end
