//
//  customAlertView.h
//  APP
//
//  Created by 李坚 on 15/9/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^disMissViewCallback) (NSInteger obj);


@interface PromotionCustomAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *PromotionButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *AlertView;
@property (weak, nonatomic) UIView *bkView;

@property (copy,nonatomic) disMissViewCallback dismissCallback;

+ (PromotionCustomAlertView *)showCustomAlertViewAtView:(UIView *)view withTitle:(NSString *)title andCancelButton:(NSString *)cancelTitle andConfirmButton:(NSString *)confirmTitle highLight:(BOOL)light showImage:(BOOL)isShow andCallback:(disMissViewCallback)callBack;

@end
