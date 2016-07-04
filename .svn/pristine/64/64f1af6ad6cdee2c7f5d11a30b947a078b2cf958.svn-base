//
//  PurchaseCell.m
//  APP
//
//  Created by qw_imac on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "PurchaseNewCell.h"
#import "ActivityModel.h"
#import "css.h"
#import "UIImageView+WebCache.h"
@implementation PurchaseNewCell

- (void)awakeFromNib {
    // Initialization code
    self.purchaseBtn.layer.cornerRadius = 3.0;
    self.purchaseBtn.layer.masksToBounds = YES;
//    self.sellProgress.layer.cornerRadius = 3.0;
//    self.sellProgress.layer.borderColor = RGBHex(qwColor2).CGColor;
//    self.sellProgress.layer.borderWidth = 0.5;
//    self.sellProgress.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCell:(id)data With:(NSString *)status{
    GrabPromotionProductVo *grabPromotionProduct = (GrabPromotionProductVo *)data;
    self.title.text = grabPromotionProduct.proName;
   
    if (StrIsEmpty(grabPromotionProduct.proDiscountPrice)) {      //容错处理，价格为空隐藏
        self.price.hidden = YES;
        self.rmbLabel.hidden = YES;
    }else{
        self.price.hidden = NO;
        self.rmbLabel.hidden = NO;
        self.price.text = grabPromotionProduct.proDiscountPrice;
    }
    if (StrIsEmpty(grabPromotionProduct.proCostPrice)) {  //容错处理，原价为空隐藏
        self.oldPrice.hidden = YES;
        self.line.hidden = YES;
    }else {
        self.oldPrice.hidden = NO;
        self.line.hidden = NO;
        self.oldPrice.text = [NSString stringWithFormat:@"￥%@",grabPromotionProduct.proCostPrice];
    }
    self.weight.text = grabPromotionProduct.spec;
//    float progress = [grabPromotionProduct.currentNum floatValue] / [grabPromotionProduct.totalNum floatValue] ;
//    
//      [self.sellProgress setProgress:progress animated:NO];
//
//    float per = [grabPromotionProduct.currentNum floatValue]* 100 / [grabPromotionProduct.totalNum floatValue];
//    NSInteger percent = ceilf(per) ;
    
//    self.sellPercent.text = [NSString stringWithFormat:@"已抢购%d%%",percent];
    
    [self.drugImage setImageWithURL:[NSURL URLWithString:grabPromotionProduct.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    
    self.end.hidden = YES;
//    self.sellPercent.hidden = NO;
//    self.sellProgress.hidden = NO;
    self.purchaseBtn.enabled = YES;
    switch ([status intValue]) {       //抢购活动状态
        case 1:                                          //抢购活动未开始
//            self.sellPercent.hidden = YES;
//            self.sellProgress.hidden = YES;
            [self.purchaseBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            [self.purchaseBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
            [self.purchaseBtn setBackgroundColor:[UIColor clearColor]];
            self.purchaseBtn.layer.borderWidth = 0.5;
            self.purchaseBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
            self.purchaseBtn.layer.masksToBounds = YES;
            break;
        case 2:                                          //抢购活动已开始
            [self.purchaseBtn setTitle:@"立即抢" forState:UIControlStateNormal];
            [self.purchaseBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
            [self.purchaseBtn setBackgroundColor:RGBHex(qwColor2)];
            if (grabPromotionProduct.status.intValue == 1) {    //已抢购
                [self.purchaseBtn setTitle:@"已抢购" forState:UIControlStateNormal];
                [self.purchaseBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
                [self.purchaseBtn setBackgroundColor:RGBHex(qwColor9)];
                self.purchaseBtn.enabled = NO;
            }
            if (grabPromotionProduct.currentNum.intValue == grabPromotionProduct.totalNum.intValue) {   //商品已经抢光
                self.end.hidden = NO;
//                self.sellProgress.hidden = YES;
//                self.sellPercent.hidden = YES;
                [self.purchaseBtn setTitle:@"已抢完" forState:UIControlStateNormal];
                [self.purchaseBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
                [self.purchaseBtn setBackgroundColor:RGBHex(qwColor9)];
                self.purchaseBtn.enabled = NO;
            }
            break;

        case 3:                                          //抢购活动已结束
            [self.purchaseBtn setTitle:@"已结束" forState:UIControlStateNormal];
            [self.purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.purchaseBtn setBackgroundColor:RGBHex(qwColor9)];
            self.purchaseBtn.enabled = NO;
            if ([grabPromotionProduct.currentNum intValue] == [grabPromotionProduct.totalNum intValue]) {  //活动结束且商品已抢光
                self.end.hidden = NO;
//                self.sellProgress.hidden = YES;
//                self.sellPercent.hidden = YES;
            }
            break;
    }
}
//微商抢购
-(void)setRushCell:(id)data With:(NSString *)status{
    RushProductVo *grabPromotionProduct = (RushProductVo *)data;
    self.title.text = grabPromotionProduct.proName;
    
    if (StrIsEmpty(grabPromotionProduct.proDiscountPrice)) {      //容错处理，价格为空隐藏
        self.price.hidden = YES;
        self.rmbLabel.hidden = YES;
    }else{
        self.price.hidden = NO;
        self.rmbLabel.hidden = NO;
        self.price.text = grabPromotionProduct.proDiscountPrice;
    }
    if (StrIsEmpty(grabPromotionProduct.proCostPrice)) {  //容错处理，原价为空隐藏
        self.oldPrice.hidden = YES;
        self.line.hidden = YES;
    }else {
        self.oldPrice.hidden = NO;
        self.line.hidden = NO;
        self.oldPrice.text = [NSString stringWithFormat:@"￥%@",grabPromotionProduct.proCostPrice];
    }
    self.weight.text = grabPromotionProduct.spec;
    float progress = [grabPromotionProduct.currentNum floatValue] / [grabPromotionProduct.totalNum floatValue] ;
    
//    [self.sellProgress setProgress:progress animated:NO];
    
//    float per = [grabPromotionProduct.currentNum floatValue]* 100 / [grabPromotionProduct.totalNum floatValue];
//    NSInteger percent = ceilf(per) ;
    
//    self.sellPercent.text = [NSString stringWithFormat:@"已抢购%d%%",percent];
    
    [self.drugImage setImageWithURL:[NSURL URLWithString:grabPromotionProduct.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    
    self.end.hidden = YES;
//    self.sellPercent.hidden = NO;
//    self.sellProgress.hidden = NO;
    self.purchaseBtn.enabled = YES;
    switch ([status intValue]) {       //抢购活动状态
        case 1:                                          //抢购活动未开始
//            self.sellPercent.hidden = YES;
//            self.sellProgress.hidden = YES;
            [self.purchaseBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            [self.purchaseBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
            [self.purchaseBtn setBackgroundColor:[UIColor clearColor]];
            self.purchaseBtn.layer.borderWidth = 0.5;
            self.purchaseBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
            self.purchaseBtn.layer.masksToBounds = YES;
            break;
        case 2:                                          //抢购活动已开始
            [self.purchaseBtn setTitle:@"立即抢" forState:UIControlStateNormal];
            [self.purchaseBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
            [self.purchaseBtn setBackgroundColor:RGBHex(qwColor2)];
//            if (grabPromotionProduct.grab) {    //已抢购
//                [self.purchaseBtn setTitle:@"已抢购" forState:UIControlStateNormal];
//                [self.purchaseBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
//                [self.purchaseBtn setBackgroundColor:RGBHex(qwColor9)];
//                self.purchaseBtn.enabled = NO;
//            }
            if (grabPromotionProduct.currentNum.intValue == grabPromotionProduct.totalNum.intValue) {   //商品已经抢光
                self.end.hidden = NO;
//                self.sellProgress.hidden = YES;
//                self.sellPercent.hidden = YES;
                [self.purchaseBtn setTitle:@"已抢完" forState:UIControlStateNormal];
                [self.purchaseBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
                [self.purchaseBtn setBackgroundColor:RGBHex(qwColor9)];
                self.purchaseBtn.enabled = NO;
            }
            break;
            
        case 3:                                          //抢购活动已结束
            [self.purchaseBtn setTitle:@"已结束" forState:UIControlStateNormal];
            [self.purchaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.purchaseBtn setBackgroundColor:RGBHex(qwColor9)];
            self.purchaseBtn.enabled = NO;
            if ([grabPromotionProduct.currentNum intValue] == [grabPromotionProduct.totalNum intValue]) {  //活动结束且商品已抢光
                self.end.hidden = NO;
//                self.sellProgress.hidden = YES;
//                self.sellPercent.hidden = YES;
            }
            break;
    }
}


+(float)returnCellHeight {
    return 113.0;
}
@end
