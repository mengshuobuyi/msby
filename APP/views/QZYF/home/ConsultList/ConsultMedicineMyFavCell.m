//
//  ConsultMedicineMyFavCell.m
//  wenyao
//
//  Created by chenzhipeng on 15/3/3.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "ConsultMedicineMyFavCell.h"
#import "FavoriteModel.h"

@implementation ConsultMedicineMyFavCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)checkStr:(id)obj
{
    if (([obj isKindOfClass:[NSString class]])&&[(NSString *)obj length]>0) {
        return (NSString *)obj;
    } else {
        return @"";
    }
}

- (void)setCell:(id)data
{
    [super setCell:data];
    
    MyFavStoreModel *modelFav = (MyFavStoreModel *)data;
    self.lblTitle.text = [self checkStr:modelFav.shortName].length > 0 ? [self checkStr:modelFav.shortName] : [self checkStr:modelFav.name];
    self.separatorHidden = YES;
}

@end
