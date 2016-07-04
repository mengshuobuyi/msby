//
//  CreditRecordTableCell.m
//  APP
//
//  Created by Martin.Liu on 15/12/3.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "CreditRecordTableCell.h"

@implementation CreditRecordTableCell

- (void)awakeFromNib {
    self.recordTextLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.recordTextLabel.textColor = RGBHex(qwColor6);
    
    self.recordTimeLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.recordTimeLabel.textColor = RGBHex(qwColor8);
    
    self.recordCountLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.recordCountLabel.textColor = RGBHex(qwColor3);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(CreditRecordModel*)creditRecord
{
    self.recordTextLabel.text = creditRecord.operate;
    self.recordTimeLabel.text = creditRecord.date;
//    self.recordCountLabel.text = [NSString stringWithFormat:@"%ld", (long)creditRecord.score];
    
    // 1：获取，2：消耗,
    if (creditRecord.oprType == 2) {
        self.recordCountLabel.text = [NSString stringWithFormat:@"-%ld", (long)creditRecord.score];
        self.recordCountLabel.textColor = RGBHex(qwColor8);
    }
    else
    {
        self.recordCountLabel.text = [NSString stringWithFormat:@"+%ld", (long)creditRecord.score];
        self.recordCountLabel.textColor = RGBHex(qwColor3);
    }
    
}

@end
