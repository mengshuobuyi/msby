//
//  CouponDrugTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponSuitableTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CouponSuitableTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    
    return 85.0f;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)UIGlobal{
    [super UIGlobal];
    self.separatorHidden=YES;
    self.separatorLine.hidden=YES;
}

- (void)setCell:(CouponProductVoModel *)drug{
    [super setCell:drug];
    NSString *imgUrl = [NSString stringWithFormat:@"%@",drug.productLogo];
    [self.logoImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    self.nameLabel.text = drug.productName;
    self.ruleLabel.text = drug.spec;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
