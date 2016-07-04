//
//  WYLNCell.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "WYLocalNotifModel.h"
#import "QWLocalNotif.h"
#import "MGSwipeTableCell.h"

@interface WYLNCell : MGSwipeTableCell

@property (nonatomic, strong) IBOutlet  UILabel         *day;
@property (nonatomic, strong) IBOutlet  UILabel         *time;
@property (nonatomic, strong) IBOutlet  QWLabel         *productName;
@property (nonatomic, strong) IBOutlet  QWLabel         *drugCycle;
@property (nonatomic, strong) IBOutlet  QWLabel         *productUser;
@property (nonatomic, strong) IBOutlet  QWImageView         *photo;
@property (nonatomic, strong) IBOutlet  UISwitch        *swhClock;

- (void)setCell:(id)data;
- (IBAction)clockAction:(id)sender;
@end
