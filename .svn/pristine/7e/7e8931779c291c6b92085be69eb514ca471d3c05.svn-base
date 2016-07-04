//
//  CouponDrugTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponDrugTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CouponDrugTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    
    return 104.0f;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)UIGlobal{
    [super UIGlobal];
    self.separatorHidden=YES;
    self.separatorLine.hidden=YES;
}

- (void)setCell:(pharmacyCouponDrug *)drug{
    
    [self.logoImage setImageWithURL:[NSURL URLWithString:drug.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    self.nameLabel.text = drug.proName;
    self.ruleLabel.text = drug.spec;
    self.promotionLabel.text = drug.factory;
    self.priceLabel.text = drug.label;

    self.nameLabel.textColor = RGBHex(qwColor6);
    self.ruleLabel.textColor = RGBHex(qwColor9);
    self.promotionLabel.textColor = RGBHex(qwColor7);
    self.priceLabel.textColor = RGBHex(qwColor2);
    
    CGSize sz;
    CGRect frm;
    
    self.promotionLabel.translatesAutoresizingMaskIntoConstraints = YES;
    frm=self.promotionLabel.frame;
    sz=[GLOBALMANAGER sizeText:self.priceLabel.text font:self.priceLabel.font limitHeight:self.priceLabel.bounds.size.height];
    frm.size.width = CGRectGetWidth(self.frame)-CGRectGetMinX(self.promotionLabel.frame) - sz.width-16;
    frm.origin.y=CGRectGetMaxY(self.ruleLabel.frame )+6;
    self.promotionLabel.frame=frm;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
