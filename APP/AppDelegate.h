//
//  AppDelegate.h
//  问药用户版
//
//  Created by carret on 15/1/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWGlobalManager.h"
#import "Countdown.h"
#import "QWTabBar.h"
#import "MainViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
    
}
@property (strong, nonatomic) UIWindow *                window;
@property (nonatomic, strong) MainViewController* mainVC;
@property (strong, nonatomic, readonly) QWTabBar* currentTabBar;    // 当前tabbar

@property (assign, nonatomic) BOOL isLaunchByNotification;

- (BOOL)isMainTab;      // 是否是内容页的tabbar

- (void)showOPSplash;

- (void)pushNotiVC;

- (void)delayPushVC;

@end

