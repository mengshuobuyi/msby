//
//  DiseaseSubscriptionViewController.m
//  wenyao
//
//  Created by Pan@QW on 14-9-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "DiseaseSubscriptionViewController.h"
#import "DiseaseSubscriptionTableViewCell.h"
#import "AddNewDiseaseSubscriptionViewController.h"
#import "Constant.h"
#import "DetailSubscriptionListViewController.h"
#import "DrugGuideModel.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "DrugGuideModelR.h"
#import "DrugGuideApi.h"
#import "css.h"
#import "DiseaseSubList.h"

@interface DiseaseSubscriptionViewController ()<UITableViewDataSource,UITableViewDelegate, AddNewDiseaseProtocol>

@property (nonatomic, strong) NSMutableArray    *subscriptionList;
@property (nonatomic, strong) UIImageView       *noneHintImage;
@property (nonatomic, strong) UILabel           *noneHintLabel;

@end

@implementation DiseaseSubscriptionViewController
@synthesize tableView;

//- (BOOL)diseaseHasReaded:(NSString *)strGuideId
//{
//    BOOL isReaded = YES;
//    
//    DrugGuideListModel *model = [DrugGuideListModel getObjFromDBWithKey:strGuideId];
//    if (model) {
//        isReaded = model.hasRead;
//    } else {
//        isReaded = NO;
//    }
//    return isReaded;
//}

- (void)setupTableView
{
    CGRect rect = self.view.frame;
    if(self.subType) {
        rect.size.height -= 64;
    }else{
        rect.size.height -= 64 + 35 + 44;
    }
    self.subscriptionList = [NSMutableArray arrayWithCapacity:10];
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.rowHeight = 70;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
}

- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,APP_W, 170)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 120)];
    imageView.image = [UIImage imageNamed:@"健康资讯_慢病订阅banner.png"];
    [headerView addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.frame = CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height, APP_W, headerView.frame.size.height - imageView.frame.size.height);
    [button addTarget:self action:@selector(jumpToNewDiseaseSubscription:) forControlEvents:UIControlEventTouchDown];
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 20)];
    descLabel.font = [UIFont systemFontOfSize:14.5f];
    descLabel.text = @"添加更多慢病订阅";
    [button addSubview:descLabel];
    UIImageView *addIcon = [[UIImageView alloc] initWithFrame:CGRectMake(295, 18 , 15, 15)];
    addIcon.image = [UIImage imageNamed:@"健康资讯_慢病订阅icon.png"];
    [button addSubview:addIcon];
    [headerView addSubview:button];
    UILabel *separator = [[UILabel alloc] initWithFrame:CGRectMake(0, 169, APP_W, 0.5)];
    [separator setBackgroundColor:RGBHex(qwGcolor10)];
    [headerView addSubview:separator];
    self.tableView.tableHeaderView = headerView;
}

- (void)jumpToNewDiseaseSubscription:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        return;
    }
    if (QWGLOBALMANAGER.loginStatus) {
        AddNewDiseaseSubscriptionViewController *addNewDiseaseViewController = [[AddNewDiseaseSubscriptionViewController alloc] initWithNibName:@"AddNewDiseaseSubscriptionViewController" bundle:nil];
        addNewDiseaseViewController.delegate = self;
        addNewDiseaseViewController.diseaseSubscriptionViewController = self;
        addNewDiseaseViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addNewDiseaseViewController animated:YES];
    } else {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        
        loginViewController.isPresentType = NO;
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (void)queryDrugGuideList:(BOOL)forece
{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

    [self.view setBackgroundColor:RGBHex(qwGcolor11)];
    self.noneHintImage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 200, 72, 72)];
    self.noneHintImage.image = [UIImage imageNamed:@"ic_img_fail"];
    self.noneHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 290, 180, 15)];
    self.noneHintLabel.textColor = RGBHex(qwGcolor8);
    self.noneHintLabel.text = kWarning19;
    [self setupTableView];
    [self setupHeaderView];
    [self.tableView addSubview:self.noneHintImage];
    [self.tableView addSubview:self.noneHintLabel];
    self.noneHintImage.hidden = YES;
    self.noneHintLabel.hidden = YES;
}

- (void)hadNewDisease
{
    [self refresh];
}

- (void)hadLogoutSuccess
{
    QWGLOBALMANAGER.needShowBadge = NO;
    [QWGLOBALMANAGER setBadgeNumStatus:NO];
}

