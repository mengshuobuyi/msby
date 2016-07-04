//
//  SettingViewController.h
//  wenyao
//
//  Created by Meng on 14/11/6.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"

@interface MessageSettingViewController : QWBaseVC<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISwitch      *messageVoiceSwitch;
@property (nonatomic, strong) UISwitch      *messageVibrationSwitch;

@property (nonatomic, strong) UISwitch      *alarmVoiceSwitch;
@property (nonatomic, strong) UISwitch      *alarmVibrationSwitch;


@end
