//
//  DiseaseVikiCell.m
//  APP
//
//  Created by qwfy0006 on 15/3/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DiseaseVikiCell.h"
#import "DiseaseModel.h"

@implementation DiseaseVikiCell
@synthesize name=name;

+ (CGFloat)getCellHeight:(id)data{
    return 45;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)Style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:Style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.name = [[QWLabel alloc] initWithFrame:CGRectMake(13, 0, 320, 45)];
        self.name.font = fontSystem(kFontS3);
        self.name.textColor = RGBHex(qwColor6);
        [self.contentView addSubview:self.name];
    }
    return self;
}

- (void)UIGlobal{
    [super UIGlobal];
   
    self.selectedBackgroundView = [[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
}

- (void)setCell:(id)data{
    [super setCell:data];
}


@end
