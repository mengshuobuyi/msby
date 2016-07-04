//
//  UserCenterViewCell.m
//  wenyao
//
//  Created by Meng on 15/1/27.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "UserCenterViewCell.h"
#import "UIView+Extension.h"

@implementation UserCenterViewCell

+ (CGFloat)getCellHeight:(id)data{
    return 45.0f;
}

- (void)awakeFromNib
{
    [self.imageView convertIntoCircular];
    self.label.text = @"";
    self.TagImage.hidden = YES;
    self.TagImage.layer.masksToBounds = YES;
    self.TagImage.layer.cornerRadius = 2.0f;
    
}



- (void)UIGlobal{
//    [super UIGlobal];
    self.titleLabel.font = fontSystem(15);
    [self setSelectedBGColor:RGBHex(qwColor10)];
}


@end
