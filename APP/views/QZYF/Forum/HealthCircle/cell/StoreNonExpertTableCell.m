//
//  StoreNonExpertTableCell.m
//  APP
//
//  Created by Martin.Liu on 16/6/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "StoreNonExpertTableCell.h"
@interface StoreNonExpertTableCell()

@property (strong, nonatomic) IBOutlet UIView *myContainerView;

@end

@implementation StoreNonExpertTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.gotoOtherCircleBtn.layer.masksToBounds = YES;
    self.gotoOtherCircleBtn.layer.cornerRadius = 2;
    self.gotoOtherCircleBtn.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
    self.gotoOtherCircleBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
    
    self.gotoOtherCircleBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS1];
    [self.gotoOtherCircleBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    
    self.myContainerView.layer.masksToBounds = YES;
    self.myContainerView.layer.cornerRadius = 4;
    self.myContainerView.layer.borderWidth = 2;
    self.myContainerView.layer.borderColor = RGBHex(qwColor10).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
