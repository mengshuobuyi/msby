//
//  CombosMiddleCartTableViewCell.h
//  APP
//
//  Created by garfield on 16/3/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseCell.h"
#import "MGSwipeTableCell.h"

@interface CombosMiddleCartTableViewCell : MGSwipeTableCell

@property (nonatomic, strong) IBOutlet  UILabel         *productNameLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *specLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *priceLabel;
@property (nonatomic, strong) IBOutlet  UIImageView     *productImageView;
@property (nonatomic, weak)   id                        obj;

@end
