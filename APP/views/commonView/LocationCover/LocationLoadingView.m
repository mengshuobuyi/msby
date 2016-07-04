//
//  LocationLoadingView.m
//  APP
//
//  Created by garfield on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "LocationLoadingView.h"
#import "SVProgressHUD.h"


@implementation LocationLoadingView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    self.frame = CGRectMake(0, 0,APP_W, SCREEN_H);
}

#pragma mark - Private Methods
- (void)fadeIn
{
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    if([aView viewWithTag:1008]) {
        [aView insertSubview:self belowSubview:[aView viewWithTag:1008]];
    }else{
        [aView addSubview:self];
    }
    if (animated) {
        [self fadeIn];
    }
}

- (IBAction)dismiss:(id)sender
{
    [self fadeOut];
}

- (void)showSuccessHint
{
    [SVProgressHUD showSuccessWithStatus:@"定位地址成功"];
    [self fadeOut];
}

- (void)showFailureHint
{
    [SVProgressHUD showSuccessWithStatus:@"定位地址失败"];
    [self fadeOut];
}

@end
