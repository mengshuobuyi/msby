//
//  OtherCollectViewController.h
//  wenyao
//
//  Created by Meng on 14-10-2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"

typedef enum : NSUInteger {
    medicineCollect,
    symptomCollect,
    diseaseCollect,
    messageCollect,
    coupnCollect,
} OtherCollectType;

@interface OtherCollectViewController : QWBaseVC

@property (nonatomic ,strong) UINavigationController * navigationController;

@property (nonatomic ,strong) UITableView *tableView;               //主视图

@property (nonatomic ,assign) OtherCollectType collectType;

//@property (nonatomic, strong) UIViewController  *containerViewController;



- (void)viewDidCurrentView;

@end
