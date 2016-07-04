//
//  MessageBoxViewController.m
//  wenyao
//
//  Created by garfield on 15/1/19.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "MessageBoxViewController.h"
//#import "HomePageTableViewCell.h"
#import "XHDemoWeChatMessageTableViewController.h"
#import "AppDelegate.h"
#import "MKNumberBadgeView.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"

#import "QuanweiYaoShiCell.h"
#import "MessageBoxCell.h"

#import "css.h"
#import "ReturnIndexView.h"

#import "QWGlobalManager.h"
#import "SVProgressHUD.h"
#import "Store.h"

#import "IMApi.h"
#import "QWMessage.h"
#import "StoreModel.h"

#import "Consult.h"
#import "ConsultModelR.h"
#import "ConsultModel.h"
#import "NotificationModel.h"

@interface MessageBoxViewController () <MGSwipeTableCellDelegate, UIScrollViewDelegate,ReturnIndexViewDelegate>

//@property (nonatomic, strong) NSMutableArray        *historyList;
@property (nonatomic, strong) UIButton              *unreadMenu;
@property (nonatomic, strong) UIButton              *backCoverView;
@property (strong ,nonatomic) NSMutableDictionary *controllerArr;
@property (strong, nonatomic) NSMutableArray *arrMessageBox;
@property (strong, nonatomic) NSMutableArray *arrServer;
@property (assign, nonatomic) NSInteger intOfficialMsgUnreadCount;
@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, strong) ReturnIndexView *indexView;
@end

@implementation MessageBoxViewController

//changedByYYX

//- (void)popVCAction:(id)sender{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIView animateWithDuration:1.0 delay:0.7 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    self.intOfficialMsgUnreadCount = 0;
    self.arrMessageBox = [@[] mutableCopy];
    self.arrServer = [@[] mutableCopy];
    self.navigationItem.title = @"消息盒子";
    [self.view setBackgroundColor:RGBHex(kColor13)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-unfold"] style:UIBarButtonItemStylePlain target:self action:@selector(showUnreadMenu)];
//    [self setupUnreadButton];
    [self setUpRightItem];
    [self getCachedMessages];
    [self.tableView reloadData];
//    [self refreshConsultList];
    __weak typeof (self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        [weakSelf.tableView headerEndRefreshing];
        if(QWGLOBALMANAGER.currentNetWork == NotReachable)
        {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请稍后再试" duration:0.8f];
            return;
        }
        [weakSelf refreshConsultList];
    }];
    self.controllerArr = [NSMutableDictionary dictionary];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshConsultList];
}

