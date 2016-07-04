//
//  GiftVoucherAlertView.h
//  APP
//
//  Created by 李坚 on 15/9/7.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^disMissCallback) (id obj);

@interface GiftVoucherAlertView : UIView


@property (weak, nonatomic) IBOutlet UIView *bkView;
@property (weak, nonatomic) IBOutlet UIView *CustomAlertView;
- (IBAction)dimissView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (copy,nonatomic) disMissCallback dismissCallback;

+ (GiftVoucherAlertView *)showAlertViewAtView:(UIView *)aView withVoucher:(NSString *)voucherName andCount:(NSInteger)count andImageName:(NSString *)imgUrl callBack:(disMissCallback)callBack;

@end
