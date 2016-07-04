//
//  SettingViewController.m
//  wenyao
//
//  Created by Meng on 14/11/6.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MessageSettingViewController.h"
#import "SettingCell.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"
#import "QWLocalNotif.h"

#define IS_FIRST_SOUND_INFO         @"isFirstSoundInfo"
#define IS_FIRST_VIBRATION_INFO         @"isFirstVibrationInfo"
#define IS_FIRST_SOUND_ALARM            @"isFirstSoundAlarm"
#define IS_FIRST_VIBRATION_ALARM        @"isFirstVibrationAlarm"

@interface MessageSettingViewController ()<ReturnIndexViewDelegate>
{
    NSArray * titleArr;
}
@property (strong , nonatomic) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation MessageSettingViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"消息提醒";
        self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.tableFooterView = [[UIView alloc]init];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)swicthSetting:(UISwitch *)changeSwitch
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    switch (changeSwitch.tag) {
        case 101:
        {
            [QWUserDefault setBool:changeSwitch.isOn key:APP_SOUND_ENABLE];
            [QWUserDefault setString:@"101" key:IS_FIRST_SOUND_INFO];
            break;
        }
        case 102:
        {
            [QWUserDefault setBool:changeSwitch.isOn key:APP_VIBRATION_ENABLE];
            [QWUserDefault setString:@"102" key:IS_FIRST_VIBRATION_INFO];
            break;
        }
        case 104:
        {
            [QWUserDefault setBool:changeSwitch.isOn key:APP_Alarm_SOUND_ENABLE];
            [QWUserDefault setString:@"104" key:IS_FIRST_SOUND_ALARM];
            
            [[QWLocalNotif instance]  resetAllLN];
            break;
        }
        case 105:
        {
            [QWUserDefault setBool:changeSwitch.isOn key:APP_Alarm_VIBRATION_ENABLE];
            [QWUserDefault setString:@"105" key:IS_FIRST_VIBRATION_ALARM];
            break;
        }
        default:
            break;
    }
    [userDefault synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    titleArr = @[@[@"声音",@"震动",@"退出后仍接收消息"],@[@"声音",@"震动"]];
    titleArr = @[@[@"声音",@"震动"],@[@"声音",@"震动"]];
    
    self.messageVoiceSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    [self.messageVoiceSwitch setOnTintColor:RGBHex(qwColor2)];
    self.messageVoiceSwitch.tag = 101;
    [self.messageVoiceSwitch addTarget:self action:@selector(swicthSetting:) forControlEvents:UIControlEventValueChanged];
    
    self.messageVibrationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    self.messageVibrationSwitch.tag = 102;
    [self.messageVibrationSwitch setOnTintColor:RGBHex(qwColor2)];
    [self.messageVibrationSwitch addTarget:self action:@selector(swicthSetting:) forControlEvents:UIControlEventValueChanged];
    
    
    self.alarmVoiceSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    self.alarmVoiceSwitch.tag = 104;
    [self.alarmVoiceSwitch setOnTintColor:RGBHex(qwColor2)];
    [self.alarmVoiceSwitch addTarget:self action:@selector(swicthSetting:) forControlEvents:UIControlEventValueChanged];
    
    self.alarmVibrationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    self.alarmVibrationSwitch.tag = 105;
    [self.alarmVibrationSwitch setOnTintColor:RGBHex(qwColor2)];
    [self.alarmVibrationSwitch addTarget:self action:@selector(swicthSetting:) forControlEvents:UIControlEventValueChanged];
    
    
    
    BOOL questionPushIsOpen = [QWUserDefault getBoolBy:APP_QUESTIONPUSH];
    if (questionPushIsOpen) {
        
        //打开推送
        
    }else
    {
        //关闭推送
        
    }
    
}

