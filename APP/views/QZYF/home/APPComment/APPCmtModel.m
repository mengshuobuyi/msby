//
//  APPCmtModel.m
//  APP
//
//  Created by Yan Qingyang on 15/8/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "APPCmtModel.h"

@implementation APPCmtModel
- (id)init
{
    self = [super init];
    if (self) {
        self.isClicked=@"0";
        self.hadConsult = @"0";
        self.useCoupon=@"0";
        self.useGoods=@"0";
    }
    return self;
}
@end
