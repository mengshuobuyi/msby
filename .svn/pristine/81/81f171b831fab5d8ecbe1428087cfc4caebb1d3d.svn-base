//
//  NewEditAddressCell.m
//  APP
//
//  Created by qw_imac on 16/3/25.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewEditAddressCell.h"

#import "QWGlobalManager.h"
@implementation NewEditAddressCell

- (void)awakeFromNib {
    // Initialization code
    self.womenBtn.layer.cornerRadius = 14.0;
    self.womenBtn.layer.masksToBounds = YES;
    
    self.manBtn.layer.cornerRadius = 14.0;
    self.manBtn.layer.masksToBounds = YES;
}
- (IBAction)selectSex:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [sender setSelected:!sender.isSelected];
            [self.womenBtn setSelected:NO];
            break;
        case 2:
            [sender setSelected:!sender.isSelected];
            [self.manBtn setSelected:NO];
            break;
    }
    [self setSex];
}

-(void)setSex {
    NSString *sex;
    if (_womenBtn.isSelected) {
        sex = @"F";
        [_womenBtn setBackgroundColor:[UIColor colorWithRed:241.0/255.0 green:196.0/255.0 blue:197.0/255.0 alpha:1]];
        [_womenBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
        [_manBtn setBackgroundColor:RGBHex(qwColor4)];
        [_manBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
        _manBtn.layer.borderWidth = 1.0;
        _manBtn.layer.borderColor = RGBHex(qwColor11).CGColor;
        _womenBtn.layer.borderWidth = 0.0;
    }
    if (_manBtn.isSelected) {
        sex = @"M";
        [_manBtn setBackgroundColor:[UIColor colorWithRed:168.0/255.0 green:209.0/255.0 blue:237.0/255.0 alpha:1]];
        [_manBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
        [_womenBtn setBackgroundColor:RGBHex(qwColor4)];
        [_womenBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
        _womenBtn.layer.borderWidth = 1.0;
        _womenBtn.layer.borderColor = RGBHex(qwColor11).CGColor;
        _manBtn.layer.borderWidth = 0.0;
    }
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"性别"]=sex;
    [QWGLOBALMANAGER statisticsEventId:@"x_tjdz_xb" withLable:@"添加地址" withParams:tdParams];
}

-(void)setCell:(ShippingAdrModel *)model {
    self.nameTX.text = model.name;
    self.telTX.text = model.tel;
    self.cityName.text = model.city;
    self.locationTx.text = model.village;
    self.addressTX.text = model.addressDetail;
    self.manBtn.selected = self.womenBtn.selected = NO;
    if(model.gender){
        if ([model.gender isEqualToString:@"M"]) {
            self.manBtn.selected = YES;
        } else if ([model.gender isEqualToString:@"F"]) {
            self.womenBtn.selected = YES;
        }
    }else {
        self.manBtn.selected = YES;
    }
    [self setSex];
}

@end
