//
//  ScenarioDrugViewController.h
//  APP
//
//  Created by caojing on 15-3-10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

@interface ScenarioDrugViewController : QWBaseVC<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UINavigationController * navigationController;
@property (nonatomic, strong) NSDictionary      *drugDict;
-(void)viewDidCurrentView;


@end
