//
//  SplashView.h
//  APP
//
//  Created by 李坚 on 15/9/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

#import <UIKit/UIKit.h>

typedef void (^jumpBlock)(void);

@interface SplashView : UIView{
    
    NSTimer *timer;
}

@property (strong, nonatomic) UIImageView *SplashImage;
@property (strong, nonatomic) UIView *jumpView;
@property (strong, nonatomic) UILabel *timeLabel;

@property (nonatomic, copy) jumpBlock jump;
@property (nonatomic, copy) jumpBlock dismissJump;

@property (nonatomic,assign) double count;

+ (SplashView *)showSplashViewAtWindow:(UIWindow *)window WithBlock:(jumpBlock)callBack;
@end
