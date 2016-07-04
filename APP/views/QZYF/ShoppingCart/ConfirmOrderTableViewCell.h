//
//  ConfirmOrderTableViewCell.h
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface ConfirmOrderTableViewCell : QWBaseTableCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNumLabel;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UILabel *comboNum;
@property (weak, nonatomic) IBOutlet UILabel *drugDes;




@property (weak, nonatomic) IBOutlet UILabel *combosPriceLabel;

@end
