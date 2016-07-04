//
//  OnlinePayTikTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "OnlinePayTikTableViewCell.h"

@implementation OnlinePayTikTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,  [OnlinePayTikTableViewCell getCellHeight] - 0.5f, APP_W, 0.5f)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
}

+ (CGFloat)getCellHeight{
    
    return 44.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
