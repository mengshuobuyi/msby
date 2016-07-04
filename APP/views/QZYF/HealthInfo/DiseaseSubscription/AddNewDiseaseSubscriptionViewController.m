//
//  AddNewDiseaseSubscriptionViewController.m
//  wenyao
//
//  Created by Pan@QW on 14-9-25.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "AddNewDiseaseSubscriptionViewController.h"
#import "AddNewDiseaseSubscriptionTableViewCell.h"
#import "SVProgressHUD.h"
#import "DrugGuideModelR.h"
#import "DrugGuideApi.h"
#import "css.h"
#import "QWGlobalManager.h"
#import "DrugGuideModel.h"
#import "DrugGuideItemModelR.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface AddNewDiseaseSubscriptionViewController ()
{
    NSMutableArray              *dataSource;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrAllDiseaseSub;
@property (nonatomic, assign) BOOL needUpdates;

@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation AddNewDiseaseSubscriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = [NSMutableArray arrayWithCapacity:20];
    self.arrAllDiseaseSub = [[NSMutableArray alloc] init];
    self.title = @"添加慢病订阅";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self setupTableView];
    self.tableView.separatorColor = RGBHex(qwGcolor11);
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

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
    self.numLabel.backgroundColor = RGBHex(qwMcolor3);
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
    self.redLabel.backgroundColor = RGBHex(qwMcolor3);
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


- (void)popVCAction:(id)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(diseaseSubUpdate:)]) {
            [self.delegate diseaseSubUpdate:YES];
        }
    }
    [super popVCAction:sender];
}

- (void)loadDiseaseListFromLocal
{
    //jxb
    //dataSource = [APPDelegate.dataBase queryDiseaseList];
    [self.tableView reloadData];
}

- (void)cacheDiseaseList
{
//jxb
//    [APPDelegate.dataBase deleteAllDiseaseList];
//    for (NSDictionary *dicDisease in dataSource) {
//        [APPDelegate.dataBase updateDiseaseListWithAttentionId:dicDisease[@"attentionId"] name:dicDisease[@"name"] selected:[dicDisease[@"selected"] boolValue]];
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
    [self setUpRightItem];
    [dataSource removeAllObjects];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self loadDiseaseListFromLocal];
    } else {
        [self queryAddList];
    }
    
}

- (void)queryAddList
{
    if([dataSource count] == 0)
    {
        [self removeInfoView];
        __weak AddNewDiseaseSubscriptionViewController *weakSelf = self;
        DrugGuideAttentionModelR *modelRAttention = [DrugGuideAttentionModelR new];
        modelRAttention.token = QWGLOBALMANAGER.configure.userToken;
        [DrugGuideApi queryAttentionList:modelRAttention success:^(id model) {
            DrugAttentionModel *modelAttention = (DrugAttentionModel *)model;
            for (DrugAttentionChildModel *modelT in modelAttention.list) {
                if ([modelT.guideId length] > 0) {
                    modelT.isSelected = 1;
                } else {
                    modelT.isSelected = 0;
                }
                [weakSelf.arrAllDiseaseSub addObject:modelT];
            }
            [weakSelf.tableView reloadData];
        } failure:^(HttpException *err) {
            [self showInfoView:kWarning39 image:@"ic_img_fail"];
        }];
    }
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self queryAddList];
    }
}

- (void)setupTableView
{
    CGRect rect = self.view.frame;
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = RGBHex(qwGcolor11);
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.rowHeight = 50.0f;
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrAllDiseaseSub count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AddNewDiseaseSubscriptionTableViewCellIdentifier = @"addDiseaseSubscriptionIdentifier";
    AddNewDiseaseSubscriptionTableViewCell *cell = (AddNewDiseaseSubscriptionTableViewCell *)[atableView dequeueReusableCellWithIdentifier:AddNewDiseaseSubscriptionTableViewCellIdentifier];
    if(cell == nil)
    {
        UINib *nib = [UINib nibWithNibName:@"AddNewDiseaseSubscriptionTableViewCell" bundle:nil];
        [atableView registerNib:nib forCellReuseIdentifier:AddNewDiseaseSubscriptionTableViewCellIdentifier];
        cell = (AddNewDiseaseSubscriptionTableViewCell *)[atableView dequeueReusableCellWithIdentifier:AddNewDiseaseSubscriptionTableViewCellIdentifier];
    }
    DrugAttentionChildModel *modelC = [self.arrAllDiseaseSub objectAtIndex:indexPath.row];
    [cell setCell:modelC];
    if(modelC.isSelected) {
        //选中
        cell.selectedIcon.image = [UIImage imageNamed:@"健康资讯_慢病订阅icon_已订阅.png"];
    }else{
        //未选中
        cell.selectedIcon.image = [UIImage imageNamed:@"健康资讯_慢病订阅icon.png"];
    }
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        return;
    }
    self.needUpdates = YES;
    __weak AddNewDiseaseSubscriptionViewController *weakSelf = self;
    __block DrugAttentionChildModel *modelDrug = [self.arrAllDiseaseSub objectAtIndex:indexPath.row];
    
    if (!modelDrug.isSelected) {
        SaveDrugGuideItemModelR *modelSave = [[SaveDrugGuideItemModelR alloc] init];
        modelSave.token = QWGLOBALMANAGER.configure.userToken;
        modelSave.attentionId = modelDrug.attentionId;
        [self showLoadingWithMessage:kWarning21];
        [DrugGuideApi saveDrugGuideItem:modelSave success:^(id model) {
            
            if ([model[@"apiStatus"] integerValue] == 0) {
                
                modelDrug.isSelected = YES;
                modelDrug.guideId = model;
                
                [weakSelf.tableView reloadData];
                [self didLoad];
                [self showSuccess:kWarning22];
                
            }else
            {
                [self didLoad];
                [SVProgressHUD showErrorWithStatus:model[@"apiMessage"] duration:0.8];
            }
            
            
        } failure:^(HttpException *err) {
            [self didLoad];
            [self showError:kWarning23];
        }];
        
    } else {
        DeleteDrugGuideItemModelR *modelDel = [[DeleteDrugGuideItemModelR alloc] init];
        modelDel.token = QWGLOBALMANAGER.configure.userToken;
//        NSString *strDelAttention = @"";
//        NSInteger intDel = -1;
//        for (ChronicDiseaseModel *modelCh in self.arrAddedDisease) {
//            if ([modelDrug.attentionId isEqualToString:modelCh.diseaseId]) {
//                strDelAttention = modelCh.id;
//                intDel = [self.arrAddedDisease indexOfObject:modelCh];
//                break;
//            }
//        }
//        if ([strDelAttention length] == 0) {
//            strDelAttention = modelDrug.attentionId;
//        }
        modelDel.drugGuideId = modelDrug.guideId;
        [self showLoadingWithMessage:kWarning24];
        [DrugGuideApi deleteDrugGuideItem:modelDel success:^(id model) {
            modelDrug.isSelected = NO;
            modelDrug.guideId = @"";
//            if (intDel >= 0) {
//                [weakSelf.arrAddedDisease removeObjectAtIndex:intDel];
//            }
            [self didLoad];
            [self showSuccess:kWarning25];
            [weakSelf.tableView reloadData];
        } failure:^(HttpException *err) {
            [self didLoad];
            [self showError:kWarning26];
        }];
    }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
