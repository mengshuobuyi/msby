//
//  CustomDatePicker.h
//  APP
//
//  Created by PerryChen on 8/21/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomDatePickerDelegate <NSObject>

- (void)selectDateInPicker:(NSDate *)dateCurrent;
- (void)cancelSelecteDate;

@end

@interface CustomDatePicker : UIView

@property (weak, nonatomic) id<CustomDatePickerDelegate> pickerDelegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)actionSelectDone:(UIButton *)sender;
- (void)setPickerDate:(NSDate *)curDate;

@end
