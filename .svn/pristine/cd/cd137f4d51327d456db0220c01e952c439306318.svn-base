//
//  HealthCellStyleOnlyText.m
//  APP
//
//  Created by PerryChen on 1/8/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "HealthCellStyleOnlyText.h"
#import "HealthinfoModel.h"
@implementation HealthCellStyleOnlyText

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setCell:(id)data
{
    MsgArticleVO *model = (MsgArticleVO *)data;
    self.lblHealthContent.font = fontSystem(kFontS2);
    self.lblHealthContent.textColor = RGBHex(qwColor6);
    self.lblTime.textColor = self.lblReadNum.textColor = RGBHex(qwColor7);
    self.contentView.backgroundColor = [UIColor whiteColor];
//    self.lblTime.textColor = self.lblReadNum.textColor = RGBHex(qwColor8);
    NSMutableAttributedString *strAttri = [[NSMutableAttributedString alloc] initWithString:model.title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:6];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    
    [strAttri addAttribute:NSParagraphStyleAttributeName
                     value:style
                     range:NSMakeRange(0, strAttri.length)];
    self.lblHealthContent.attributedText = strAttri;

    self.lblTime.text = [NSString stringWithFormat:@"%@",model.publishTime == nil ? @"" : model.publishTime];
    self.lblReadNum.text = [NSString stringWithFormat:@"%@",model.readCount];
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
    
    self.separatorHidden = YES;
}
@end
