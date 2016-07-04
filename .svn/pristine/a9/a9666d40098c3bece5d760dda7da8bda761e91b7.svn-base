//
//  GiftVoucherAlertView.m
//  APP
//
//  Created by 李坚 on 15/9/7.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "GiftVoucherAlertView.h"
#import "UIImageView+WebCache.h"

@implementation GiftVoucherAlertView

+ (GiftVoucherAlertView *)showAlertViewAtView:(UIView *)aView withVoucher:(NSString *)voucherName andCount:(NSInteger)count andImageName:(NSString *)imgUrl callBack:(disMissCallback)callBack{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"GiftVoucherAlertView" owner:nil options:nil];
    GiftVoucherAlertView *alertView = [nibView objectAtIndex:0];
    alertView.dismissCallback = callBack;
    
    alertView.frame = CGRectMake(0, 0, aView.frame.size.width, aView.frame.size.height);
//    alertView.countLabel.text = [NSString stringWithFormat:@"%@ x%ld",voucherName,count];
    
    
   // if(imgUrl && ![imgUrl isEqualToString:@""]){
//    if(!StrIsEmpty(imgUrl)){
//        [alertView.ViewImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img_bg_gift_ticket"]];
//    }
    
    
    alertView.CustomAlertView.transform = CGAffineTransformMakeScale(0, 0);
    alertView.bkView.alpha = 0.0f;
    
    [aView addSubview:alertView];
    
    [UIView animateWithDuration:0.3 animations:^{
        alertView.bkView.alpha = 0.4f;
        alertView.CustomAlertView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
    
    return alertView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius = 2.0f;

    [self.btn setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    self.btn.adjustsImageWhenHighlighted = YES;
    [self.btn setBackgroundImage:[UIImage imageNamed:@"btn_img_statenormal"] forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"btn_img_statehighlight"] forState:UIControlStateHighlighted];
    
    
    
    self.CustomAlertView.layer.masksToBounds = YES;
    self.CustomAlertView.layer.cornerRadius = 10.0f;
    
}

- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    
    
    
}



- (IBAction)dimissView:(id)sender {
    
    
    [self dismiss];
}


- (void)dismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bkView.alpha = 0.0f;
        self.CustomAlertView.transform = CGAffineTransformMakeScale(0, 0);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        if (self.dismissCallback) {
            self.dismissCallback(nil);
        }
    }];
}

@end
