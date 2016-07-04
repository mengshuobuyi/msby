//
//  CircleSquareViewController.m
//  APP
//  圈子广场
//  接口
//  API_HealthCircle_Square        @"h5/team/teamSquare"          // 用户端-圈子广场（更多圈子）
//  Created by Martin.Liu on 16/6/21.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CircleSquareViewController.h"
#import "Forum.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CircleSquareTableCell.h"
#import "CircleSquareEmptyTableCell.h"
#import "cssex.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "CircleDetailViewController.h"
NSString *const kCircleSquareTablecellIdentifier = @"CircleSquareTableCell";
NSString *const kCircleSquareEmptyTablecellIdentifier = @"CircleSquareEmptyTableCell";

@interface CircleSquareViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray* attentionCircleArray;   // 我关注的圈子列表
@property (nonatomic, strong) NSArray* recommendCircleArray;    // 推荐的圈子列表
@end

@implementation CircleSquareViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"圈子广场";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CircleSquareTableCell" bundle:nil] forCellReuseIdentifier:kCircleSquareTablecellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"CircleSquareEmptyTableCell" bundle:nil] forCellReuseIdentifier:kCircleSquareEmptyTablecellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)UIGlobal
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBHex(qwColor11);
}

- (void)loadData
{
    GetCircleSquareR* getCircleSquareR = [GetCircleSquareR new];
    getCircleSquareR.token = QWGLOBALMANAGER.configure.userToken;
    MapInfoModel *mapInfo = [QWUserDefault getModelBy:APP_MAPINFOMODEL];
    getCircleSquareR.groupId = mapInfo.groupId;
    __weak typeof(self) weakSelf = self;
    [Forum getHealthCircleSquare:getCircleSquareR success:^(QWCircleSquareModel *circleSquareModel) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf removeInfoView];
            strongSelf.attentionCircleArray = circleSquareModel.attnTeamList;
            strongSelf.recommendCircleArray = circleSquareModel.teamList;
            [strongSelf.tableView reloadData];
        }
    } failure:^(HttpException *e) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [weakSelf showInfoView:kWarning12 image:@"网络信号icon"];
        }else
        {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [weakSelf showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [weakSelf showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }
    }];
}

- (void)viewInfoClickAction:(id)sender
{
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 50 : 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, height)];
    view.backgroundColor = RGBHex(qwColor11);
    UILabel* tipLabel = [[UILabel alloc] init];
    QWCSS(tipLabel, 1, 8);
    if (section == 0) {
        tipLabel.frame = CGRectMake(18, 0, APP_W - 36, height);
        tipLabel.text = @"我关注的圈子";
    }
    else
    {
        tipLabel.frame = CGRectMake(18, 0, APP_W - 36, height - 10);
        tipLabel.text = @"推荐圈子";
    }
    [view addSubview:tipLabel];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return MAX(1, self.attentionCircleArray.count);
    }
    return MAX(1, self.recommendCircleArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if (indexPath.section == 0 && self.attentionCircleArray.count > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCircleSquareTablecellIdentifier forIndexPath:indexPath];
    }
    else if (indexPath.section == 1 && self.recommendCircleArray.count > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCircleSquareTablecellIdentifier forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kCircleSquareEmptyTablecellIdentifier forIndexPath:indexPath];
    }
    [self configure:cell indexPath:indexPath];
    return cell;
}

- (void)configure:(id)cell indexPath:(NSIndexPath*)indexPath
{
    if ([cell isKindOfClass:[CircleSquareEmptyTableCell class]]) {
        CircleSquareEmptyTableCell* emptyTablecell = cell;
        if (indexPath.section == 0) {
            emptyTablecell.tipString = @"暂无关注圈子";
            emptyTablecell.hiddenImage = NO;
        }
        else
        {
            emptyTablecell.tipString = @"暂无推荐圈子";
            emptyTablecell.hiddenImage = YES;
        }
    }
    else if ([cell isKindOfClass:[CircleSquareTableCell class]])
    {
        CircleSquareTableCell* circleSquareCell = cell;
        QWCircleModel* circleModel = nil;
        if (indexPath.section == 0 && self.attentionCircleArray.count > indexPath.row) {
            circleModel = self.attentionCircleArray[indexPath.row];
//            [circleSquareCell setCell:self.attentionCircleArray[indexPath.row]];
        }
        else if (indexPath.section == 1 && self.recommendCircleArray.count > indexPath.row)
        {
            circleModel = self.recommendCircleArray[indexPath.row];
//            [circleSquareCell setCell:self.recommendCircleArray[indexPath.row]];
        }
        [circleSquareCell setCell:circleModel];
        __weak typeof(self) weakSelf = self;
        circleSquareCell.careCircleBtn.touchUpInsideBlock = ^{
            if(!QWGLOBALMANAGER.loginStatus) {
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                loginViewController.loginSuccessBlock = ^{
                    [weakSelf loadData];
                };
                [self presentViewController:navgationController animated:YES completion:NULL];
                return;
            }
            
            AttentionCircleR* attentionCircleR = [AttentionCircleR new];
            attentionCircleR.teamId = circleModel.teamId;
            attentionCircleR.isAttentionTeam = circleModel.flagAttn ? 1 : 0;
            attentionCircleR.token = QWGLOBALMANAGER.configure.userToken;
            [Forum attentionCircle:attentionCircleR success:^(QWAttentionCircleModel *attentionCircleModel) {
                if ([attentionCircleModel.apiStatus integerValue] == 0) {
                    [weakSelf loadData];
                }
                else
                {
                    if (!StrIsEmpty(attentionCircleModel.apiMessage)) {
                        [SVProgressHUD showErrorWithStatus:attentionCircleModel.apiMessage];
                    }
                }
            } failure:^(HttpException *e) {
                DebugLog(@"attention circle error : %@", e);
            }];
        };
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier;
    if (indexPath.section == 0 && self.attentionCircleArray.count > 0) {
        cellIdentifier = kCircleSquareTablecellIdentifier;
    }
    else if (indexPath.section == 1 && self.recommendCircleArray.count > 0) {
        cellIdentifier = kCircleSquareTablecellIdentifier;
    }
    else
    {
        cellIdentifier = kCircleSquareEmptyTablecellIdentifier;
    }
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier configuration:^(id cell) {
        [self configure:cell indexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QWCircleModel* circleModel  = nil;
    if (indexPath.section == 0 && self.attentionCircleArray.count > indexPath.row) {
        circleModel = self.attentionCircleArray[indexPath.row];
    }
    else if (indexPath.section == 1 && self.recommendCircleArray.count > indexPath.row)
    {
        circleModel = self.recommendCircleArray[indexPath.row];
    }
    if (circleModel) {
        CircleDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.teamId = circleModel.teamId;
        vc.title = [NSString stringWithFormat:@"%@圈",circleModel.teamName];
        [self.navigationController pushViewController:vc animated:YES];
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
