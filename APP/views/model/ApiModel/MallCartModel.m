//
//  MallCartModel.m
//  APP
//
//  Created by garfield on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MallCartModel.h"

@implementation CartPackageList

@end
@implementation CartPackageVO

@end
@implementation CartPackageDrugVO

@end
@implementation MallCartModel

@end

@implementation CartVoModel
@end

@implementation CartBranchVoModel
@end

@implementation CartProductVoModel
@end

@implementation PayTypeVoModel

@end

@implementation CartPromotionVoModel

@end

@implementation MicroMallCartPreviewVoModel

@end

@implementation DeliveryTypeVoModel

-(NSInteger)chooseType {
    if (_chooseType == 0) {
        _chooseType = 1;
    }
    return _chooseType;
}
@end

@implementation CartComboVoModel

@end

@implementation ComboProductVoModel


@end

@implementation CartOnlineCouponVoModel


@end


@implementation CartRedemptionVoModel

@end

@implementation ChooseStatusModel

+ (NSString *)getPrimaryKey
{
    return @"objId";
}

@end

@implementation ProductTabooVoModel

@end

@implementation ProFoodTabooListVoModel

@end


@implementation MicroMallCartCompleteVoModel


@end