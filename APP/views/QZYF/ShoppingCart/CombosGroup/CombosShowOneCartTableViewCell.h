//
//  CombosShowOneCartTableViewCell.h
//  APP
//
//  Created by garfield on 16/3/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseCell.h"
#import "MGSwipeTableCell.h"

@interface CombosShowOneCartTableViewCell : MGSwipeTableCell

@property (nonatomic, strong) IBOutlet  UILabel         *productNameLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *specLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *priceLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *combosTitleLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *combosPriceLabel;
@property (nonatomic, strong) IBOutlet  UIImageView     *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNum;

@property (weak, nonatomic) IBOutlet UIView *topColorCover;

@property (weak, nonatomic) IBOutlet QWButton *decreaseButton;
@property (weak, nonatomic) IBOutlet QWButton *increaseButton;

@property (weak, nonatomic) IBOutlet QWButton *decreaseBigButton;
@property (weak, nonatomic) IBOutlet QWButton *increaseBigButton;
@property (weak, nonatomic) IBOutlet QWButton *chooseButton;
@property (nonatomic, weak)   id                        obj;
@property (weak, nonatomic) IBOutlet UITextField *proNumText;

- (void)associateWithModel:(id)model
                    target:(id)target
                 indexPath:(NSIndexPath *)indexPath;

@end