- (void)refreshConsultList
{
    //全量拉取消息盒子数据
    ConsultCustomerModelR *modelR = [ConsultCustomerModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [Consult getConsultCustomerListWithParam:modelR success:^(ConsultCustomerListModel *responModel) {
        ConsultCustomerListModel *listModel = (ConsultCustomerListModel *)responModel;
        [self.arrServer removeAllObjects];
        self.arrServer = [listModel.consults mutableCopy];
        [self syncDBtoLatest:listModel];
        

    } failure:^(HttpException *e) {
        
    }];
}

// 根据某个consultId 更新cell
- (void)updateCellForConsultId:(NSString *)consultId type:(NSInteger)type
{
    if (consultId.length <= 0) {
        return;
    }
    if (self.arrMessageBox.count <= 0) {
        [self getCachedMessages];
    }
    for (HistoryMessages *modelMes in self.arrMessageBox) {
        if ([modelMes.relatedid intValue] == [consultId intValue]) {
            if (type == 3) {
                modelMes.consultStatus = @"4";
            } else if (type == 4) {
                modelMes.consultStatus = @"3";
            }
        }
        [HistoryMessages updateObjToDB:modelMes WithKey:modelMes.relatedid];
    }
    [self getCachedMessages];
    [self.tableView reloadData];
}
// 通知列表更新发送状态
- (void)updateAllSendStatus
{
    NSArray *paths = [self.tableView indexPathsForVisibleRows];
    [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateUnreadCountToServer:(HistoryMessages *)modelMessage
{
    DebugLog(@"the id is %@, the unread count is %@", modelMessage.relatedid, modelMessage.unreadCounts);
}

- (void)getCachedMessages
{
    self.arrMessageBox = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil WithorderBy:@" timestamp desc"]];

}

- (void)syncDBtoLatest:(ConsultCustomerListModel *)listModel
{
    __weak MessageBoxViewController *weakSelf = self;
    NSMutableArray *arrLoaded = [NSMutableArray arrayWithArray:listModel.consults];
    NSMutableArray *arrCached = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil]];
    NSMutableArray *arrNeedAdded = [@[] mutableCopy];
    NSMutableArray *arrNeedDeleted = [@[] mutableCopy];
    // 删除服务器上没有，本地有的缓存数据
    [arrCached enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HistoryMessages *modelHis = (HistoryMessages *)obj;
        BOOL isExist = NO;
        for (ConsultCustomerModel *modelConsult in arrLoaded) {
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
    NSLog(@"Arr cached,%@",arrCached);
    __block NSInteger count = 0;
    [arrLoaded enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ConsultCustomerModel *modelConsult = (ConsultCustomerModel *)obj;
        NSUInteger indexFound = [weakSelf valueExists:@"relatedid" withValue:[NSString stringWithFormat:@"%@",modelConsult.consultId] withArr:arrCached];
        if (indexFound != NSNotFound) {
            // 更新Model
            HistoryMessages *modelMessage = [arrCached objectAtIndex:indexFound];
            if ([modelMessage.consultStatus intValue] == 3) {
                modelMessage.isOutOfDate = @"1";
            }
//            if ([modelMessage.consultStatus intValue] == 4) {
//                modelMessage.ClosedisRead = @"1";
//            }
//            if (([modelMessage.consultStatus intValue] == 3)||([modelMessage.consultStatus intValue] == 4)) {
//                modelMessage.qizHasReadCloseOrOutDate = @"1";
//                modelMessage.spreadHasReaded = @"1";
//            }
            [QWGLOBALMANAGER convertConsultModelToMessages:modelConsult withModelMessage:&modelMessage];
            if ([modelConsult.consultType intValue] == 1) {
                // 群发
                modelMessage.diffusion = YES;
            } else {
                // 指定
                modelMessage.diffusion = NO;
            }
        } else {
            HistoryMessages *modelMessage = [QWGLOBALMANAGER createNewMessage:modelConsult];
            [arrNeedAdded addObject:modelMessage];
        }
    }];
    
    [arrCached addObjectsFromArray:arrNeedAdded];
    for (int i = 0; i < arrCached.count; i++) {
        HistoryMessages *model = (HistoryMessages *)arrCached[i];
        [HistoryMessages updateObjToDB:model WithKey:model.relatedid];
//        if ([model.spreadHasReaded intValue] == 0) {
//            count += [model.isSpreadMsg intValue];
//        }
        if ([model.ClosedisRead intValue] == 0) {
            count += [model.isClosed intValue];
        }
        count += [model.unreadCounts intValue];
    }
    [QWGLOBALMANAGER updateUnreadCountBadge:count];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:count forKey:APP_BADGE_COUNT];
    [user synchronize];
    [self getCachedMessages];
    [self.tableView reloadData];
}

- (void)quitAccount:(NSNotification *)noti
{
    [self.tableView reloadData];
}

#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -6;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-unfold.PNG"] style:UIBarButtonItemStylePlain target:self action:@selector(returnIndex)];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
}
- (void)returnIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"icon home.PNG",@"icon mark.PNG"] title:@[@"首页",@"全部已读"] passValue:-1];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    if (indexPath.row == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }else if (indexPath.row == 1){
        [self setAllMessageReaded];
    }
    
}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------


