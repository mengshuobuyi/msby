//
//  PackageShower.m
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PackageShower.h"
#import "UIImageView+WebCache.h"

@implementation PackageShower

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;

    
}

- (void)setShowerView:(ComboProductVo *)product{
    
    self.comboProduct = product;
    self.proName.text = product.name;
    self.proPrice.text = [NSString stringWithFormat:@"原价：￥%.1f",[product.price doubleValue]];
    [self.proImageView setImageWithURL:[NSURL URLWithString:product.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    [self.selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectAction:(id)sender{
    
    if(_selectedBlock){
        _selectedBlock(self.comboProduct.branchProId);
    }
}

@end
