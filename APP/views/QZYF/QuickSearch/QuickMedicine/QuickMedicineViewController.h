//
//  QuickMedicineViewController.h
//  wenyao
//
//  Created by Meng on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

//#import "BaseTableViewController.h"
#import "QWBaseVC.h"
@interface QuickMedicineViewController : QWBaseVC
<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView    *tableView;
@end
