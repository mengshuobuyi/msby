//
//  MainViewController.h
//  APP
//
//  Created by Martin.Liu on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

@interface MainViewController : QWBaseVC
@property (nonatomic, strong) QWTabBar* tabbarOne;
@property (nonatomic, strong) QWTabBar* tabbarTwo;

@property (nonatomic, strong) QWTabBar* currentTabbar;
@property (nonatomic, assign) NSInteger selectedTab;
// 根据tabbaritem的tag 跳转到相应的视图控制器
- (void)selectedViewControllerWithTag:(NSInteger)tag;

+ (NSArray *)tabbarOneItems;
+ (NSArray *)tabbarTwoItems;

- (void)showBusinessGuide;

@end
