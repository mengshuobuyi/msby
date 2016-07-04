//
//  DietTipsTableCell.h
//  APP
//
//  Created by garfield on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface DietTipsTableCell : QWBaseTableCell
@property (weak, nonatomic) IBOutlet UIImageView *contentBackgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *tipTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentOneLabel;

@end
