//
//  QZSettingViewController.h
//  wenyao
//
//  Created by Meng on 15/1/21.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"

@interface QZSettingViewController : QWBaseVC<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