- (void)setAllMessageReaded
{
    ConsultModelR *modelR = [ConsultModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [Consult updateConsultAllReaded:modelR success:^(ConsultModel *responModel) {
        ConsultModel *modelR = (ConsultModel *)responModel;
        if ([modelR.apiStatus intValue] == 0) {
            [self getCachedMessages];
            for (HistoryMessages *modelHis in self.arrMessageBox) {
                modelHis.isRead = @"1";
                modelHis.unreadCounts = @"0";
                modelHis.spreadHasReaded = @"1";
                modelHis.isSpreadMsg = @"0";
                modelHis.isQizCloseOrOutDate = @"0";
                modelHis.qizHasReadCloseOrOutDate = @"1";
                [HistoryMessages updateObjToDB:modelHis WithKey:modelHis.relatedid];
            }
        }
        [self.tableView reloadData];
    } failure:^(HttpException *e) {
        
    }];
    NSArray *array =  [OfficialMessages getArrayFromDBWithWhere:nil];
    for (OfficialMessages *msg in array) {
        msg.issend = @"1";
        [OfficialMessages updateObjToDB:msg WithKey:msg.UUID];
    }
    [self.tableView reloadData];
    [self showUnreadMenu];
    
    //更新红点
    [QWGLOBALMANAGER updateUnreadCountBadge:0];
}

- (void)setupUnreadButton
{
    _backCoverView = [UIButton buttonWithType:UIButtonTypeCustom];
    _backCoverView.frame = CGRectMake(0, 0, APP_W, APP_H);
    [_backCoverView setBackgroundColor:[UIColor clearColor]];
    _backCoverView.hidden = YES;
    [self.view addSubview:_backCoverView];
    [_backCoverView addTarget:self action:@selector(dismissUnreadMenu:) forControlEvents:UIControlEventTouchDown];
    
    _unreadMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *menuImage = [UIImage imageNamed:@"all_message_readed"];
    [_unreadMenu setBackgroundImage:menuImage forState:UIControlStateNormal];

    _unreadMenu.translatesAutoresizingMaskIntoConstraints = NO;
    [_unreadMenu setTitle:@"全部消息标为已读" forState:UIControlStateNormal];
    _unreadMenu.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_unreadMenu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_unreadMenu addTarget:self action:@selector(setAllMessageReaded) forControlEvents:UIControlEventTouchDown];
    
    float hPadding = APP_W - menuImage.size.width - 15;
    float hWidth = menuImage.size.width;
    float vHeight = menuImage.size.height;

    [self.view addSubview:_unreadMenu];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-hPadding-[_unreadMenu(hWidth)]" options:0 metrics:@{@"hPadding":[NSNumber numberWithFloat:hPadding],@"hWidth":[NSNumber numberWithFloat:hWidth]} views:NSDictionaryOfVariableBindings(_unreadMenu,self.view)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_unreadMenu(vHeight)]" options:0 metrics:@{@"vHeight":[NSNumber numberWithFloat:vHeight]} views:NSDictionaryOfVariableBindings(_unreadMenu,self.view)]];
    _unreadMenu.hidden = YES;
}

- (void)showUnreadMenu
{
    [UIView animateWithDuration:0.25f animations:^{
        self.unreadMenu.hidden = !self.unreadMenu.hidden;
    } completion:^(BOOL finished) {
        if(self.unreadMenu.hidden) {
            _backCoverView.hidden = YES;
        }else{
            _backCoverView.hidden = NO;
        }
    }];
}

- (IBAction)dismissUnreadMenu:(id)sender
{
    self.unreadMenu.hidden = YES;
    _backCoverView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)createRightButtons:(int)number stick:(BOOL)stick
{
    NSMutableArray * result = [NSMutableArray array];
    if(number == 1) {
        NSString* titles[1] = {@"清除记录"};
        UIColor * colors[1] = {[UIColor redColor]};
        for (int i = 0; i < number; ++i)
        {
            MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
                return YES;
            }];
            [result addObject:button];
        }
    }else{
        NSArray *titles = nil;
        
        titles = @[@"删除"];
        
        UIColor * colors[1] = {[UIColor redColor],};
        for (int i = 0; i < 1; ++i)
        {
            MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
                return YES;
            }];
            [result addObject:button];
        }
    }
    return result;
}

