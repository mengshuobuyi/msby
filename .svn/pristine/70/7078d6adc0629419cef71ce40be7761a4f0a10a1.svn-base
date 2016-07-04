//
//  CircleSquareEmptyTableCell.m
//  APP
//
//  Created by Martin.Liu on 16/6/21.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CircleSquareEmptyTableCell.h"
@interface CircleSquareEmptyTableCell()

@property (strong, nonatomic) IBOutlet UILabel *emptyTipLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_imageTop; // default is 30;

@end

@implementation CircleSquareEmptyTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBHex(qwColor11);
    self.emptyTipLabel.font = [UIFont systemFontOfSize:kFontS13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTipString:(NSString *)tipString
{
    _tipString = tipString;
    self.emptyTipLabel.text = tipString;
}

- (void)setHiddenImage:(BOOL)hiddenImage
{
    _hiddenImage = hiddenImage;
    self.constraint_imageTop.constant = _hiddenImage ? -100 : 30;
}

@end
