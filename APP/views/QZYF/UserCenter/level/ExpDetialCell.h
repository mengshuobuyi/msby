//
//  ExpDetialCell.h
//  APP
//
//  Created by qw_imac on 15/12/2.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditModel.h"
@interface ExpDetialCell : UITableViewCell

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topReset;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lowReset;
@property (strong, nonatomic) IBOutlet UILabel *needShopCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *needGrowthValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

+(CGFloat)cellHeight;
-(void)setUI;
-(void)setUiDetailWithVo:(MyLevelDetailVo *)vo;
@end
