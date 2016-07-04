//
//  NewStoreTableCell.m
//  APP
//
//  Created by Meng on 15/6/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "NewStoreTableCell.h"

@interface NewStoreTableCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraint;

- (IBAction)consultBigButtonClick:(QWButton *)sender;
- (IBAction)phoneBigButtonClick:(QWButton *)sender;

@end

@implementation NewStoreTableCell

- (void)awakeFromNib {
    self.lineConstraint.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setSelectedBGColor:(UIColor*)aColor{
    self.selectedBackgroundView = [[UIView alloc]init];
    self.selectedBackgroundView.backgroundColor = aColor;
}

- (IBAction)consultBigButtonClick:(QWButton *)sender {
    if ([self.delegate respondsToSelector:@selector(consultButtonClick:)]) {
        [self.delegate consultButtonClick:sender];
    }
}

- (IBAction)phoneBigButtonClick:(QWButton *)sender {
    if ([self.delegate respondsToSelector:@selector(PhoneButtonClick:)]) {
        [self.delegate PhoneButtonClick:sender];
    }
}
@end
