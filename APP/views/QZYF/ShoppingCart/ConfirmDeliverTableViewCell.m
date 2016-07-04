//
//  ConfirmDeliverTableViewCell.m
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ConfirmDeliverTableViewCell.h"

@implementation ConfirmDeliverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (CGFloat)getCellHeight:(id)data
{
    return 44;
}

- (void)UIGlobal{
    [super UIGlobal];
    self.separatorLine.hidden = YES;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
