//
//  customAlertView.m
//  APP
//
//  Created by 李坚 on 15/9/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "PromotionCustomAlertView.h"

@implementation PromotionCustomAlertView


+ (PromotionCustomAlertView *)showCustomAlertViewAtView:(UIView *)view withTitle:(NSString *)title andCancelButton:(NSString *)cancelTitle andConfirmButton:(NSString *)confirmTitle highLight:(BOOL)light showImage:(BOOL)isShow andCallback:(disMissViewCallback)callBack{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PromotionCustomAlertView" owner:nil options:nil];
    PromotionCustomAlertView *alertView = [nibView objectAtIndex:0];
    alertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);;
    alertView.dismissCallback = callBack;
    alertView.titleLabel.text = title;
    [alertView.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [alertView.PromotionButton setTitle:confirmTitle forState:UIControlStateNormal];
    
    if(light){
        [alertView.PromotionButton setHighlighted:YES];
        [alertView.cancelButton setHighlighted:NO];
    }else{
        [alertView.PromotionButton setHighlighted:NO];
        [alertView.cancelButton setHighlighted:YES];
    }
    
    if(!isShow){
        [alertView.mainImage removeFromSuperview];
        alertView.titleLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        alertView.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    alertView.AlertView.transform = CGAffineTransformMakeScale(0, 0);
    alertView.bkView.alpha = 0.0f;
    
    [view addSubview:alertView];
    
    [UIView animateWithDuration:0.3 animations:^{
        alertView.bkView.alpha = 0.4f;
        alertView.AlertView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
    
    return alertView;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.AlertView.layer.masksToBounds = YES;
    self.AlertView.layer.cornerRadius = 4.5f;
    
//    self.PromotionButton.layer.masksToBounds = YES;
//    self.PromotionButton.layer.cornerRadius = 4.5f;
//    
//    self.cancelButton.layer.masksToBounds = YES;
//    self.cancelButton.layer.cornerRadius = 4.5f;
//    self.cancelButton.layer.borderWidth = 1.0f;
//    self.cancelButton.layer.borderColor = RGBHex(qwColor2).CGColor;
    
    [self.PromotionButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sure{
 
    [self removeView];
    if(self.dismissCallback){
        self.dismissCallback(1);
    }
    
}

- (void)cancel{
    
    [self removeView];
    if(self.dismissCallback){
        self.dismissCallback(0);
    }
    
}

- (void)removeView{
 
    [self removeFromSuperview];

}

@end
