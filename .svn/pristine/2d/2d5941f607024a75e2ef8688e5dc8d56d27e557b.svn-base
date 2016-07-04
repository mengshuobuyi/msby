//
//  DiseaseSubCell.m
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DiseaseSubCell.h"

@implementation DiseaseSubCell
@synthesize name = name;

+ (CGFloat)getCellHeight:(id)data{
    return 40;
}


- (void)UIGlobal{
    [super UIGlobal];
    
    self.contentView.backgroundColor = RGBHex(qwColor11);
    self.bgImageView.backgroundColor = RGBHex(qwColor11);
    
    [self.bgImageView setImage:nil];
    
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.name.font = fontSystem(kFontS1);
    self.name.textColor = RGBHex(qwColor6);
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(self.name.frame.origin.x, 40 - 0.5, 500, 0.5)];
    line1.backgroundColor = RGBHex(qwColor10);
    [self.contentView addSubview:line1];
    
    self.selectedBackgroundView = [[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
    
}




@end
