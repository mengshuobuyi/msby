//
//  HealthInfoRecommendViewController.h
//  APP
//
//  Created by PerryChen on 11/9/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "Healthinfo.h"
@interface HealthInfoRecommendViewController : QWBaseVC
@property (nonatomic, assign) UINavigationController    *navigationController;
@property (nonatomic, strong) NSString *strAdviceID;
@property (nonatomic, strong) HealthinfoChannel *channelInfo;
@property (nonatomic, assign) NSInteger selectedIndex;
- (void) refresh;
@end
