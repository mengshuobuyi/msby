//
//  QZMyOrderViewController.h
//  wenyao
//
//  Created by Meng on 15/1/16.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"

@interface QZMyOrderViewController : QWBaseVC<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
