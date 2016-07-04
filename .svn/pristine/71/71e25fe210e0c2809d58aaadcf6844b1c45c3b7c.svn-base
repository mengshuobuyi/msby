//
//  PharmacyCell.m
//  APP
//
//  Created by carret on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "PharmacyCell.h"
#import "DrugModel.h"
@implementation PharmacyCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setCell:(id)data
{
    SimpleProductWithPromotionVOModel *model = (SimpleProductWithPromotionVOModel *)data;
    [super setCell:model];
    NSString *imgName = @"";
    if (model.gift) {
        
    }
    self.gift.image = [UIImage imageNamed:imgName];
    self.discount.image = [UIImage imageNamed:imgName];
    self.voucher.image = [UIImage imageNamed:imgName];
    self.special.image = [UIImage imageNamed:imgName];
}
@end
