//
//  PaymentTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/3/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PaymentTableViewCell.h"

@implementation PaymentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
