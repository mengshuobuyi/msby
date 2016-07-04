//
//  InformationListViewController.h
//  quanzhi
//
//  Created by xiezhenghong on 14-6-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "Healthinfo.h"

@interface InformationListViewController : QWBaseVC <UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) UITableView               *tableView;
@property (nonatomic, assign) UINavigationController    *navigationController;
@property (nonatomic, strong) HealthinfoChannel               *channelInfo;
@property (nonatomic, strong) NSMutableArray            *infoList;
@property (nonatomic, strong) NSMutableArray            *bannerList;
@property (nonatomic, strong) NSString *strAdviceID;
- (void) refresh;
@end
