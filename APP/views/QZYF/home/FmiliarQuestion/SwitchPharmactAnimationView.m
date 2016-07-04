//
//  SwitchPharmactAnimationView.m
//  APP
//
//  Created by garfield on 16/6/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "SwitchPharmactAnimationView.h"

@implementation SwitchPharmactAnimationView


- (void)startAnimation
{
    if(!self.superview) {
        self.fireImage.alpha = 1.0;
        self.circleImage.transform = CGAffineTransformIdentity;
        self.fireImage.transform = CGAffineTransformIdentity;
        return;
    }
    [UIView beginAnimations:@"animationID1" context:nil];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(reverAnimation)];
    self.fireImage.alpha = 0.4;
    self.circleImage.transform = CGAffineTransformMakeRotation(M_PI);
    self.fireImage.transform = CGAffineTransformMakeScale(1.5,1.5);
    [UIView commitAnimations];
}


- (void)reverAnimation
{
    if(!self.superview) {
        self.fireImage.alpha = 1.0;
        self.circleImage.transform = CGAffineTransformIdentity;
        self.fireImage.transform = CGAffineTransformIdentity;
        return;
    }
    [UIView beginAnimations:@"animationID2" context:nil];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationDidStopSelector:@selector(startAnimation)];
    self.fireImage.alpha = 1.0;
    self.circleImage.transform = CGAffineTransformMakeRotation(M_PI * 2);
    self.fireImage.transform = CGAffineTransformMakeScale(1.0,1.0);
    [UIView commitAnimations];
}

- (void)showInView:(UIView *)superView withbranchName:(NSString *)branchName
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:self];
    NSArray *Hconstarints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[self]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    NSArray *Vconstarints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[self]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    [superView addConstraints:Hconstarints];
    [superView addConstraints:Vconstarints];
    self.nameLabel.text = [NSString stringWithFormat:@"正在奔向%@",branchName];
    [self startAnimation];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