#pragma mark -
#pragma mark MGSwipeTableCellDelegate
-(NSArray*) swipeTableCell:(MGSwipeTableCell*)cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*)swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*)expansionSettings;
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSUInteger index = indexPath.row;

    if(direction == MGSwipeDirectionRightToLeft && index == 0)
    {
        return [self createRightButtons:1 stick:YES];;
    }else if (direction == MGSwipeDirectionRightToLeft) {
        return [self createRightButtons:2 stick:YES];
    }
    return nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSUInteger currentIndex = indexPath.row;
    if (currentIndex == 0)
    {
        //清除全维药师官方记录
//        [OfficialMessages deleteAllObjFromDB];
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        /*
        HistoryMessages *msg = self.historyList[currentIndex - 1];
        NSString *relatedid = msg.relatedid;
        if (index == 0) {

            //删除某个消息 表HistoryMessages
            [HistoryMessages deleteObjFromDBWithKey:relatedid];
            
            //删除某个消息 表Messages
            [QWMessage deleteObjFromDBWithWhere:[NSString stringWithFormat:@"sendname = '%@' or recvname = '%@'",relatedid,relatedid]];
            
            [QWGLOBALMANAGER updateUnreadCountBadge];
            //删除所有聊天记录
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"token"] = QWGLOBALMANAGER.configure.userToken;
            param[@"to"] = relatedid;
            [IMApi deleteallWithParams:param success:NULL failure:NULL];
            [self.historyList removeObjectAtIndex:currentIndex - 1];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }else{
            
            //置顶或者取消置顶
            if([msg.stick integerValue] == 1)
            {
                msg.stick = @"0";
                [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
                
            }else{
                msg.stick = @"1";
                [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
            }
            
            self.historyList = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil]];
            [self.tableView reloadData];
        }
         */
    }
    return YES;
}

#pragma mark
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMessageBox.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.row;
    
    switch (index)
    {
        case 0:
        {
            static NSString *QuanweiYaoShiCellIdentfier = @"QuanweiYaoShiCell";
            QuanweiYaoShiCell *cell = (QuanweiYaoShiCell *)[atableView dequeueReusableCellWithIdentifier:QuanweiYaoShiCellIdentfier];
            if(cell == nil)
            {
                UINib *nib = [UINib nibWithNibName:@"QuanweiYaoShiCell" bundle:nil];
                [atableView registerNib:nib forCellReuseIdentifier:QuanweiYaoShiCellIdentfier];
                cell = (QuanweiYaoShiCell *)[atableView dequeueReusableCellWithIdentifier:QuanweiYaoShiCellIdentfier];
            }
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 73, APP_W, 0.5)];
            line.backgroundColor = RGBHex(kColor8);
            [cell addSubview:line];
            
            cell.sendIndicateImage.hidden = YES;
            cell.titleLabel.text = @"全维药事";
            [cell.avatarImage setImage:[UIImage imageNamed:@"news_icon_quwei"]];
            cell.nameIcon.image = [UIImage imageNamed:@"official"];

            //查找最后一条更新的官方消息
            OfficialMessages* msg = [OfficialMessages getObjFromDBWithWhere:nil WithorderBy:@"timestamp desc"];
            if (msg) {
                cell.contentLabel.text = msg.body;
                double timestamp = [msg.timestamp doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
                cell.dateLabel.text = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:date];
            }else{
                cell.contentLabel.text = WELCOME_MESSAGE;
                NSDate *dateNow = [NSDate date];
                cell.dateLabel.text = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:dateNow];
//                cell.dateLabel.text = @"";
            }
         
            //未读官方消息数量
            self.intOfficialMsgUnreadCount = [OfficialMessages getcountFromDBWithWhere:@"issend = 0"];
            MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[cell.contentView viewWithTag:888];
            if(!badgeView) {
                badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(35, -5, 40, 40)];
                badgeView.shadow = NO;
                badgeView.tag = 888;
            }
            if(self.intOfficialMsgUnreadCount != 0 )
            {
                badgeView.value = self.intOfficialMsgUnreadCount;
                [cell.contentView addSubview:badgeView];
            }else{
                [badgeView removeFromSuperview];
            }
            
