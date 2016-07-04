//
//  HistoryMsgListViewController.m
//  APP
//
//  Created by PerryChen on 6/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "HistoryMsgListViewController.h"
#import "SVProgressHUD.h"
#import "HistoryMsgListCell.h"
#import "IMApi.h"
#import "QWMessage.h"
#import "QWUnreadCountModel.h"
#import "XPChatViewController.h"
#import "QizOutOfDateListViewController.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"
#import "HisListOutOfDateCell.h"

@interface HistoryMsgListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (nonatomic, strong) NSMutableArray *arrMsgList;
@property (strong, nonatomic) NSMutableArray *arrServer;
@property (nonatomic, assign) BOOL isScrolling;
@property (strong ,nonatomic) NSMutableDictionary *controllerArr;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation HistoryMsgListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    self.arrMsgList = [@[] mutableCopy];
    [self setUpRightItem];
//    [self.tbViewContent addHeaderWithCallback:^{
//        [weakSelf.tbViewContent headerEndRefreshing];
//        if(QWGLOBALMANAGER.currentNetWork == NotReachable)
//        {
//            [SVProgressHUD showErrorWithStatus:@"网络未连接，请稍后再试" duration:0.8f];
//            return;
//        }
//        [weakSelf refreshConsultList];
//    }];
    
    [self enableSimpleRefresh:self.tbViewContent block:^(SRRefreshView *sender) {
        [weakSelf.tbViewContent headerEndRefreshing];
        if(QWGLOBALMANAGER.currentNetWork == NotReachable)
        {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请稍后再试" duration:0.8f];
            return;
        }
        [weakSelf refreshConsultList];
    }];
    
//    [self refreshConsultList];
    self.navigationItem.title = @"历史咨询";
    self.controllerArr = [NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [[QWGlobalManager sharedInstance].tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        [self showInfoView:kWarningN2 image:@"网络信号icon"];
    } else {
        self.passNumber = [QWGLOBALMANAGER updateRedPoint];
        [self setUpRightItem];

        [self getCachedMessages];
        [self.tbViewContent reloadData];
        if (self.arrMsgList.count == 0) {
            [self showInfoView:@"暂无咨询历史" image:@"ic_img_fail"];
        }
        [self refreshConsultList];
    }
    
}

#pragma mark - 返回
- (void)popVCAction:(id)sender
{
    [super popVCAction:sender];
}

#pragma mark - cache methods
- (void)getCachedMessages
{
    self.arrMsgList = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil WithorderBy:@" timestamp desc"]];
}

#pragma mark - Http service
- (void)refreshConsultList
{
    //全量拉取消息盒子数据
    ConsultCustomerModelR *modelR = [ConsultCustomerModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [Consult getConsultCustomerListWithParam:modelR success:^(ConsultCustomerListModel *responModel) {
        
        ConsultCustomerListModel *listModel = (ConsultCustomerListModel *)responModel;
        if (listModel.consults.count == 0) {
            [self showInfoView:@"暂无咨询历史" image:@"ic_img_fail"];
        } else {
            [self removeInfoView];
            [self.arrServer removeAllObjects];
            self.arrServer = [listModel.consults mutableCopy];
            [self syncDBtoLatest:listModel];
        }
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
        }
    }];
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self refreshConsultList];
    }
}

