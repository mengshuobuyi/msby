//
//  WYChooseMyDrug.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/15.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "WYChooseMyDrugCell.h"
#import "WYChooseMyDrugModel.h"
@implementation WYChooseMyDrugCell

+ (CGFloat)getCellHeight:(id)obj{
    return 53;
}

- (void)UIGlobal{
    [super UIGlobal];
    
    self.productName.textColor=RGBHex(qwColor6);
    
    
}

- (void)setCell:(id)data{
    [super setCell:data];
    if ([data isKindOfClass:[WYChooseMyDrugModel class]]) {
        WYChooseMyDrugModel *mode=data;
        
        self.btnChoose.selected=mode.chooseEnabled;
    }
}
@end