- (void)loadDiseaseListFromLocal
{
    if (self.subscriptionList.count > 0) {
        [self.subscriptionList removeAllObjects];
    }
    self.subscriptionList = [[QWUserDefault getObjectBy:[NSString stringWithFormat:@"DiseaseSubScription+%@",QWGLOBALMANAGER.configure.passPort]] mutableCopy];
    if (self.subscriptionList.count > 0) {
        self.noneHintImage.hidden = YES;
        self.noneHintLabel.hidden = YES;
    } else {
        self.noneHintImage.hidden = NO;
        self.noneHintLabel.hidden = NO;
    }
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showError:kWarning12];
            return;
        }
        __block DrugGuideListModel *modelGuide = self.subscriptionList[indexPath.row];
        DeleteDrugGuideItemModelR *modelRDel = [[DeleteDrugGuideItemModelR alloc] init];
        modelRDel.token = QWGLOBALMANAGER.configure.userToken;
        modelRDel.drugGuideId = modelGuide.guideId;
        __weak DiseaseSubscriptionViewController *weakSelf = self;
        [DrugGuideApi deleteDrugGuideItem:modelRDel success:^(id model) {
            NSLog(@"model is %@",model);
            NSMutableArray *arrNeedDelete = [@[] mutableCopy];
            //从缓存中删除
            NSMutableArray *array = [[QWUserDefault getObjectBy:[NSString stringWithFormat:@"DiseaseSubScription+%@",QWGLOBALMANAGER.configure.passPort]] mutableCopy];
            for (DrugGuideListModel *model in array) {
                if ([model.guideId isEqualToString:modelGuide.guideId]) {
                    [arrNeedDelete addObject:model];
//                    [array removeObject:model];
                }
            }
            [array removeObjectsInArray:arrNeedDelete];
            
            [QWUserDefault setObject:array key:[NSString stringWithFormat:@"DiseaseSubScription+%@",QWGLOBALMANAGER.configure.passPort]];
            
//            [DrugGuideListModel deleteObjFromDBWithKey:modelGuide.guideId];
            
            [weakSelf.subscriptionList removeObject:modelGuide];
            [self.tableView reloadData];
            if(self.subscriptionList.count == 0) {
                self.noneHintImage.hidden = NO;
                self.noneHintLabel.hidden = NO;
            }
        } failure:^(HttpException *err) {
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DiseaseSubscriptionTableViewCell getCellHeight:nil];//57;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [self.subscriptionList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DiseaseSubscriptionCellIdentifier = @"DiseaseSubscriptionIdentifier";
    DiseaseSubscriptionTableViewCell *cell = (DiseaseSubscriptionTableViewCell *)[atableView dequeueReusableCellWithIdentifier:DiseaseSubscriptionCellIdentifier];
    if(cell == nil)
    {
        UINib *nib = [UINib nibWithNibName:@"DiseaseSubscriptionTableViewCell" bundle:nil];
        [atableView registerNib:nib forCellReuseIdentifier:DiseaseSubscriptionCellIdentifier];
        cell = (DiseaseSubscriptionTableViewCell *)[atableView dequeueReusableCellWithIdentifier:DiseaseSubscriptionCellIdentifier];
    }
    
    
    DrugGuideListModel *model = self.subscriptionList[indexPath.row];
    
    if ([model.unReadCount integerValue] > 0) {
        cell.indicateImage.hidden = NO;
    }else{
        cell.indicateImage.hidden = YES;
    }
    
    
//    BOOL hasRead = [self diseaseHasReaded:model.guideId];
//    if (hasRead) {
//        cell.indicateImage.hidden = YES;
//    } else {
//        cell.indicateImage.hidden = NO;
//    }
    [cell setCell:model];
    
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
//        [self showError:kWarning12];
//        return;
//    }
    if (QWGLOBALMANAGER.loginStatus) {
        DrugGuideListModel *model = self.subscriptionList[indexPath.row];
        DetailSubscriptionListViewController *detailSubscriptionViewController = [[DetailSubscriptionListViewController alloc] init];
        
        NSMutableArray *arr = [QWUserDefault getObjectBy:[NSString stringWithFormat:@"DiseaseSubScription+%@",QWGLOBALMANAGER.configure.passPort]];
        for (DrugGuideListModel *mod in arr) {
            if ([model.guideId isEqualToString:mod.guideId]) {
                mod.unReadCount = 0;
            }
        }
        
        [QWUserDefault setObject:arr key:[NSString stringWithFormat:@"DiseaseSubScription+%@",QWGLOBALMANAGER.configure.passPort]];
    
//        [APPDelegate.dataBase updateHasReadFromDiseaseWithId:dict[@"guideId"] hasRead:YES];
        
        DiseaseSubscriptionTableViewCell *cell = (DiseaseSubscriptionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.indicateImage.hidden = YES;
        detailSubscriptionViewController.modelDrugGuide = model;
        detailSubscriptionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailSubscriptionViewController animated:YES];
    } else {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - add disease methods
- (void)diseaseSubUpdate:(BOOL)needUpdate
{
    if (needUpdate) {
        [self refresh];
    }
}

- (void) refresh
{
    if (!QWGLOBALMANAGER.loginStatus) {
        return;
    }else{
        [self performSelector:@selector(subRefresh) withObject:nil afterDelay:0.25f];
    }
    
}

- (void)subRefresh{
    
    if (QWGLOBALMANAGER.loginStatus) {
        if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
            [self loadDiseaseListFromLocal];
        } else {
            [self queryDrugGuideList:YES];
        }
    }
}

#pragma mark -
#pragma mark 处理本视图收到的通知

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotifLoginSuccess == type) {
        [self refresh];
    } else if(NotifHasNewDisease == type) {
        [self hadNewDisease];
    } else if (NotifQuitOut == type) {
        [self hadLogoutSuccess];
    }
}
@end
