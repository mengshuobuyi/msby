//
//  RedemptionCartTableViewCell.h
//  APP
//
//  Created by garfield on 16/3/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseCell.h"
#import "MGSwipeTableCell.h"


@interface RedemptionCartTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productNum;
@property (weak, nonatomic) IBOutlet QWButton *decreaseButton;
@property (weak, nonatomic) IBOutlet QWButton *increaseButton;

@property (weak, nonatomic) IBOutlet QWButton *decreaseBigButton;
@property (weak, nonatomic) IBOutlet QWButton *increaseBigButton;

@property (weak, nonatomic) IBOutlet QWButton *chooseButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *promotionIcon;
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;
@property (weak, nonatomic) IBOutlet UIView     *touchCover;

@end
