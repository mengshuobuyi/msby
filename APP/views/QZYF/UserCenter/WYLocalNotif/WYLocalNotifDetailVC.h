//
//  WYLocalNotifDetailVC.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"
#import "WYLocalNotifEditVC.h"
#import "WYLocalNotifModel.h"

@interface WYLocalNotifDetailVC : QWBaseVC
<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) WYLocalNotifModel *modLocalNotif;
@property (nonatomic, strong) NSMutableArray    *listClock;
@end
