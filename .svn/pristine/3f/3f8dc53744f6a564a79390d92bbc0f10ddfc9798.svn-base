//
//  NewSetting2TableCell.m
//  APP
//
//  Created by Martin.Liu on 15/12/7.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "NewSetting2TableCell.h"
#import "ConstraintsUtility.h"
@implementation NewSetting2TableCell

- (void)awakeFromNib {
//    self.constraint_rightArrowTrailing.constant =  -APP_W;
//    self.actionBtn.userInteractionEnabled = NO;
    self.actionBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
    [self.actionBtn setTitleColor:RGBHex(qwColor8) forState:UIControlStateNormal];
    [self.actionBtn setTitleColor:RGBHex(qwColor8) forState:UIControlStateDisabled];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHiddenRightArrow:(BOOL)hiddenRightArrow
{
    _hiddenRightArrow = hiddenRightArrow;
    self.constraint_rightArrowTrailing.constant = _hiddenRightArrow ? - APP_W : 15;
    
    self.actionBtn.enabled = !_hiddenRightArrow;
    if (!_hiddenRightArrow) {
        // 未绑定
        [self.actionBtn setTitle:@"未绑定" forState:UIControlStateNormal];
//        self.actionBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
//        [self.actionBtn setTitleColor:RGBHex(qwColor8) forState:UIControlStateNormal];
    }
    else
    {
        [self.actionBtn setTitle:@"已绑定" forState:UIControlStateDisabled];
//        self.actionBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
//        [self.actionBtn setTitleColor:RGBHex(qwColor8) forState:UIControlStateDisabled];
    }
    
}

@end
