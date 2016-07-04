//
//  winInfoCell.m
//  APP
//
//  Created by qw_imac on 15/11/10.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "winInfoCell.h"
#import "ActivityModel.h"
@implementation winInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCell:(id)data {
    LuckdrWonAwardVo *vo = (LuckdrWonAwardVo *)data;
    self.winTitle.text = vo.title;
    self.winSource.text = vo.desc;
    self.winDate.text = vo.date;
}
@end
