//
//  WYLocalNotifAddVC.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"
#import "WYLocalNotifModel.h"
#import "secondCustomAlertView.h"
#import "QWUserDefault.h"
#import "QWLocalNotif.h"



@interface WYLocalNotifEditVC : QWBaseVC
<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (assign) BOOL isNew;
@property (retain, nonatomic) WYLocalNotifModel *modLocalNotif;
@property (nonatomic, strong) NSMutableArray    *useNameList;
@property (nonatomic, strong) NSArray           *periodList;
@property (nonatomic ,strong) secondCustomAlertView *customAlertView;
@property (nonatomic, strong) NSMutableArray    *listClock;

- (void)endEdit;
//- (void)naviRightBotton;
@end
