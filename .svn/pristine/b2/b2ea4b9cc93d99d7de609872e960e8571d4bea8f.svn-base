//
//  CouponDrugTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"


@interface MyCouponDrugTableViewCell : QWBaseCell
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *expiredSoonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (assign, nonatomic) NSInteger type;//0表示已领取，1表示已使用，2表示已过期

+ (float)getCellHeight:(id)data;

- (void)setCell:(id)data;


@end
