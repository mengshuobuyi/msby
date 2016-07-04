//
//  DetialRullCell.m
//  APP
//
//  Created by qw_imac on 15/12/2.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "DetialRullCell.h"

@implementation DetialRullCell

-(void)setDetailUiWith:(MyLevelDetailVo *)vo {
    for(int index = 0;index < vo.upgradeRules.count;index ++) {
        UILabel *label = self.LabelOne[index];
        label.hidden = NO;
        label.attributedText = [self transform:vo.upgradeRules[index]];
    }
}

-(NSAttributedString *)transform:(NSString *)str {
    NSMutableAttributedString *muString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragtapStyle = [[NSMutableParagraphStyle alloc]init];
    paragtapStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *dic = @{NSForegroundColorAttributeName:RGBHex(qwColor7),
                          NSFontAttributeName:fontSystem(kFontS5),
                          NSParagraphStyleAttributeName:paragtapStyle,
                          NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
    [muString setAttributes:dic range:NSMakeRange(0, muString.length)];
    NSAttributedString *attrStr = [muString copy];
    return attrStr;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
