//
//  BarTwoViewController.m
//  APP
//
//  Created by 李坚 on 16/1/21.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BarTwoViewController.h"

@interface BarTwoViewController ()

@end

@implementation BarTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self setupBranchListVC];
}

#pragma mark - push进去对应是否开通微商药房列表
- (void)setupBranchListVC{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
