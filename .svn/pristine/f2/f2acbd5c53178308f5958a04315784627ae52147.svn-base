//
//  ConfrimOrderAddressTableViewCell.m
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ConfrimOrderAddressTableViewCell.h"
#import "ReceiveAddress.h"
@implementation ConfrimOrderAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCell:(id)data with:(BOOL)avilible
{
    AddressVo *model = (AddressVo *)data;
    if(model.id && ![model.id isEqualToString:@""]) {
        self.hintLabel.hidden = YES;
        self.hintInfoLabel.hidden = YES;
        self.addressLabel.hidden = NO;
        self.phoneNumLabel.hidden = NO;
        self.userNameLabel.hidden = NO;
        self.placeHolderLabel.hidden = NO;
        self.addressLabel.text = [NSString stringWithFormat:@"收货地址:%@",model.address];
        self.phoneNumLabel.text = model.mobile;
        self.userNameLabel.text = model.nick;
        
    }else{
        self.hintLabel.hidden = NO;
        self.hintInfoLabel.hidden = NO;
        self.addressLabel.hidden = YES;
        self.phoneNumLabel.hidden = YES;
        self.userNameLabel.hidden = YES;
        self.placeHolderLabel.hidden = YES;
        self.addressLabel.text = @"";
        self.phoneNumLabel.text = @"";
        self.userNameLabel.text = @"";
    }
    if (avilible) {
        self.cover.hidden = YES;
        self.userInteractionEnabled = YES;
           self.img.image = [UIImage imageNamed:@"img_bg_address"];
        self.hintLabel.textColor = RGBHex(qwColor6);
        self.hintInfoLabel.textColor = RGBHex(qwColor8);
        self.addressLabel.textColor = RGBHex(qwColor6);
        self.phoneNumLabel.textColor = RGBHex(qwColor6);
        self.userNameLabel.textColor = RGBHex(qwColor6);
        self.placeHolderLabel.textColor = RGBHex(qwColor6);

    }else {
        self.cover.hidden = NO;
        self.userInteractionEnabled = NO;
        self.hintLabel.textColor = RGBHex(qwColor9);
        self.hintInfoLabel.textColor = RGBHex(qwColor9);
        self.addressLabel.textColor = RGBHex(qwColor9);
        self.phoneNumLabel.textColor = RGBHex(qwColor9);
        self.userNameLabel.textColor = RGBHex(qwColor9);
        self.placeHolderLabel.textColor = RGBHex(qwColor9);
        self.img.image = [UIImage imageNamed:@"img_bg_address_gray"];
    }
}

+ (CGFloat)getCellHeight:(id)data
{
    return 88.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
