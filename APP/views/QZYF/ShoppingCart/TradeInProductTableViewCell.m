//
//  TradeInProductTableViewCell.m
//  APP
//
//  Created by garfield on 16/3/10.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "TradeInProductTableViewCell.h"
#import "MallCartModel.h"
#import "UIImageView+WebCache.h"


@implementation TradeInProductTableViewCell

+ (CGFloat)getCellHeight:(id)data
{
    return 112.0f;
}

- (void)setCell:(id)data
{
    CartRedemptionVoModel *model = (CartRedemptionVoModel *)data;
    _couponInformation.text = [NSString stringWithFormat:@"订单满%.2f元,可换购商品",model.limitPrice];
    [_productImageView setImageWithURL:[NSURL URLWithString:model.proImgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    _productName.text = model.proName;
    _specLabel.text = model.proSpec;
    _originPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.price];
    _couponValueLabel.text = [NSString stringWithFormat:@"￥%.2f",model.salePrice];
    if(model.currentConsume < model.limitPrice) {
        self.chooseIconImage.image = [UIImage imageNamed:@"img_notpoint"];
        
    }
}


@end
