//
//  DailyTaskTableCell.m
//  APP
//
//  Created by Martin.Liu on 15/11/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "DailyTaskTableCell.h"

@implementation DailyTaskTableCell

- (void)awakeFromNib {
    self.firstTitleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.firstTitleLabel.textColor = RGBHex(qwColor8);
    self.firstCreditCountLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.firstCreditCountLabel.textColor = RGBHex(qwColor3);
    
    self.secondTitleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.secondTitleLabel.textColor = RGBHex(qwColor8);
    self.secondCreditCountLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.secondCreditCountLabel.textColor = RGBHex(qwColor3);
    
    self.thirdTitleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.thirdTitleLabel.textColor = RGBHex(qwColor8);
    self.thirdCreditCountLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.thirdCreditCountLabel.textColor = RGBHex(qwColor3);
    
    self.fourthTitleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.fourthTitleLabel.textColor = RGBHex(qwColor8);
    self.fourthCreditCountLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.fourthCreditCountLabel.textColor = RGBHex(qwColor3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(NSArray*)taskArray
{
    [self hiddenFirstItem:YES];
    [self hiddenSecondItem:YES];
    [self hiddenThirdItem:YES];
    [self hiddenFourthItem:YES];
    
    [self setBtnImageWithTaskKey:taskArray];
    
    switch (MIN(3, taskArray.count - 1)) {
        case 3:
            [self setFourthItem:taskArray[3]];
        case 2:
            [self setThirdItem:taskArray[2]];
        case 1:
            [self setSecondItem:taskArray[1]];
        case 0:
            [self setFirstItem:taskArray[0]];
            break;
        default:
            break;
    }
}

- (void)setFirstItem:(CreditTaskModel*)taskModel
{
    [self hiddenFirstItem:NO];
    self.firstTitleLabel.text = taskModel.taskName;
    self.firstBtn.selected = taskModel.finish;
    self.firstCreditCountLabel.text = [NSString stringWithFormat:@"+ %ld", (long)taskModel.rewardScore];
}

- (void)setSecondItem:(CreditTaskModel*)taskModel
{
    [self hiddenSecondItem:NO];
    self.secondTitleLabel.text = taskModel.taskName;
    self.secondBtn.selected = taskModel.finish;
    self.secondCreditCountLabel.text = [NSString stringWithFormat:@"+ %ld", (long)taskModel.rewardScore];
}

- (void)setThirdItem:(CreditTaskModel*)taskModel
{
    [self hiddenThirdItem:NO];
    self.thirdTitleLabel.text = taskModel.taskName;
    self.thirdBtn.selected = taskModel.finish;
    self.thirdCreditCountLabel.text = [NSString stringWithFormat:@"+ %ld", (long)taskModel.rewardScore];
}

- (void)setFourthItem:(CreditTaskModel*)taskModel
{
    [self hiddenFourthItem:NO];
    self.fourthTitleLabel.text = taskModel.taskName;
    self.fourthBtn.selected = taskModel.finish;
    self.fourthCreditCountLabel.text = [NSString stringWithFormat:@"+ %ld", (long)taskModel.rewardScore];
}

- (void)setBtnImageWithTaskKey:(NSArray*)taskArray
{
    for (int i = 0; i < taskArray.count; i++) {
        CreditTaskModel* taskModel = taskArray[i];
        NSString* taskKey = taskModel.taskKey;
        if ([@"SHARE" isEqual:taskKey]) {
            [self setBtnImageWithImageNames:@[@"icon_integral_share", @"icon_integral_share_pressed"] itemIndex:i];
        }
        else if ([@"SIGN" isEqual:taskKey])
        {
            [self setBtnImageWithImageNames:@[@"icon_integral_sign", @"icon_integral_sign_pressed"] itemIndex:i];
        }
        else if ([@"TRADE" isEqual:taskKey])
        {
            [self setBtnImageWithImageNames:@[@"icon_integral_shopping", @"icon_integral_shopping_pressed"] itemIndex:i];
        }
    }
}

- (void)setBtnImageWithImageNames:(NSArray*)imageNames itemIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self.firstBtn setImage:[UIImage imageNamed:imageNames[0]] forState:UIControlStateNormal];
            [self.firstBtn setImage:[UIImage imageNamed:imageNames[1]] forState:UIControlStateSelected];
            break;
        case 1:
            [self.secondBtn setImage:[UIImage imageNamed:imageNames[0]] forState:UIControlStateNormal];
            [self.secondBtn setImage:[UIImage imageNamed:imageNames[1]] forState:UIControlStateSelected];
            break;
        case 2:
            [self.thirdBtn setImage:[UIImage imageNamed:imageNames[0]] forState:UIControlStateNormal];
            [self.thirdBtn setImage:[UIImage imageNamed:imageNames[1]] forState:UIControlStateSelected];
            break;
        default:
            
            break;
    }
}

- (void)hiddenFirstItem:(BOOL)hidden
{
    self.firstBtn.hidden = hidden;
    self.firstTitleLabel.hidden = hidden;
    self.firstCreditCountLabel.hidden = hidden;
}

- (void)hiddenSecondItem:(BOOL)hidden
{
    self.secondBtn.hidden = hidden;
    self.secondTitleLabel.hidden = hidden;
    self.secondCreditCountLabel.hidden = hidden;
}

- (void)hiddenThirdItem:(BOOL)hidden
{
    self.thirdBtn.hidden = hidden;
    self.thirdTitleLabel.hidden = hidden;
    self.thirdCreditCountLabel.hidden = hidden;
}

- (void)hiddenFourthItem:(BOOL)hidden
{
    self.fourthBtn.hidden = hidden;
    self.fourthTitleLabel.hidden = hidden;
    self.fourthCreditCountLabel.hidden = hidden;
}

@end
