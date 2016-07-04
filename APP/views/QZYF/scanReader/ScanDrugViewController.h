//
//  ScanDrugViewController.h
//  quanzhi
//
//  Created by xiezhenghong on 14-6-17.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanReaderViewController.h"
#import "QWBaseVC.h"
typedef enum  Enum_Scan_Froms_page {
    Enum_Scan_Froms_Normal   = 0,                   //普通扫码界面
    Enum_Scan_Froms_Add = 1,                           //添加到用药
    Enum_Scan_Froms_Preferential = 2,               //搜索优惠信息
}Scan_Froms;
@interface ScanDrugViewController : QWBaseVC<
UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray           *drugList;
@property (nonatomic, strong) UITableView       *tableView;

//与scanReader的userType对应        0普通扫码     1代表普通扫码界面     2从主页跳转过来
@property (nonatomic, assign) NSUInteger      userType;
@property (nonatomic, copy)   chooseMedicineBlock       completionBolck;
@end