//            cell.swipeDelegate = self;
            return cell;
            
            break;
        }
        default:
        {
            static NSString *MessageBoxCellIdentfier = @"MessageBoxCell";
            MessageBoxCell *cell = (MessageBoxCell *)[atableView dequeueReusableCellWithIdentifier:MessageBoxCellIdentfier];
            if(cell == nil)
            {
                UINib *nib = [UINib nibWithNibName:@"MessageBoxCell" bundle:nil];
                [atableView registerNib:nib forCellReuseIdentifier:MessageBoxCellIdentfier];
                cell = (MessageBoxCell *)[atableView dequeueReusableCellWithIdentifier:MessageBoxCellIdentfier];
            } else {
                cell.titleLabel.text = @"";
                cell.contentLabel.text = @"";
                cell.dateLabel.text = @"";
                cell.nameIcon.hidden = YES;
                cell.sendIndicateImage.hidden = YES;
                cell.avatarImage.hidden = YES;
                [cell.activityIndicator stopAnimating];
            }
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 73, APP_W, 0.5)];
            line.backgroundColor = RGBHex(kColor8);
            [cell addSubview:line];
            
            HistoryMessages *msg = self.arrMessageBox[index-1];
            cell.contentLabel.text = msg.body;
            double timestamp = [msg.timestamp doubleValue];
            timestamp = timestamp / 1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
            cell.dateLabel.text = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:date];
            
            HistoryMessages *hisModel = [HistoryMessages getObjFromDBWithKey:msg.relatedid];
            
            MKNumberBadgeView *badgeView = (MKNumberBadgeView *)[cell.contentView viewWithTag:888];
            if(!badgeView) {
                badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(25, 0, 40, 40)];
                badgeView.shadow = NO;
                badgeView.tag = 888;
            }

            NSInteger unreadCount = [msg.unreadCounts intValue];
            
            if ([msg.qizHasReadCloseOrOutDate intValue] == 0) {
                unreadCount = unreadCount + [msg.isQizCloseOrOutDate intValue];
            }
            if ([msg.spreadHasReaded intValue] == 0) {
                unreadCount = unreadCount + [msg.isSpreadMsg intValue];
            }
            
            
            if(unreadCount != 0 )
            {
                badgeView.value = unreadCount;
                [cell.contentView addSubview:badgeView];
            }else{
                [badgeView removeFromSuperview];
            }
            
            
            if (hisModel != nil) {
//                if (msg.issend == nil) {
//                    msg.issend = @"0";
//                }
//                NSLog(@"the issend is %@",hisModel.issend);
                if (hisModel.issend == nil) {
                    hisModel.issend = @"0";
                }
                NSLog(@"##### the is send is %@",hisModel.issend);
                switch ([hisModel.issend intValue]) {
                    case 1:
                    {
                        // 正在发送
                        cell.sendIndicateImage.hidden = YES;
                        [cell.activityIndicator startAnimating];
                    }
                        break;
                    case 2:
                    {
                        // 发送成功
                        cell.sendIndicateImage.hidden = YES;
                        [cell.activityIndicator stopAnimating];
                    }
                        break;
                    case 3:
                    {
                        // 发送失败
                        cell.sendIndicateImage.hidden = NO;
                        [cell.activityIndicator stopAnimating];
                    }
                        break;
                    default:
                        break;
                }
            }
            
