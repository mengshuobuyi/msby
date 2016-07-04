//
//  ProductOrderCell.m
//  wenyao
//
//  Created by Meng on 15/1/22.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "ProductOrderCell.h"
#import "PromotionOrderModel.h"

@implementation ProductOrderCell
+ (CGFloat)getCellHeight:(id)data{
    return 110.0f;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    CGRect rect = self.line.frame;
    rect.size.height = 0.5f;
    self.line.frame = rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCell:(id)data{
    [super setCell:data];
    
    PromotionOrderModel *order = (PromotionOrderModel *)data;
    NSString *type = [NSString stringWithFormat:@"%@",order.type];
    NSString *typeStr = nil;
    NSString *couponStr = nil;
    
    if ([type isEqualToString:@"1"]) {
        typeStr = @"折扣";
        couponStr = [NSString stringWithFormat:@"（优惠%.2f元）",[order.discount floatValue]];
    }else if ([type isEqualToString:@"2"]){
        typeStr = @"抵现";
        couponStr = [NSString stringWithFormat:@"（优惠%.2f元）",[order.discount floatValue]];
    }else if ([type isEqualToString:@"3"]){
        typeStr = @"买赠";
        couponStr = [NSString stringWithFormat:@"（赠送%d件商品）",[order.totalLargess intValue]];
    }
    self.type.text = typeStr;
    self.couponStr.text = couponStr;

}

-(void)UIGlobal{
    [super UIGlobal];
   
    [self setSelectedBGColor:RGBHex(qwColor10)];
}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    [super setHighlighted:highlighted animated:animated];
//    if (highlighted) {
//        
//        self.bgContent.backgroundColor = RGBAHex(kColor6, 0.3);
//        
//    }else
//    {
//        self.bgContent.backgroundColor = [UIColor clearColor];
//    }
//}

@end
