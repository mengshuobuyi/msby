//
//  LocationInfoTableViewCell.m
//  APP
//
//  Created by qw_imac on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "LocationInfoTableViewCell.h"

@implementation LocationInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellWith:(AMapPOI *)poi AndNumber:(NSInteger)number {
    if (number == 0) {
        self.locationMap.hidden = NO;
        self.trailSpace.constant = 30.0;
        self.name.textColor = RGBHex(qwColor1);
        self.addressDetail.textColor = RGBHex(qwColor1);
    }else {
        self.locationMap.hidden = YES;
        self.trailSpace.constant = 15.0;
        self.name.textColor = RGBHex(qwColor6);
        self.addressDetail.textColor = RGBHex(qwColor8);
    }
    
    self.name.text = poi.name;
    self.addressDetail.text = poi.address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
