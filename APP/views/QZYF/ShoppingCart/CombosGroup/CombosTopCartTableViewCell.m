//
//  CombosTopCartTableViewCell.m
//  APP
//
//  Created by garfield on 16/3/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CombosTopCartTableViewCell.h"
#import "MallCartModel.h"
#import "UIImageView+WebCache.h"

@implementation CombosTopCartTableViewCell

+ (CGFloat)getCellHeight:(id)data
{
    return 105.0f;
}

- (void)setCell:(id)data
{
    ComboProductVoModel *productModel = (ComboProductVoModel *)data;
    self.separatorLine.hidden = YES;
    _combosLabel.text = [NSString stringWithFormat:@"套餐价￥%.2f,已减￥%.2f",productModel.combosPrice,productModel.reduce * productModel.quantity];
    _productNameLabel.text = [NSString stringWithFormat:@"%@*%d",productModel.name,productModel.count];
    _specLabel.text = productModel.spec;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f*%ld",productModel.price,(long)productModel.count];
    [_productImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    _obj = data;
    [self.contentView sendSubviewToBack:self.topColorCover];
}


@end