//            1等待药师回复、2药师已回复、3问题已过期、4问题已关闭, 5抢而未答
            cell.avatarImage.hidden = NO;
            if (msg.consultStatus == nil) {
                msg.consultStatus = @"0";
            }
            cell.nameIcon.hidden = YES;
            
            switch ([msg.consultStatus intValue]) {
                case 1:
                {
                    [cell.avatarImage setImage:[UIImage imageNamed:@"news_icon_waiting"]];
                    if (msg.diffusion) {            // 是问所有药师
                        cell.titleLabel.text = @"等待药师回复";
                    } else {                        // 问某个药师
                        NSString *strTitle = @"";
                        if (msg.groupName.length > 0) {
                            strTitle = [NSString stringWithFormat:@"等待%@药师回复",msg.groupName]; //msg.groupName;
                        } else {
                            strTitle = @"等待药师回复";
                        }
                        cell.titleLabel.text = strTitle;
                        if ([msg.pharType intValue] == 2) {
                            cell.nameIcon.hidden = NO;
                        } else {
                            cell.nameIcon.hidden = YES;
                        }
                    }
                }
                    break;
                case 2:
                {
                    NSString *strTitle = @"";
                    if (msg.groupName.length > 0) {
                        strTitle = [NSString stringWithFormat:@"%@药师",msg.groupName]; //msg.groupName;
                    } else {
                        strTitle = @"药师";
                    }
                    cell.titleLabel.text = strTitle;
                    [cell.avatarImage setImageWithURL:[NSURL URLWithString:msg.avatarurl] placeholderImage:[UIImage imageNamed:@"news_icon_default avatar"]];
                    if ([msg.pharType intValue] == 2) {
                        cell.nameIcon.hidden = NO;
                    } else {
                        cell.nameIcon.hidden = YES;
                    }
                }
                    break;
                case 3:
                {
                    if (msg.diffusion) {            // 是问所有药师
                        cell.titleLabel.text = @"问题已过期";
                    } else {                        // 问某个药师
                        NSString *strTitle = @"";
                        if (msg.groupName.length > 0) {
                            strTitle = [NSString stringWithFormat:@"%@药师",msg.groupName]; //msg.groupName;
                        } else {
                            strTitle = @"药师";
                        }
                        cell.titleLabel.text = strTitle;
                        if ([msg.pharType intValue] == 2) {
                            cell.nameIcon.hidden = NO;
                        } else {
                            cell.nameIcon.hidden = YES;
                        }
                    }

                    [cell.avatarImage setImage:[UIImage imageNamed:@"news_icon_over time"]];
                }
                    break;
                case 4:
                {
                    NSString *strTitle = @"";
                    if (msg.groupName.length > 0) {
                        strTitle = [NSString stringWithFormat:@"%@药师",msg.groupName];
                    } else {
                        strTitle = @"药师";
                    }
                    cell.titleLabel.text = strTitle;
                    [cell.avatarImage setImageWithURL:[NSURL URLWithString:msg.avatarurl] placeholderImage:[UIImage imageNamed:@"news_icon_default avatar"]];
                    if ([msg.pharType intValue] == 2) {
                        cell.nameIcon.hidden = NO;
                    } else {
                        cell.nameIcon.hidden = YES;
                    }
//                    cell.titleLabel.text = @"问题已关闭";
//                    [cell.avatarImage setImage:[UIImage imageNamed:@"news_icon_over time"]];
                }
                    break;
                case 5:
                {
                    [cell.avatarImage setImage:[UIImage imageNamed:@"news_icon_waiting"]];
                    if (msg.diffusion) {            // 是问所有药师
                        cell.titleLabel.text = @"等待药师回复";
                    } else {                        // 问某个药师
                        NSString *strTitle = @"";
                        if (msg.groupName.length > 0) {
                            strTitle = [NSString stringWithFormat:@"等待%@药师回复",msg.groupName]; //msg.groupName;
                        } else {
                            strTitle = @"等待药师回复";
                        }
                        cell.titleLabel.text = strTitle;
                        if ([msg.pharType intValue] == 2) {
                            cell.nameIcon.hidden = NO;
                        } else {
                            cell.nameIcon.hidden = YES;
                        }
                    }
                }
                    break;
                default:
                {
                    cell.titleLabel.text = @"等待药师回复";
                    [cell.avatarImage setImage:[UIImage imageNamed:@"news_icon_waiting"]];
                }
                    break;
            }
            NSLog(@"the pahr type is %@",msg.pharType);
            
            
            return cell;
        }
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 0:
        {
          // change  by shen
            NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            XHDemoWeChatMessageTableViewController *demoViewController = nil;
            if ([self.controllerArr objectForKey:indexStr]) {
                demoViewController = [self.controllerArr objectForKey:indexStr];
            }else
            {
                demoViewController = [[XHDemoWeChatMessageTableViewController alloc] init];
                [self.controllerArr setValue:demoViewController forKey:indexStr];
            }
            QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - self.intOfficialMsgUnreadCount;
            [QWGLOBALMANAGER updateUnreadCountBadge:QWGLOBALMANAGER.unReadCount];
            demoViewController.hidesBottomBarWhenPushed = YES;
            demoViewController.accountType = OfficialType;
           
            [self.navigationController pushViewController:demoViewController animated:YES];
            // change en d
            break;
        }
        default:
        {
            
            if (QWGLOBALMANAGER.loginStatus) {
                HistoryMessages* msg = self.arrMessageBox[indexPath.row - 1];
                XHDemoWeChatMessageTableViewController *messageViewController = [[XHDemoWeChatMessageTableViewController  alloc] init];
                if(msg) {
                    QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.unreadCounts intValue];
                    if ([msg.spreadHasReaded intValue] == 0) {
                        if (msg.isSpreadMsg == nil) {
                            msg.isSpreadMsg = @"0";
                        }
                        QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.isSpreadMsg intValue];
                    }
                    if ([msg.qizHasReadCloseOrOutDate intValue] == 0) {
                        if (msg.isQizCloseOrOutDate == nil) {
                            msg.isQizCloseOrOutDate = @"0";
                        }
                        QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.isQizCloseOrOutDate intValue];
                    }
                    msg.spreadHasReaded = @"1";
                    msg.isSpreadMsg = @"0";
                    msg.isQizCloseOrOutDate = @"0";
                    msg.qizHasReadCloseOrOutDate = @"1";
                    msg.unreadCounts = @"0";
                    
                    
                    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
                    dispatch_async(aQueue, ^(void) {
                        [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
                    });
                    
                    [QWGLOBALMANAGER updateUnreadCountBadge:QWGLOBALMANAGER.unReadCount];
                }
                messageViewController.historyMsg = msg;
                if ([msg.consultStatus intValue] == 1) {
                    messageViewController.showType = MessageShowTypeNewCreate;
                }else if ([msg.consultStatus intValue] == 2) {
                    messageViewController.showType = MessageShowTypeAnswering;
                } else if ([msg.consultStatus intValue] == 3) {
                    messageViewController.showType = MessageShowTypeTimeout;
                } else {
                    messageViewController.showType = MessageShowTypeClosed;
                }
                messageViewController.messageSender = [NSString stringWithFormat:@"%@",msg.relatedid];
                messageViewController.avatarUrl = msg.avatarurl;
                [self.navigationController pushViewController:messageViewController animated:YES];
            }
        }
        break;
    }
}

