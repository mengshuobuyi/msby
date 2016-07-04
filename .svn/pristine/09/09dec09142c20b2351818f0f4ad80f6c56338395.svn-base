//
//  CustomDatePicker.m
//  APP
//
//  Created by PerryChen on 8/21/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "CustomDatePicker.h"

@implementation CustomDatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setPickerDate:(NSDate *)curDate
{
    [self.datePicker setDate:curDate];
}

- (IBAction)actionSelectDone:(UIButton *)sender {
    if ([self.pickerDelegate respondsToSelector:@selector(selectDateInPicker:)]) {
        NSDate *dateSelect = self.datePicker.date;
        [self.pickerDelegate selectDateInPicker:dateSelect];
    }
}

- (IBAction)actionCancelSelectDate:(id)sender {
    if ([self.pickerDelegate respondsToSelector:@selector(cancelSelecteDate)]) {
        [self.pickerDelegate cancelSelecteDate];
    }
}
@end
