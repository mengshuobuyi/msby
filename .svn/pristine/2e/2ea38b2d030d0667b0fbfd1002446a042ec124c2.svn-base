//
//  BodyPartCell.m
//  APP
//
//  Created by qwfy0006 on 15/3/13.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BodyPartCell.h"

@implementation BodyPartCell

@synthesize name = name;
+ (CGFloat)getCellHeight:(id)data{
    
    return 44;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (self.name == nil) {
        
            self.name = [[QWLabel alloc] initWithFrame:CGRectMake(15, 0, 320-15, 44)];
            self.name.font = fontSystem(kFontS3);
            self.name.textColor = RGBHex(qwColor6);
            [self.contentView addSubview:self.name];
        }
        
    }
    return self;
}

- (void)UIGlobal{
    
    [super UIGlobal];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.separatorLine.backgroundColor = RGBHex(qwColor10);
}

- (void)setCell:(id)data{

    [super setCell:data];
}


@end
