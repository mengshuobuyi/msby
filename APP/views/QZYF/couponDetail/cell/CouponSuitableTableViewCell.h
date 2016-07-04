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

@interface CouponSuitableTableViewCell : QWBaseCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;

- (void)setCell:(CouponProductVoModel *)drug;

+ (CGFloat)getCellHeight:(id)data;

@end
