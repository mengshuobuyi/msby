//
//  ExpDetialCell.m
//  APP
//
//  Created by qw_imac on 15/12/2.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "ExpDetialCell.h"

@implementation ExpDetialCell

- (void)awakeFromNib {
    // Initialization code
}
+(CGFloat)cellHeight {
    return APP_W * (134.0/320.0);
}

-(void)setUI {
    float scale = -30.0/320;
    self.topReset.constant = APP_W * scale;
    self.lowReset.constant = APP_W * scale;
}
-(void)setUiDetailWithVo:(MyLevelDetailVo *)vo {
    self.needShopCountLabel.text = [NSString stringWithFormat:@"%d次",[vo.needShopCount integerValue]];
    self.needGrowthValueLabel.text = [NSString stringWithFormat:@"%d",[vo.needGrowthValue integerValue]];
    self.detailLabel.text = [NSString stringWithFormat:@"距下一等级V%d，还需",[vo.nextLevel integerValue]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
