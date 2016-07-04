//
//  MineCareCircleViewController.m
//  APP
//
//  Created by Martin.Liu on 16/1/5.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MineCareCircleViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
//#import "CircleTableCell.h"
#import "NewCircleTableCell.h"
#import "Forum.h"
#import "LoginViewController.h"
#import "CircleDetailViewController.h"

NSString *const kCircleTableCellIdentifier = @"NewCircleTableCell";

@interface MineCareCircleViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* circleArray;
@end

@implementation MineCareCircleViewController
//{
//    NSArray* myCircleArray;
//    NSArray* myAttnCircleArray;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注的圈子";
    self.tableView.backgroundColor = RGBHex(qwColor11);
    [self.tableView registerNib:[UINib nibWithNibName:@"NewCircleTableCell" bundle:nil] forCellReuseIdentifier:kCircleTableCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(QWGLOBALMANAGER.loginStatus) {
        [self loadData];
    }
}

- (NSMutableArray *)circleArray
{
    if (!_circleArray) {
        _circleArray = [NSMutableArray array];
    }
    return _circleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    GetMyCircleListR* getMyCircleListR = [GetMyCircleListR new];
    getMyCircleListR.token = QWGLOBALMANAGER.configure.userToken;
    [Forum getMyCircleList:getMyCircleListR success:^(QWMyCircleList *myCircleList) {
        [self.circleArray removeAllObjects];
        
        for (QWCircleModel* circleModel in myCircleList.teamList) {
            if ([circleModel respondsToSelector:@selector(setFlagMaster:)]) {
                [circleModel setFlagMaster:YES];
            }
        }
        for (QWCircleModel* circleModel in myCircleList.attnTeamList) {
            if ([circleModel respondsToSelector:@selector(setFlagMaster:)]) {
                [circleModel setFlagMaster:NO];
            }
        }
        [self.circleArray addObjectsFromArray:myCircleList.teamList];
        [self.circleArray addObjectsFromArray:myCircleList.attnTeamList];
//        myCircleArray = myCircleList.teamList;
//        myAttnCircleArray = myCircleList.attnTeamList;
//        if (myCircleArray.count == 0 && myAttnCircleArray.count == 0) {
//            [self showInfoView:@"暂无关注的圈子" image:@"ic_img_fail"];
//        }
        if (self.circleArray.count == 0) {
            [self showInfoView:@"暂无关注的圈子" image:@"ic_img_fail"];
        }
        else
        {
            [self removeInfoView];
        }
        [self.tableView reloadData];
    } failure:^(HttpException *e) {
        DebugLog(@"get my CircleList : %@", e);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark - UITableView delegate'
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    NSInteger numberOfSection = 0;
//    if (myCircleArray.count > 0) {
//        numberOfSection++;
//    }
//    if (myAttnCircleArray.count > 0) {
//        numberOfSection++;
//    }
//    return numberOfSection;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0 && myCircleArray.count > 0) {
//        return myCircleArray.count;
//    }
//    return myAttnCircleArray.count;
    return self.self.circleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewCircleTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kCircleTableCellIdentifier forIndexPath:indexPath];
    [self configure:cell indexPath:indexPath];
    return cell;
}

- (void)configure:(id)cell indexPath:(NSIndexPath*)indexPath
{
//    if (indexPath.section == 0 && myCircleArray.count > 0) {
//        QWCircleModel* circle = myCircleArray[indexPath.row];
//        [cell setCell:circle];
//    }
//    else
//    {
//        QWCircleModel* circle = myAttnCircleArray[indexPath.row];
//        [cell setCell:circle];
//    }
    if (self.circleArray.count > indexPath.row) {
        QWCircleModel* circle = self.circleArray[indexPath.row];
        [cell setCell:circle];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kCircleTableCellIdentifier configuration:^(id cell) {
        [self configure:cell indexPath:indexPath];
    }];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 45;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, height)];
//    view.backgroundColor = RGBHex(qwColor11);
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APP_W - 15 * 2, height)];
//    label.font = [UIFont systemFontOfSize:kFontS4];
//    label.textColor = RGBHex(qwColor8);
//    NSString* title;
//    title = (section == 0 && myCircleArray.count > 0) ? @"我的圈子" : @"我关注的圈子";
//    label.text = title;
//    [view addSubview:label];
//    return view;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0 && myCircleArray.count > 0) {
//        QWCircleModel* circle = myCircleArray[indexPath.row];
//        CircleDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.teamId = circle.teamId;
//        vc.title = [NSString stringWithFormat:@"%@圈",circle.teamName];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else
//    {
//        if (indexPath.row < myAttnCircleArray.count) {
//            QWCircleModel* circle = myAttnCircleArray[indexPath.row];
//            [QWGLOBALMANAGER statisticsEventId:@"x_wd_gzdqz_dj" withLable:@"我关注的圈子-点击某个圈子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"圈子名":StrDFString(circle.teamName, @"圈子名")}]];
//            CircleDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.teamId = circle.teamId;
//            vc.title = [NSString stringWithFormat:@"%@圈",circle.teamName];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }
    if (self.circleArray.count > indexPath.row) {
        QWCircleModel* circle = self.circleArray[indexPath.row];
        CircleDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.teamId = circle.teamId;
        vc.title = [NSString stringWithFormat:@"%@圈",circle.teamName];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotifKickOff) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (type == NotifLoginSuccess)
    {
        [self loadData];
    }
}

@end
