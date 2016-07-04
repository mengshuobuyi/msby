//
//  LocationPermissionView.m
//  APP
//
//  Created by garfield on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "LocationPermissionView.h"

@implementation LocationPermissionView

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.containerCover.layer.masksToBounds = YES;
    self.containerCover.layer.cornerRadius = 4.0;
    self.cancelButton.layer.cornerRadius = 3.0f;
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.borderColor = RGBHex(qwColor2).CGColor;
    self.cancelButton.layer.borderWidth = 1.0f;
    self.settingButton.layer.masksToBounds = YES;
    self.settingButton.layer.cornerRadius = 3.0f;
    self.frame = CGRectMake(0, 0,APP_W, SCREEN_H);
    [self.cancelButton addTarget:self action:@selector(fadeOut) forControlEvents:UIControlEventTouchUpInside];
    [self.settingButton addTarget:self action:@selector(goToSeting) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goToSeting
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
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
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}


@end
