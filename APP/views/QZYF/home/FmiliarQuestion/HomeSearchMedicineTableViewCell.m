//
//  HomeSearchMedicineTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "HomeSearchMedicineTableViewCell.h"

@implementation HomeSearchMedicineTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    
    return 120.0f;
}

- (void)awakeFromNib {
    // Initialization code
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 119.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end