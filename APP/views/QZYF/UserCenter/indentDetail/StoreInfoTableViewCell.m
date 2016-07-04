//
//  StoreInfoTableViewCell.m
//  APP
//
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "StoreInfoTableViewCell.h"

@implementation StoreInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.leadspace.constant = 100 * APP_W /320;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
