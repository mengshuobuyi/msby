//
//  QWCustomedTabBar.h
//  APP
//
//  Created by  ChenTaiyu on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QWTabbarItem;

@interface QWCustomedTabBar : UITabBar

- (void)changeStyleWithItemConfig:(NSArray <QWTabbarItem *>*)itemConfig;
- (void)changeStyleWithItemConfig:(NSArray <QWTabbarItem *>*)itemConfig withSpecialBtn:(UIButton *)specialBtn;

// test method
- (NSArray *)styleCommon;
- (NSArray *)styleFestival;
- (UIButton *)specialButtonFestival;

@end
