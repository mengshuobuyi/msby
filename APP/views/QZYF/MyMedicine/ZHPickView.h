//
//  ZHPickView.h
//  ZHpickView
//
//  Created by liudianling on 14-11-18.
//  Copyright (c) 2014年 赵恒志. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPickView;

@protocol ZHPickViewDelegate <NSObject>

@optional
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString arr:(NSMutableArray *)arr;
-(void)canclePicker:(NSInteger)tag;
@end

@interface ZHPickView : UIView

@property(nonatomic,weak) id<ZHPickViewDelegate> delegate;
@property(nonatomic ,assign)NSInteger pickerTag;
@property (weak, nonatomic) IBOutlet UILabel *titleOne;
@property(assign,nonatomic)BOOL showed;
@property (weak, nonatomic) IBOutlet UILabel *titleTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancleItem;
- (IBAction)cancle:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *confirmItrm;
- (IBAction)confirm:(id)sender;

/**
 *  通过plistName添加一个pickView
 *
 *  @param plistName          plist文件的名字

 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(void)initPickviewWithPlistName:(NSString *)plistName ;
/**
 *  通过plistName添加一个pickView
 *
 *  @param array              需要显示的数组
 *  @param isHaveNavControler 是否在NavControler之内
 *
 *  @return 带有toolbar的pickview
 */
-(void)initPickviewWithArray:(NSArray *)array ;

/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param isHaveNavControler是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
-(void)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode ;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
/**
 *  设置PickView的颜色
 */
-(void)setPickViewColer:(UIColor *)color;

@end


