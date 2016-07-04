//
//  HealthCellStyleOne.m
//  APP
//
//  Created by PerryChen on 1/5/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "HealthCellStyleSmallImg.h"
#import "HealthinfoModel.h"
#import "UIImageView+WebCache.h"
@implementation HealthCellStyleSmallImg

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
    NSMutableAttributedString *strAttri = [[NSMutableAttributedString alloc] initWithString:model.title];
    self.lblTime.adjustsFontSizeToFitWidth = YES;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:6];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    [strAttri addAttribute:NSParagraphStyleAttributeName
                     value:style
                     range:NSMakeRange(0, strAttri.length)];
    self.lblHealthContent.attributedText = strAttri;
    self.lblTime.text = [NSString stringWithFormat:@"%@",model.publishTime == nil ? @"" : model.publishTime];
    self.lblReadNum.text = [NSString stringWithFormat:@"%@",model.readCount];
    if (model.imgURl.count > 0) {
        [self.imgViewContent setImageWithURL:[NSURL URLWithString:model.imgURl[0]] placeholderImage:[UIImage imageNamed:@"img_mopicture"]];
//        [self.imgViewContent setImage:[UIImage imageNamed:@"img_mopicture"]];
    }
    self.constraintImgHeight.constant = 72.0f / ratioScreenW;
    
    self.viewTop.hidden = YES;
    self.constraintTimeLead.constant = 20 + self.viewTop.frame.size.width;
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
    if ((![model.isTop isEqualToString:@"Y"])&&([model.artType intValue] != 2)) {
        self.constraintTimeLead.constant = 10;
    }
    self.separatorHidden = YES;
}

@end
