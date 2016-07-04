//
//  QuickSearchTableViewCell.m
//  APP
//
//  Created by garfield on 15/10/8.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QuickSearchTableViewCell.h"
#import "QuickSearchViewController.h"
@implementation QuickSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.subTitleLabel.textColor = RGBHex(qwColor8);
}

- (void)setCell:(id)data
{
    QuickSearchModel *model = (QuickSearchModel *)data;
    self.avatarImage.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.qucikTitle;
    self.subTitleLabel.text = model.qucikSubTitle;
    if([model.qucikTitle isEqualToString:@"健康评测"]) {
        if (![QWUserDefault getBoolBy:@"HealthCheck"]) {
            self.IconImage.hidden = NO;
        } else {
            self.IconImage.hidden = YES;
        }
    }else{
        self.IconImage.hidden = YES;
    }
}
- (void)UIGlobal{
    [super UIGlobal];
    self.separatorLine.hidden=YES;
    self.separatorHidden=YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
