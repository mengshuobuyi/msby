//
//  CombosShowOneCartTableViewCell.m
//  APP
//
//  Created by garfield on 16/3/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CombosShowOneCartTableViewCell.h"
#import "MallCartModel.h"
#import "UIImageView+WebCache.h"

@implementation CombosShowOneCartTableViewCell

+ (CGFloat)getCellHeight:(id)data
{
    return 140.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.productNum.layer.borderWidth = 1.0;
    self.productNum.layer.borderColor = RGB(210, 210, 210).CGColor;
    self.proNumText.layer.borderWidth = 1.0;
    self.proNumText.layer.borderColor = RGBHex(qwColor10).CGColor;
    
    _increaseButton.layer.borderWidth = 1;
    _increaseButton.layer.cornerRadius = 3.0f;
    _increaseButton.layer.masksToBounds = YES;
    _increaseButton.layer.borderColor = RGBHex(qwColor10).CGColor;
    _decreaseButton.layer.borderWidth = 1;
    _decreaseButton.layer.cornerRadius = 3.0f;
    _decreaseButton.layer.masksToBounds = YES;
    _decreaseButton.layer.borderColor = RGBHex(qwColor10).CGColor;
}

- (void)setCell:(id)data
{
    ComboProductVoModel *productModel = (ComboProductVoModel *)data;
    _combosTitleLabel.text = [NSString stringWithFormat:@"套餐价￥%.2f,已减￥%.2f",productModel.combosPrice,productModel.reduce * productModel.quantity];
    _productNameLabel.text = [NSString stringWithFormat:@"%@*%d",productModel.name,productModel.count];
    _specLabel.text = productModel.spec;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f*%d",productModel.price,productModel.count];
//    _productNum.text = [NSString stringWithFormat:@"%d",productModel.quantity];
    self.proNumText.text = [NSString stringWithFormat:@"%d",productModel.quantity];
    [_productImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    _combosPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",productModel.combosPrice];
    if(productModel.choose) {
        [self.chooseButton setImage:[UIImage imageNamed:@"icon_shopping_selected"] forState:UIControlStateNormal];
    }else{
        [self.chooseButton setImage:[UIImage imageNamed:@"icon_shopping_rest"] forState:UIControlStateNormal];
    }
    _obj = data;
    [self.contentView sendSubviewToBack:self.topColorCover];
}

- (void)associateWithModel:(id)model
                    target:(id)target
                 indexPath:(NSIndexPath *)indexPath
{
    self.chooseButton.obj = model;
    self.increaseButton.obj = model;
    self.decreaseButton.obj = model;
    self.proNumText.delegate = target;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.chooseButton addTarget:target action:@selector(chooseSingleCombos:) forControlEvents:UIControlEventTouchUpInside];
    [self.increaseButton addTarget:target action:@selector(increaseProductNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.decreaseButton addTarget:target action:@selector(decreaseProductNum:) forControlEvents:UIControlEventTouchUpInside];
    self.decreaseButton.tag = indexPath.row;
    self.increaseButton.tag = indexPath.row;
    self.chooseButton.tag = indexPath.row;
    
    [self.increaseBigButton addTarget:target action:@selector(increaseProductNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.decreaseBigButton addTarget:target action:@selector(decreaseProductNum:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.proNumText addTarget:target action:@selector(inputProNum:) forControlEvents:UIControlEventEditingChanged];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 50)];
    view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:241.0/255.0 blue:242.0/255.0 alpha:1];
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 40, 50)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGBHex(qwColor6) forState:UIControlStateNormal];
    [cancelBtn addTarget:target action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    QWButton *ensureBtn = [[QWButton alloc]initWithFrame:CGRectMake(APP_W - 55, 0, 40, 50)];
    ensureBtn.obj = model;
    ensureBtn.tag = indexPath.row;
    [ensureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:RGBHex(qwColor12) forState:UIControlStateNormal];
    [ensureBtn addTarget:target action:@selector(confirmEdit:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:ensureBtn];
    self.proNumText.inputAccessoryView = view;
#pragma clang diagnostic pop
    self.increaseBigButton.obj = model;
    self.decreaseBigButton.obj = model;
    self.decreaseBigButton.tag = indexPath.row;
    self.increaseBigButton.tag = indexPath.row;
    
}

@end