- (void)syncDBtoLatest:(ConsultCustomerListModel *)listModel
{
    __weak typeof (self) weakSelf = self;
    NSMutableArray *arrLoaded = [NSMutableArray arrayWithArray:listModel.consults];
    NSMutableArray *arrCached = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil]];
    NSMutableArray *arrNeedAdded = [@[] mutableCopy];
    NSMutableArray *arrNeedDeleted = [@[] mutableCopy];
    // 删除服务器上没有，本地有的缓存数据
    [arrCached enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HistoryMessages *modelHis = (HistoryMessages *)obj;
        BOOL isExist = NO;
        for (ConsultCustomerModel *modelConsult in arrLoaded) {
            if ([modelConsult.consultStatus intValue] == 3) {
                modelConsult.consultId = @"3";
            }
            if ([modelConsult.consultId intValue] == [modelHis.relatedid intValue]) {
                isExist = YES;
                break;
            }
        }
        if (!isExist) {
            [arrNeedDeleted addObject:modelHis];
        }
    }];
    for (HistoryMessages *modelHis in arrNeedDeleted) {
        [HistoryMessages deleteObjFromDBWithKey:[NSString stringWithFormat:@"%@",modelHis.relatedid]];
    }
    // 更新数据问题
    arrCached = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil WithorderBy:@"timestamp desc"]];
    __block NSInteger count = 0;
    [arrLoaded enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ConsultCustomerModel *modelConsult = (ConsultCustomerModel *)obj;
        if ([modelConsult.consultStatus intValue] == 3) {
            modelConsult.consultId = @"3";
        }
        NSUInteger indexFound = [weakSelf valueExists:@"relatedid" withValue:[NSString stringWithFormat:@"%@",modelConsult.consultId] withArr:arrCached];
        if (indexFound != NSNotFound) {
            // 更新Model
            HistoryMessages *modelMessage = [arrCached objectAtIndex:indexFound];
            [QWGLOBALMANAGER convertConsultModelToMessages:modelConsult withModelMessage:&modelMessage];
        } else {
            HistoryMessages *modelMessage = [QWGLOBALMANAGER createNewMessage:modelConsult];
            [arrNeedAdded addObject:modelMessage];
        }
    }];
    [arrCached addObjectsFromArray:arrNeedAdded];
    BOOL hasOutOfDate = NO;
    for (int i = 0; i < arrCached.count; i++) {
        HistoryMessages *model = (HistoryMessages *)arrCached[i];
        [HistoryMessages updateObjToDB:model WithKey:model.relatedid];
        if ([model.isOutOfDate intValue] == 0) {
            count += [model.systemUnreadCounts intValue];
            count += [model.unreadCounts intValue];
        } else {
            hasOutOfDate = YES;
        }

    }
//    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
//    if (hasOutOfDate) {
//        //        modelUnread.bool_ConsultShouldShowRed = @"1";
//    }
//    modelUnread.count_CounsultUnread = [NSString stringWithFormat:@"%d",count];
//    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
//    
//    [QWGLOBALMANAGER updateRedPoint];
    
    [self getCachedMessages];
    [self.tbViewContent reloadData];
}


