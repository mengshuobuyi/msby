//
//  AddAddressTableViewCell.m
//  APP
//
//  Created by qw_imac on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "AddAddressTableViewCell.h"
#import "ShippingAdrModel.h"
#import "QWGlobalManager.h"
@implementation AddAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.name.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"收货人姓名" attributes:@{NSForegroundColorAttributeName:RGBHex(qwColor9)}];
    self.tel.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"收货人手机号码" attributes:@{NSForegroundColorAttributeName:RGBHex(qwColor9)}];
    self.location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"小区/写字楼/学校等" attributes:@{NSForegroundColorAttributeName:RGBHex(qwColor9)}];
    self.addressInfo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"完善详细地址，如门牌/楼层" attributes:@{NSForegroundColorAttributeName:RGBHex(qwColor9)}];
}

- (IBAction)selectSex:(UIButton *)sender {
    //性别默认给M
    switch (sender.tag) {
        case 1:
            [sender setSelected:!sender.isSelected];
            [self.womenBtn setSelected:NO];
            break;
        case 2:
            [sender setSelected:!sender.isSelected];
            [self.menBtn setSelected:NO];
            break;
    }
    NSString *sex;
    if (_womenBtn.isSelected) {
        sex = @"F";
    }
    if (_menBtn.isSelected) {
        sex = @"M";
    }
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"性别"]=sex;
    [QWGLOBALMANAGER statisticsEventId:@"x_tjdz_xb" withLable:@"添加地址" withParams:tdParams];
}

- (void)setCell:(id)data
{
    ShippingAdrModel *modelAdr = (ShippingAdrModel *)data;
    self.name.text = modelAdr.name;
    self.tel.text = modelAdr.tel;
    self.addressInfo.text = modelAdr.addressDetail;
    self.menBtn.selected = self.womenBtn.selected = NO;
    if(modelAdr.gender){
        if ([modelAdr.gender isEqualToString:@"M"]) {
            self.menBtn.selected = YES;
        } else if ([modelAdr.gender isEqualToString:@"F"]) {
            self.womenBtn.selected = YES;
        }
    }else {
        self.menBtn.selected = YES;
    }
    self.city.text = modelAdr.city;
    self.location.text = modelAdr.village;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
