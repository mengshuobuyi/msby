//
//  IndentCell.h
//  APP
//
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdersModel.h"
@interface IndentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *telBtn;
@property (weak, nonatomic) IBOutlet UIImageView *firstDrugImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondDrugImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdDrugImg;
@property (weak, nonatomic) IBOutlet UIImageView *lastDrugImg;
@property (weak, nonatomic) IBOutlet UILabel *postStyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkPostBtn;
@property (weak, nonatomic) IBOutlet UIButton *consigneeBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

-(void)cellSetWith:(MicroMallOrderVO *)vo;
+(CGFloat)setHeight;
@end
