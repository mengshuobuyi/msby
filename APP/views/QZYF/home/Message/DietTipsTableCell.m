//
//  DietTipsTableCell.m
//  APP
//
//  Created by garfield on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "DietTipsTableCell.h"
#import "MallCart.h"

@implementation DietTipsTableCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *image = [UIImage imageNamed:@"tips_content"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 30, 50)];
    _contentBackgroundImage.image = image;
    _tipTitleLabel.preferredMaxLayoutWidth = APP_W - 20 - 30;
    _contentOneLabel.preferredMaxLayoutWidth = APP_W - 20 - 30;
}

- (void)setCell:(ProductTabooVoModel *)data
{
    self.separatorHidden = YES;
    self.separatorLine.hidden = YES;
    self.tipTitleLabel.text = data.proName;
    self.contentOneLabel.text = data.taboo;
    
}

- (void)UIGlobal
{
    [self.contentView setBackgroundColor:RGBHex(qwColor11)];
    [self setBackgroundColor:RGBHex(qwColor11)];
}


@end
