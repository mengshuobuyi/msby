//
//  ReceiverAddressCell.m
//  APP
//
//  Created by qw_imac on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "ReceiverAddressCell.h"

@implementation ReceiverAddressCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWith:(AddressVo *)vo {
    self.receiverName.text = vo.nick;
    self.address.text = [NSString stringWithFormat:@"%@%@",vo.village,vo.address];
    self.phoneNumber.text = vo.mobile;
    if ([vo.flagDefault isEqualToString:@"Y"]) {
        _defaultImg.hidden = NO;
    }else {
        _defaultImg.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
