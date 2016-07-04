//
//  LookMasterViewController.m
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "LookMasterViewController.h"
#import "LookMasterCell.h"
#import "Circle.h"
#import "CircleModel.h"
#import "ExpertPageViewController.h"
#import "UserPageViewController.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "QWProgressHUD.h"

@interface LookMasterViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomView_layout_height;



@property (strong, nonatomic) NSMutableArray *dataList;

@property (strong, nonatomic) CircleMasterPageModel *pageModel;


@property (weak, nonatomic) IBOutlet UIButton *applyButton;
- (IBAction)applyAction:(id)sender;

@end

@implementation LookMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看圈主";
    self.dataList = [NSMutableArray array];
    self.pageModel = [CircleMasterPageModel new];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.applyButton.layer.cornerRadius = 4.0;
    self.applyButton.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryData];
}

#pragma mark ---- 请求数据 ----
- (void)queryData
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12];
        return;
    }
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"token"] = StrFromObj(QWGLOBALMANAGER.configure.userToken);
    setting[@"teamId"] = StrFromObj(self.teamId);
    [Circle teamGetMbrInfoListByTeamIdWithParams:setting success:^(id obj) {
        CircleMasterPageModel *page = [CircleMasterPageModel parse:obj Elements:[CircleMaserlistModel class] forAttribute:@"mbrInfoList"];
        [self.dataList removeAllObjects];
        if ([page.apiStatus integerValue] == 0) {
            self.pageModel = page;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupBottomData];
            });
            
            [self.dataList addObjectsFromArray:page.mbrInfoList];
            [self.tableView reloadData];
            
            NSString* paramValue = @"圈子状态";
            if (self.pageModel.mbrInfoList.count >= 5) {
                paramValue = @"圈主已满";
            }else
            {
                if (self.pageModel.applyFlag) {//未申请
                    paramValue = @"可申请";
                }else{
                    paramValue = @"已申请做圈主";
                }
            }
            [QWGLOBALMANAGER statisticsEventId:@"x_qzxq_ckqz" withLable:@"圈子详情-查看圈主" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"圈子状态":paramValue}]];
        }else{
            [SVProgressHUD showErrorWithStatus:page.apiMessage];
        }
    } failure:^(HttpException *e) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }else
        {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
        }
    }];
}

- (void)setupBottomData
{
    //判断是否是圈主
    if (self.pageModel.masterFlag) {
        self.bottomView_layout_height.constant = 0;
        self.applyButton.hidden = YES;
    }else{
        self.bottomView_layout_height.constant = 49;
        self.applyButton.hidden = NO;
        
        if (self.pageModel.mbrInfoList.count >= 5) {
            [self.applyButton setTitle:@"圈主已满" forState:UIControlStateNormal];
            self.applyButton.backgroundColor = RGBHex(qwColor9);
            self.applyButton.enabled = NO;
        }else
        {
            if (self.pageModel.applyFlag) {//未申请
                [self.applyButton setTitle:@"申请做圈主" forState:UIControlStateNormal];
                self.applyButton.backgroundColor = RGBHex(qwColor2);
                self.applyButton.enabled = YES;
            }else{
                [self.applyButton setTitle:@"已申请做圈主" forState:UIControlStateNormal];
                self.applyButton.backgroundColor = RGBHex(qwColor9);
                self.applyButton.enabled = NO;
            }
        }
    }
}

