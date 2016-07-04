//
//  SplashViewController.h
//  APP
//
//  Created by qw on 15/9/2.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

typedef void (^jumpBlock)(void);

@interface SplashViewController : UIView

- (IBAction)doJump:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageSplash;
@property (weak, nonatomic) IBOutlet UIView *jumpView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, copy) jumpBlock jump;
@property (nonatomic, copy) jumpBlock dismissJump;

@property (nonatomic,assign) double count;

+ (SplashViewController *)showSplashViewAtWindow:(UIWindow *)window WithBlock:(jumpBlock)callBack WithDismissBlock:(jumpBlock)callBackDismiss;

@end
