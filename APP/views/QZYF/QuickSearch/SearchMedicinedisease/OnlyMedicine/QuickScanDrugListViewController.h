//
//  QuickScanDrugListViewController.h
//  wenYao-store
//
//  Created by YYX on 15/6/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "Drug.h"

typedef void (^PassValueBlock)(id model);

@interface QuickScanDrugListViewController : QWBaseVC<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) ProductModel *product;
@property (weak, nonatomic) IBOutlet UITableView *drugTableView;
@property (nonatomic, copy) PassValueBlock block;

@end
