//
//  QWDatePicker.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/14.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^SelectedBack) (NSDate *date);

@interface QWDatePicker : UIView

@property (nonatomic, strong) NSDate    *date;
@property (nonatomic, copy) SelectedBack callBack ;//按钮点击事件的回调
@property (nonatomic, strong) UIView *curView;

//传开始时间，显示按年月日
+ (QWDatePicker *)instanceWithDate:(NSDate*)date showInView:(UIView *)aView callBack:(SelectedBack)callBack;

@end