#pragma mark ---- 列表代理 ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LookMasterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMasterCell"];
    [cell setCell:self.dataList[indexPath.row]];
    cell.attentionButton.tag = indexPath.row + 10;
    [cell.attentionButton addTarget:self action:@selector(attentionMasterAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CircleMaserlistModel *model = self.dataList[indexPath.row];
    
    //如果是当前登陆账号，不可点击
    if ([model.id isEqualToString:QWGLOBALMANAGER.configure.passPort]) {
        return;
    }
    
    [QWGLOBALMANAGER statisticsEventId:@"x_ckqz_dj" withLable:@"查看圈主-点击某个圈主" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"圈子名":StrDFString(self.circleName, @"圈子名"),@"圈主类型":model.userType == 3 ? @"药师" : (model.userType == 4  ? @"营养师" : @"用户"),@"圈主名":StrDFString(model.nickName, @"专家名")}]];
    
    if (model.userType == 3 || model.userType == 4) {
        
        //专家
        ExpertPageViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertPage" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertPageViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.posterId = model.id;
        vc.expertType = model.userType;
        vc.preVCNameStr = @"查看圈主";
        vc.nickName = model.nickName;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        //普通用户
        UserPageViewController *vc = [[UIStoryboard storyboardWithName:@"UserPage" bundle:nil] instantiateViewControllerWithIdentifier:@"UserPageViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.mbrId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ---- 关注 ----
- (void)attentionMasterAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12];
        return;
    }
    
    if(!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        return;
    }
    
    if (QWGLOBALMANAGER.configure.flagSilenced) {
        [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
        return;
    }
    
    UIButton *btn = (UIButton *)sender;
    int row = btn.tag-10;
    
    CircleMaserlistModel *model = self.dataList[row];
    NSString *type;
    if (model.isAttnFlag) {
        //取消关注
        type = @"1";
    }else{
        //关注
        type = @"0";
        
    }
    
    [QWGLOBALMANAGER statisticsEventId:@"x_ckqz_gz" withLable:@"查看圈主-关注" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"圈子名":StrDFString(self.circleName, @"圈子名"),@"分类":model.userType == 3 ? @"专家" : (model.userType == 4  ? @"营养师" : @"普通用户"),@"专家名":StrDFString(model.nickName, @"专家名"),@"类型":model.isAttnFlag ? @"取消关注" : @"关注",@"点击时间":[QWGLOBALMANAGER timeStrNow]}]];
    
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"objId"] = StrFromObj(model.id);
    setting[@"reqBizType"] = StrFromObj(type);
    setting[@"token"] = StrFromObj(QWGLOBALMANAGER.configure.userToken);
    
    [Circle teamAttentionMbrWithParams:setting success:^(id obj) {
        if ([obj[@"apiStatus"] integerValue] == 0) {

            if ([obj[@"rewardScore"] integerValue] > 0) {
                [QWProgressHUD showSuccessWithStatus:@"关注成功" hintString:[NSString stringWithFormat:@"+%ld", [obj[@"rewardScore"] integerValue]] duration:DURATION_CREDITREWORD];
            }else{
                [SVProgressHUD showSuccessWithStatus:obj[@"apiMessage"]];
            }
            model.isAttnFlag = !model.isAttnFlag;
            [self.dataList replaceObjectAtIndex:row withObject:model];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:obj[@"apiMessage"]];
        }
    } failure:^(HttpException *e) {
        
    }];

}

#pragma mark ---- 申请做圈主 ----
- (IBAction)applyAction:(id)sender
{
    [QWGLOBALMANAGER statisticsEventId:@"x_ckqz_sq" withLable:@"热议" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"圈子名":StrDFString(self.circleName, @"圈子名")}]];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12];
        return;
    }
    
    if(!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        return;
    }
    
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"teamId"] = StrFromObj(self.teamId);
    setting[@"token"] = StrFromObj(QWGLOBALMANAGER.configure.userToken);
    [Circle teamApplyMasterInfoWithParams:setting success:^(id obj) {
        
        if ([obj[@"apiStatus"] integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"申请已提交，请等待审核"];
            [self.applyButton setTitle:@"已申请做圈主" forState:UIControlStateNormal];
            self.applyButton.backgroundColor = RGBHex(qwColor9);
            self.applyButton.enabled = NO;
        }else{
            [SVProgressHUD showErrorWithStatus:obj[@"apiMessage"]];
        }
    } failure:^(HttpException *e) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