- (void)updateUnread:(HistoryMessages *)msg arrDetails:(NSArray *)arrItems
{
//    NSArray *arrItems = @[@"18033",@"18034"];
    NSString *strItems = [arrItems componentsJoinedByString:SeparateStr];
    ConsultItemReadModelR *modelR = [ConsultItemReadModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.consultId = msg.relatedid;
    modelR.detailIds = strItems;
    [Consult updateConsultItemRead:modelR success:^(ConsultModel *responModel) {
        
    } failure:^(HttpException *e) {
        
    }];
}

#pragma mark -
#pragma mark 处理本视图收到的通知

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    
    //接收登陆成功的通知
    
    switch (type) {
        case NotifLoginSuccess:
        case NotifMessageNeedUpdate:
        case NotifMessageOfficial:
            [self refreshHistory:nil];
            break;
        case NotifQuitOut:
            [self quitAccount:nil];
            break;
        case NotiNewUnreadMessage:
            [self refreshHistory:nil];
            break;
        case NotiMessageBoxUpdateList:      // 刷新列表
        {
            if (self.isScrolling) {
                return;
            }
            NSLog(@"####通知，请更新列表");
            if ([data isKindOfClass:[ConsultCustomerListModel class]]) {
                ConsultCustomerListModel *listModel = (ConsultCustomerListModel *)data;
                if (listModel.consults.count <= 0) {
                    return;
                }
                __weak MessageBoxViewController *weakSelf = self;
                dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
                dispatch_async(aQueue, ^(void) {

                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getCachedMessages];
                        NSArray *paths = [weakSelf.tableView indexPathsForVisibleRows];
                        [weakSelf.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
                    });
                });
            }
        }
            // data 是列表数据
            
            break;
        case NotiMessageBoxUpdateStatue:   // 更新某个cell状态
            // 消息id 消息类型
            /*
             type：//3:问题已关闭 4:  问题已过期   5: 第二次扩散
             id：//问题id
             */
        {
            if (self.isScrolling) {
                return;
            }
            if ([data isKindOfClass:[NotificationModel class]]) {
                NSLog(@"### 更新某个cell");
                NotificationModel *modelNoti = (NotificationModel *)data;
                [self updateCellForConsultId:modelNoti.consultid type:[modelNoti.type intValue]];
            }
        }
            break;
        case NotiMessageBoxNeedUpdate:
        {
            NSLog(@"### 更新发送状态");
            [self updateAllSendStatus];
        
            break;
        }
            case NotimessageBoxUpdate:
        {
            [self refreshHistory:nil];
            break;
        }
        default:
            break;
    }
}

- (void)refreshHistory:(NSNotification *)noti
{
    //查找所有的历史消息
    NSLog(@"$$$##### 收到通知啦");
    [self getCachedMessages];
    [self.tableView reloadData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isScrolling = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isScrolling = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.isScrolling = YES;
}

@end
