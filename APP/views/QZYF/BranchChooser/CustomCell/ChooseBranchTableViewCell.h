//
//  ChooseBranchTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"
#import "Coupon.h"

@interface ChooseBranchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *branchImg;
@property (weak, nonatomic) IBOutlet UILabel *branchNameLabel;
@property (weak, nonatomic) IBOutlet UIView *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

+ (CGFloat)getCellHeight:(id)data;
- (void)setCell:(MicroMallBranchVo *)model;

@end
