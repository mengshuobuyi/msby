//
//  ResultBranchTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@interface ResultBranchTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceConstant;

+ (CGFloat)getCellHeight:(MicroMallBranchVo *)data;
- (void)setCell:(MicroMallBranchVo *)model;

@end
