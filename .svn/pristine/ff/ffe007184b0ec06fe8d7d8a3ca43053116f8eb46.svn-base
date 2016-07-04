//
//  CouponDrugTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"
#import "CouponModel.h"

@interface CouponDrugTableViewCell : QWBaseCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerConstant;

- (void)setCell:(pharmacyCouponDrug *)drug;

+ (CGFloat)getCellHeight:(id)data;

@end
