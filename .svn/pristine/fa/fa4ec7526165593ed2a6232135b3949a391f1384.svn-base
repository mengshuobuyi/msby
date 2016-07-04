//
//  MsgNotifyListViewController.m
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgNotifyListViewController.h"
#import "QuanweiYaoShiCell.h"
#import "XHDemoWeChatMessageTableViewController.h"
#import "QWUnreadCountModel.h"
@interface MsgNotifyListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSInteger intOfficialMsgUnreadCount;
@property (strong ,nonatomic) NSMutableDictionary *controllerArr;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@end

@implementation MsgNotifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.intOfficialMsgUnreadCount = 0;
    self.controllerArr = [NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshContent
{
    [self.tbViewContent reloadData];
}

- (void)refreshView
{
     [self.tbViewContent reloadData];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuanweiYaoShiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuanweiYaoShiCell"];
    self.intOfficialMsgUnreadCount = [OfficialMessages getcountFromDBWithWhere:@"issend = 0"];
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    modelUnread.count_NotiUnread = [NSString stringWithFormat:@"%d",self.intOfficialMsgUnreadCount];
    if (self.intOfficialMsgUnreadCount == 0) {
        modelUnread.bool_NotiShouldShowRed = NO;
    } else {
        modelUnread.bool_NotiShouldShowRed = YES;
    }
    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
    [QWGLOBALMANAGER updateRedPoint];
    [cell setCell:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static QuanweiYaoShiCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:@"QuanweiYaoShiCell"];
    });
    [sizingCell setCell:nil];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *indexStr = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    XHDemoWeChatMessageTableViewController *demoViewController = nil;
    if ([self.controllerArr objectForKey:indexStr]) {
        demoViewController = [self.controllerArr objectForKey:indexStr];
    }else
    {
        demoViewController = [[XHDemoWeChatMessageTableViewController alloc] init];
        [self.controllerArr setValue:demoViewController forKey:indexStr];
    }
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    modelUnread.count_NotiUnread = [NSString stringWithFormat:@"%d",[modelUnread.count_NotiUnread intValue] - self.intOfficialMsgUnreadCount];
    modelUnread.bool_NotiShouldShowRed = NO;
    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
    [QWGLOBALMANAGER updateRedPoint];
    demoViewController.hidesBottomBarWhenPushed = YES;
    demoViewController.accountType = OfficialType;
    
    [self.parentViewController.navigationController pushViewController:demoViewController animated:YES];
}
#pragma mark -
#pragma mark 处理本视图收到的通知
- (void)quitAccount:(NSNotification *)noti
{
    [self.tbViewContent reloadData];
}
- (void)refreshHistory:(NSNotification *)noti
{
    //查找所有的历史消息
    [self.tbViewContent reloadData];
}
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    
    //接收登陆成功的通知
    switch (type) {
        case NotifLoginSuccess:
        case NotifMessageOfficial:
            [self refreshHistory:nil];
            break;
        case NotifQuitOut:
            [self quitAccount:nil];
            break;
        default:
            break;
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
