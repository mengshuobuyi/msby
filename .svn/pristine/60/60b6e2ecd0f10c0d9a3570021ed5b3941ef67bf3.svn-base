//
//  ConsultMedicineCell.m
//  wenyao
//
//  Created by chenzhipeng on 15/1/21.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "ConsultMedicineCell.h"
#import "StoreModel.h"
@implementation ConsultMedicineCel###必须l

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
    
    StoreNearByModel *modelStore = (StoreNearByModel *)data;
    self.lblTitle.text = [self checkStr:modelStore.shortName].length > 0 ? [self checkStr:modelStore.shortName] : [self checkStr:modelStore.name];
    self.lblDistance.text = [NSString stringWithFormat:@"%@ KM",modelStore.distance];
    self.separatorHidden = YES;
}

@end
