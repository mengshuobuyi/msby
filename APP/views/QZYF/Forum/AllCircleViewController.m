//
//  AllCircleViewController.m
//  APP
//  ①全部圈子页面 、 ②选择圈子页面（发帖页面用到）
//  热议中点击全部圈子    发帖页面选择圈子（此时selectCircleBlock不为空）
//  Created by Martin.Liu on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "AllCircleViewController.h"
#import "CircleDetailViewController.h"
#import "CircleTableCell.h"
#import "Forum.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "QWProgressHUD.h"
@interface AllCircleViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AllCircleViewController
{
    NSArray* circleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CircleTableCell" bundle:nil] forCellReuseIdentifier:@"CircleTableCell"];
    
}

- (void)loadData
{
    GetAllCircleListR* getAllCircleListR = [GetAllCircleListR new];
    getAllCircleListR.token = QWGLOBALMANAGER.configure.userToken;
    [Forum getAllCircleList:getAllCircleListR success:^(NSArray *teamList) {
        circleArray = teamList;
        [self.tableView reloadData];
    } failure:^(HttpException *e) {
        DebugLog(@"getAllTeamList error : %@", e);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    if (self.selectCircleBlock) {
        
    }
    else
    {
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_qbqz" withLable:@"圈子-全部圈子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    }
}

- (void)UIGlobal
{
    self.tableView.backgroundColor = RGBHex(qwColor11);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return circleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircleTableCell* cell = (CircleTableCell*)[tableView dequeueReusableCellWithIdentifier:@"CircleTableCell" forIndexPath:indexPath];
    __weak QWCircleModel* circleModel = circleArray[indexPath.row];
    __weak __typeof(self) weakSelf = self;
    
    if (self.selectCircleBlock) {
        cell.circleType = CircleCellType_SelectedRadio;
        cell.chooseBtn.selected = [circleModel isEqual:self.selectedCircle];
    }
    else
    {
        cell.circleType = CircleCellType_Normal;
        __weak CircleTableCell* weakCell = cell;
        cell.careBtn.touchUpInsideBlock = ^{
            
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
            
            if (QWGLOBALMANAGER.configure.flagSilenced) {
                [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
                return;
            }
            
            if ([weakCell.careBtn.titleLabel.text rangeOfString:@"关注"].location != NSNotFound) {
                [QWGLOBALMANAGER statisticsEventId:@"x_qz_qbqz_gz" withLable:@"全部圈子-点击关注" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow],@"圈子名":StrDFString(circleModel.teamName, @"圈子名"),@"类型":circleModel.flagAttn ? @"取消关注" : @"关注"}]];
            }
            
            AttentionCircleR* attentionCircleR = [AttentionCircleR new];
            attentionCircleR.teamId = circleModel.teamId;
            attentionCircleR.isAttentionTeam = circleModel.flagAttn ? 1 : 0;
            attentionCircleR.token = QWGLOBALMANAGER.configure.userToken;
            [Forum attentionCircle:attentionCircleR success:^(QWAttentionCircleModel *attentionCircleModel) {
                if ([attentionCircleModel.apiStatus integerValue] == 0) {
                    circleModel.flagAttn = !circleModel.flagAttn;
                    [weakSelf.tableView reloadData];
                    if (attentionCircleModel.rewardScore > 0) {
                        [QWProgressHUD showSuccessWithStatus:@"关注成功" hintString:[NSString stringWithFormat:@"+%ld", (long)attentionCircleModel.rewardScore] duration:DURATION_CREDITREWORD];
                    }
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
    [cell setCell:circleModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 发帖选择圈子
    if (self.selectCircleBlock) {
        QWCircleModel* circleModel = circleArray[indexPath.row];
        self.selectCircleBlock(circleModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        // 进入圈子详情
        QWCircleModel* circleModel = circleArray[indexPath.row];
        
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_qbqz_dj" withLable:@"全部圈子-点击某个圈子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"圈子名":StrDFString(circleModel.teamName, @"圈子名"),@"点击时间":[QWGLOBALMANAGER timeStrNow]}]];
        
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
