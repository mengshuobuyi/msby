//
//  TradeInProductTableViewCell.h
//  APP
//
//  Created by garfield on 16/3/10.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface TradeInProductTableViewCell : QWBaseTableCell

@property (weak, nonatomic) IBOutlet UIImageView *couponIconImage;
@property (weak, nonatomic) IBOutlet UILabel *couponInformation;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseIconImage;

@end
