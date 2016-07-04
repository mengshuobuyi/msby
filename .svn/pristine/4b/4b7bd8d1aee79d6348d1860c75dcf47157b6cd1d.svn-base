//
//  NewSettingTableCell.m
//  APP
//
//  Created by Martin.Liu on 15/12/2.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "NewSettingTableCell.h"

@implementation NewSettingTableCell

- (void)awakeFromNib {
    self.titleTextLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.titleTextLabel.textColor = RGBHex(qwColor6);
    
    self.contentDetailLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.contentDetailLabel.textColor = RGBHex(qwColor8);
}

- (void)setHiddenRightArrow:(BOOL)hiddenRightArrow
{
    _hiddenRightArrow = hiddenRightArrow;

    self.constraint_rightArrowTrailing.constant = _hiddenRightArrow ? - APP_W : 15;

        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
