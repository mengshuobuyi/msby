//
//  CombosMiddleCartTableViewCell.m
//  APP
//
//  Created by garfield on 16/3/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CombosMiddleCartTableViewCell.h"
#import "MallCartModel.h"
#import "UIImageView+WebCache.h"

@implementation CombosMiddleCartTableViewCell

+ (CGFloat)getCellHeight:(id)data
{
    return 72.0f;
}

- (void)setCell:(id)data
{
    ComboProductVoModel *productModel = (ComboProductVoModel *)data;
    self.separatorLine.hidden = YES;
    _productNameLabel.text = [NSString stringWithFormat:@"%@*%d",productModel.name,productModel.count];
    _specLabel.text = productModel.spec;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f*%d",productModel.price,productModel.count];
    [_productImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    _obj = data;
}

@end
