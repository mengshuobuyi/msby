//
//  DetialLevelViewController.m
//  APP
//
//  Created by qw_imac on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "DetialLevelViewController.h"
#import "LevelAnimationCell.h"
#import "ExpDetialCell.h"
#import "DetialRullCell.h"
#import "MyCreditViewController.h"
#import "QWProgressHUD.h"
#import "LevelUpAlertView.h"
#import "LevelHeaderView.h"
@interface DetialLevelViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isClick;
}
@property (nonatomic,strong)UITableView *tableView;
//@property (nonatomic,strong)UILabel *levelLabel;
@property (nonatomic,strong)MyLevelDetailVo *levelInfo;
@property (nonatomic,strong)LevelHeaderView *headerView;
@end

@implementation DetialLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的等级";
    isClick = YES;
   
    self.levelInfo = [[MyLevelDetailVo alloc]init];
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)setupUI {
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 30)];
//    headerView.backgroundColor = [UIColor whiteColor];
    self.headerView = [LevelHeaderView LevelHeaderView];
    self.tableView.tableHeaderView = self.headerView;
    
//    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(APP_W/2 - 40 , 2, 120, 28)];
//    label1.font = [UIFont systemFontOfSize:kFontS4];
//    label1.textColor = RGBHex(qwColor8);
//    label1.text = @"当前等级:";
//    self.levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(APP_W/2 + 20, 2, 40, 28)];
//    self.levelLabel.textColor = RGBHex(qwColor3);
//    self.levelLabel.font = [UIFont systemFontOfSize:kFontS4];
//    self.levelLabel.text = @"V";
//    [self.tableView.tableHeaderView addSubview:self.levelLabel];
//    [self.tableView.tableHeaderView addSubview:label1];
    [self.tableView addStaticImageHeader];
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoInView:self.tableView offsetSize:0 text:@"网络未连通，请重试" image:@"网络信号icon"];
    }else {
        [self queryMemBerInfo];
        
    }
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}



#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.levelInfo.level integerValue] < 6) {
        return 3;
    }else {
        
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.levelInfo.level integerValue] < 6) { //不超过6级显示成长值cell
        if (indexPath.row == 0) {
            LevelAnimationCell *cell =[[NSBundle mainBundle] loadNibNamed:@"LevelAnimationCell" owner:self options:nil][0];
            cell.tag = 100;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell setAlertViewWith:isClick];
            [cell setAlertViewWithVo:self.levelInfo];
            if ([self.levelInfo.level integerValue] == 0) {
                [cell.knowBtn addTarget:self action:@selector(deleteKnownView) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [cell.knowBtn addTarget:self action:@selector(doUpgradeTask) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }else if (indexPath.row == 1) {
            ExpDetialCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ExpDetialCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setUI];
            [cell setUiDetailWithVo:self.levelInfo];
            return cell;
        }else {
            DetialRullCell *cell = [[NSBundle mainBundle] loadNibNamed:@"DetialRullCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setDetailUiWith:self.levelInfo];
            return cell;
        }
    }else { //超过6级包括6级，隐藏成长值cell
        if (indexPath.row == 0) {
            LevelAnimationCell *cell =[[NSBundle mainBundle] loadNibNamed:@"LevelAnimationCell" owner:self options:nil][0];
            cell.tag = 100;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell setAlertViewWith:isClick];
            [cell setAlertViewWithVo:self.levelInfo];
            if ([self.levelInfo.level integerValue] == 0) {
                [cell.knowBtn addTarget:self action:@selector(deleteKnownView) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [cell.knowBtn addTarget:self action:@selector(doUpgradeTask) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }else {
            DetialRullCell *cell = [[NSBundle mainBundle] loadNibNamed:@"DetialRullCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setDetailUiWith:self.levelInfo];
            return cell;
        }
    }
}
//移除提示框
-(void)deleteKnownView {
    isClick = NO;
     LevelAnimationCell *cell = (LevelAnimationCell *)[self.view viewWithTag:100];
    [UIView animateWithDuration:.5 animations:^{
        cell.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        [cell.alertView removeFromSuperview];
    }];
    [QWUserDefault setBool:YES key:@"isLevelAlertClick"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.levelInfo.level integerValue] < 6) {
        if (indexPath.row == 0) {
            return [LevelAnimationCell cellHeight];
        }else if (indexPath.row == 1){
            return [ExpDetialCell cellHeight];
        }else {
            return 260.0;
        }
    }else {
        if (indexPath.row == 0) {
            return [LevelAnimationCell cellHeight];
        }else {
            return 260.0;
        }
    }
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [self stopCloudAnimation];
}

-(void)stopCloudAnimation {
    LevelAnimationCell *cell = (LevelAnimationCell *)[self.view viewWithTag:100];
    [cell.timer invalidate];
}

-(void)dealloc {
    DDLogVerbose(@"111");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//请求等级信息
-(void)queryMemBerInfo {
    MyLevelR *modelR = [MyLevelR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    [Credit getMyLevelDetailVo:modelR success:^(MyLevelDetailVo *responModel) {
        self.levelInfo = responModel;
        //self.levelLabel.text = [NSString stringWithFormat:@"V%d",[self.levelInfo.level integerValue]];
        self.headerView.levelLabel.text = [NSString stringWithFormat:@"V%d",[self.levelInfo.level integerValue]];
        self.headerView.scoreLabel.text = [NSString stringWithFormat:@"%@",self.levelInfo.growth?self.levelInfo.growth:@""];
        [self.tableView reloadData];
    } failure:^(HttpException *e) {
       
    }];
}

//领取每月等级积分
-(void)doUpgradeTask {
    DoUpgradeTaskR *modelR = [DoUpgradeTaskR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    [Credit doUpgradeTaskWithToken:modelR success:^(BaseTaskVo *responModel) {
       
       [QWProgressHUD showSuccessWithStatus:@"领取成功!" hintString:[NSString stringWithFormat:@"+%d",[responModel.rewardScore integerValue]] duration:2.0];
        
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"积分数"]=[NSString stringWithFormat:@"%@",responModel.score];
        tdParams[@"等级"]= [NSString stringWithFormat:@"%@",responModel.level];
        [QWGLOBALMANAGER statisticsEventId:@"x_wd_dj_lq" withLable:@"等级" withParams:tdParams];
        
        LevelAnimationCell *cell = (LevelAnimationCell *)[self.view viewWithTag:100];
        [UIView animateWithDuration:.5 animations:^{
            cell.alertView.alpha = 0;
        } completion:^(BOOL finished) {
            [cell.alertView removeFromSuperview];
        }];
        if (self.isComeFromIntegralVC) {    //是否是从积分页进来
            [self popVCAction:nil];
        }
        

    } failure:^(HttpException *e) {
        [QWProgressHUD showSuccessWithStatus:@"领取失败!" hintString:nil duration:.5];
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

@end
