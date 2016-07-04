//
//  medicineTableViewCell.m
//  wenyao
//
//  Created by 李坚 on 14/12/8.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MedicineSellListCell.h"
#import "DrugModel.h"
#import "UIImageView+WebCache.h"

@implementation MedicineSellListCell
@synthesize tag=tag;
+ (CGFloat)getCellHeight:(id)data
{
    return 95.0f;
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)UIGlobal
{
    [super UIGlobal];
    
    self.tag.layer.borderWidth = 0.5f;
    self.tag.layer.borderColor = RGBHex(qwColor10).CGColor;
    
    self.proName.textColor = RGBHex(qwColor7);
    self.proName.font = font(kFont2, 15);
    self.spec.textColor = RGBHex(qwColor8);
    self.spec.font = fontSystem(kFontS4);
    self.factory.textColor = RGBHex(qwColor8);
    self.factory.font = fontSystem(kFontS4);

}

- (void)setCell:(id)data
{
    if ([data isKindOfClass:[DrugSellWellProductsFactoryModel class]]) {
        [super setCell:data];
        DrugSellWellProductsFactoryModel *factoryModel = (DrugSellWellProductsFactoryModel *)data;
//        NSString* imgurl = PORID_IMAGE(factoryModel.proId);
        [self.proImage setImageWithURL:[NSURL URLWithString:factoryModel.imgUrl]
                           placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
        NSString *str = [NSString stringWithFormat:@"NO.%d.png",self.indexPath.row +1];
        self.numberImage.image = [UIImage imageNamed:str];
        
        //if (!factoryModel.tag || [factoryModel.tag isEqualToString:@""]) {
        if(StrIsEmpty(factoryModel.tag)){
            self.tag.hidden = YES;
        }else{
            self.tag.hidden = NO;
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
