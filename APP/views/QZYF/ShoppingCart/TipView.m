//
//  TipView.m
//  APP
//
//  Created by garfield on 16/5/5.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "TipView.h"

@implementation TipView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _tipTitleLabel.preferredMaxLayoutWidth = APP_W - 25 - 24;
    _contentTwoLabel.preferredMaxLayoutWidth = APP_W - 25.0 - 24;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