#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryMessages *msgModel = self.arrMsgList[indexPath.row];
    if ([msgModel.isOutOfDate intValue] == 0) {
        // 普通群聊
        HistoryMsgListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryMsgListCell"];
        
        [cell setCell:msgModel];
        cell.sepeartorView.hidden = NO;
        if (indexPath.row == self.arrMsgList.count-1) {
            cell.sepeartorView.hidden = YES;
        }
        return cell;
    } else {
        // 过期问题集合
        HisListOutOfDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HisListOutOfDateCell"];
        [cell setCell:msgModel];
        cell.sepeartorView.hidden = NO;
        if (indexPath.row == self.arrMsgList.count-1) {
            cell.sepeartorView.hidden = YES;
        }
        return cell;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryMessages *msgModel = self.arrMsgList[indexPath.row];
    if ([msgModel.isOutOfDate intValue] == 0) {
        // 普通群聊
        return 90.0f;
    } else {
        // 过期问题集合
        return 52.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMsgList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (QWGLOBALMANAGER.loginStatus&&(QWGLOBALMANAGER.currentNetWork!=NotReachable)) {
        
        HistoryMessages* msg = self.arrMsgList[indexPath.row];
        if ([msg.isOutOfDate intValue] == 0) {
            XPChatViewController *demoViewController = nil;
            demoViewController = [[UIStoryboard storyboardWithName:@"XPChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"XPChatViewController"];
            if(msg) {
//                QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.isShowRedPoint intValue];
//                QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
//                NSInteger intTotalUnread = [modelUnread.count_NotifyListUnread intValue];
//                intTotalUnread -= [msg.isShowRedPoint intValue];
                
                // 设置msg的未读数
                msg.unreadCounts = @"0";
                msg.systemUnreadCounts = @"0";
                msg.isShowRedPoint = @"0";
                PharMsgModel *modelMsg = [PharMsgModel getObjFromDBWithWhere:@"type = 2"];
                modelMsg.unreadCounts = [NSString stringWithFormat:@"%d",[modelMsg.unreadCounts intValue]-[msg.isShowRedPoint intValue]];
                [PharMsgModel updateToDB:modelMsg where:@"type = 2"];
                [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
                MsgNotifyListModel *hisModel = [MsgNotifyListModel getObjFromDBWithKey:msg.relatedid];
                if (hisModel) {
                    hisModel.unreadCounts = @"0";
                    hisModel.systemUnreadCounts = @"0";
                    hisModel.showRedPoint = @"0";
                    [MsgNotifyListModel updateObjToDB:hisModel WithKey:hisModel.relatedid];
                }
                
//                modelUnread.count_NotifyListUnread = [NSString stringWithFormat:@"%d",intTotalUnread];
//                [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
//                [QWGLOBALMANAGER updateRedPoint];

            }
            demoViewController.historyMsg = msg;
            if ([msg.consultStatus intValue] == 1) {
                demoViewController.showType = MessageShowTypeNewCreate;
            }else if ([msg.consultStatus intValue] == 2) {
                demoViewController.showType = MessageShowTypeAnswering;
            } else if ([msg.consultStatus intValue] == 3) {
                demoViewController.showType = MessageShowTypeTimeout;
            } else {
                demoViewController.showType = MessageShowTypeClosed;
            }
            demoViewController.messageSender = [NSString stringWithFormat:@"%@",msg.relatedid];
            demoViewController.avatarUrl = msg.avatarurl;
            [self.navigationController pushViewController:demoViewController animated:YES];
        } else {
            PharMsgModel *modelMsg = [PharMsgModel getObjFromDBWithWhere:@"type = 2"];
            modelMsg.unreadCounts = [NSString stringWithFormat:@"%d",[modelMsg.unreadCounts intValue]-[msg.unreadCounts intValue]-[msg.systemUnreadCounts intValue]];
            [PharMsgModel updateToDB:modelMsg where:@"type = 2"];
//            QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
//            NSInteger intTotalUnread = [modelUnread.count_NotifyListUnread intValue];
//            intTotalUnread = intTotalUnread - [msg.unreadCounts intValue];
//            intTotalUnread = intTotalUnread - [msg.systemUnreadCounts intValue];
//            modelUnread.count_NotifyListUnread = [NSString stringWithFormat:@"%d",intTotalUnread];
//            if ([modelUnread.count_NotifyListUnread intValue] < 0) {
//                modelUnread.count_NotifyListUnread = @"0";
//            }
//            [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
            [QWGLOBALMANAGER updateRedPoint];
            NSArray *arrOutOfDate = [MsgNotifyListModel getArrayFromDBWithWhere:@"consultStatus = 3"];
            for (MsgNotifyListModel *modelList in arrOutOfDate) {
                modelList.unreadCounts = @"0";
                modelList.systemUnreadCounts = @"0";
                modelList.showRedPoint = @"0";
                [MsgNotifyListModel updateObjToDB:modelList WithKey:modelList.relatedid];
            }
            msg.unreadCounts = @"0";
            msg.systemUnreadCounts = @"0";
            msg.isShowRedPoint = @"0";
//            [HistoryMessages updateToDB:msg where:@"type = 2"];
            [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
            [self performSegueWithIdentifier:@"segueOutOfDate" sender:indexPath];
        }
    }
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiMessageBoxNeedUpdate) {
        [self getCachedMessages];
        [self.tbViewContent reloadData];
    }else if (NotiWhetherHaveNewMessage == type) {
        
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

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segueOutOfDate"]) {
        QizOutOfDateListViewController *vcOutOfDate = (QizOutOfDateListViewController *)segue.destinationViewController;
        NSIndexPath *path = (NSIndexPath *)sender;
        HistoryMessages *msgSelect = self.arrMsgList[path.row];
        vcOutOfDate.strMsgId = msgSelect.relatedid;
    }
}

@end
