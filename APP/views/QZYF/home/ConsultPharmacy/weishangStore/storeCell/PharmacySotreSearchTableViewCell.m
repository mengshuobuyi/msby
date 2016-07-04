//
//  PharmacySotreSearchTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/1/5.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PharmacySotreSearchTableViewCell.h"

@implementation PharmacySotreSearchTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    
    return 55.0f;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCell:(MicroMallBranchVo *)model{
    
    
    self.mainAddressLabel.text = model.branchName;
    self.detailAddressLabel.text = model.branchAddress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