#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, -2, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 1, 18, 18)];
    self.numLabel.backgroundColor = RGBHex(qwColor3);
    self.numLabel.layer.cornerRadius = 9.0;
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:11];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.text = @"10";
    self.numLabel.hidden = YES;
    [rightView addSubview:self.numLabel];
    
    //小红点
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];

    if (self.passNumber > 0)
    {
        //显示数字
        self.numLabel.hidden = NO;
        self.redLabel.hidden = YES;
        if (self.passNumber > 99) {
            self.passNumber = 99;
        }
        self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
        
    }else if (self.passNumber == 0)
    {
        //显示小红点
        self.numLabel.hidden = YES;
        self.redLabel.hidden = NO;
        
    }else if (self.passNumber < 0)
    {
        //全部隐藏
        self.numLabel.hidden = YES;
        self.redLabel.hidden = YES;
    }

}
- (void)returnIndex
{
   self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"ic_img_notice",@"icon home.PNG"] title:@[@"消息",@"首页"] passValue:self.passNumber];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    
    if (indexPath.row == 0)
    {
        if(!QWGLOBALMANAGER.loginStatus) {
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [self presentViewController:navgationController animated:YES completion:NULL];
            return;
        }
        
        MessageBoxListViewController *vcMsgBoxList = [[UIStoryboard storyboardWithName:@"MessageBoxListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageBoxListViewController"];
        
        vcMsgBoxList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
        
    }else if (indexPath.row == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }

}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    
    if ([[QWUserDefault getStringBy:IS_FIRST_SOUND_INFO] isEqualToString:@"101"]) {
        self.messageVoiceSwitch.on = [QWUserDefault getBoolBy:APP_SOUND_ENABLE];
    }else{
        self.messageVoiceSwitch.on = YES;
    }
    
    
    if ([[QWUserDefault getStringBy:IS_FIRST_VIBRATION_INFO] isEqualToString:@"102"]) {
        self.messageVibrationSwitch.on = [QWUserDefault getBoolBy:APP_VIBRATION_ENABLE];
    }else{
        self.messageVibrationSwitch.on = YES;
    }
    
    
    if ([[QWUserDefault getStringBy:IS_FIRST_SOUND_ALARM] isEqualToString:@"104"]) {
        self.alarmVoiceSwitch.on = [QWUserDefault getBoolBy:APP_Alarm_SOUND_ENABLE];
    }else{
        self.alarmVoiceSwitch.on = YES;
    }
    
    
    if ([[QWUserDefault getStringBy:IS_FIRST_VIBRATION_ALARM] isEqualToString:@"105"]) {
        self.alarmVibrationSwitch.on = [QWUserDefault getBoolBy:APP_Alarm_VIBRATION_ENABLE];
    }else{
        self.alarmVibrationSwitch.on = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)titleArr[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APP_W-30, 20)];
    label.textColor = [UIColor colorWithRed:139.0f/255.0f green:139.0f/255.0f blue:139.0f/255.0f alpha:1.0f];;
    if (section == 0)
    {
        label.text = @"新消息提醒";
    }else if (section == 1)
    {
        label.text = @"用药闹钟提醒";
    }
    label.font = fontSystem(kFontS4);
    label.textColor = RGBHex(qwColor8);
    [view addSubview:label];
    
    if (section == 1) {
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        line1.backgroundColor = RGBHex(qwColor10);
        [view addSubview:line1];
    }
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
    line2.backgroundColor = RGBHex(qwColor10);
    [view addSubview:line2];

    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    SettingCell * cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    if(indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.accessoryView = self.messageVoiceSwitch;
                break;
            }
            case 1:
            {
                cell.accessoryView = self.messageVibrationSwitch;
                break;
            }
           
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                cell.accessoryView = self.alarmVoiceSwitch;
                break;
            }
            case 1:
            {
                cell.accessoryView = self.alarmVibrationSwitch;
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotiWhetherHaveNewMessage == type) {
        
        NSString *str = data;
        self.passNumber = [str integerValue];
        self.indexView.passValue = self.passNumber;
        [self.indexView.tableView reloadData];
        if (self.passNumber > 0)
        {
            //显示数字
            self.numLabel.hidden = NO;
            self.redLabel.hidden = YES;
            if (self.passNumber > 99) {
                self.passNumber = 99;
            }
            self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
            
        }else if (self.passNumber == 0)
        {
            //显示小红点
            self.numLabel.hidden = YES;
            self.redLabel.hidden = NO;
            
        }else if (self.passNumber < 0)
        {
            //全部隐藏
            self.numLabel.hidden = YES;
            self.redLabel.hidden = YES;
        }
    }
}

@end
