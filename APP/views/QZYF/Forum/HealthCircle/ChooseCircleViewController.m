//
//  ChooseCircleViewController.m
//  APP
//
//  Created by Martin.Liu on 16/6/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ChooseCircleViewController.h"
#import "Forum.h"
#import "SimpleCircleTableCell.h"
#import "SVProgressHUD.h"
#import "ConstraintsUtility.h"

NSString *const kChooseCircleCellIdentifier = @"SimpleCircleTableCell";

@interface ChooseCircleViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic , strong) NSArray* myAttnCircleArray;
@property (nonatomic , strong) NSMutableArray* circleArray;
@property (strong, nonatomic) UIView* promptView;
@end

@implementation ChooseCircleViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"选择圈子";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = RGBHex(qwColor11);
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleCircleTableCell" bundle:nil] forCellReuseIdentifier:kChooseCircleCellIdentifier];
    [self loadData];
}

- (NSMutableArray *)circleArray
{
    if (!_circleArray) {
        _circleArray = [NSMutableArray array];
    }
    return _circleArray;
}


- (UIView *)promptView
{
    if (!_promptView) {
        _promptView = [[UIView alloc] init];
        _promptView.backgroundColor = [UIColor whiteColor];
        UIImageView* promptImageView = [[UIImageView alloc] init];
        promptImageView.image = [UIImage imageNamed:@"ic_quanzi_noattention"];
        
        UILabel* promptLabel = [[UILabel alloc] init];
        promptLabel.text = @"想分享到其他圈子？先去关注圈子吧";
        promptLabel.font = [UIFont systemFontOfSize:kFontS13];
        promptLabel.textColor = RGBHex(qwColor20);
    
        
        [_promptView addSubview:promptImageView];
        [_promptView addSubview:promptLabel];
        [self.view addSubview:_promptView];
        
        PREPCONSTRAINTS(_promptView);
        PREPCONSTRAINTS(promptImageView);
        PREPCONSTRAINTS(promptLabel);
        
        ALIGN_TOPLEFT(_promptView, 0);
        ALIGN_BOTTOMRIGHT(_promptView, 0);
        
        CENTER_H(promptImageView);
        ALIGN_TOP(promptImageView, 125);
        
        LAYOUT_V(promptImageView, 28, promptLabel);
    }
    return _promptView;
}

- (void)showPrompView:(BOOL)show
{
    if (show) {
        [self.view addSubview:self.promptView];
    }
    else
    {
        [_promptView removeFromSuperview];
        _promptView = nil;
    }
}

- (void)loadData
{
    GetSyncTeamListR* getSyncTeamListR = [GetSyncTeamListR new];
    getSyncTeamListR.token = QWGLOBALMANAGER.configure.userToken;
    getSyncTeamListR.type = 1;
    __weak __typeof(self) weakSelf = self;
    [Forum getSyncTeamList:getSyncTeamListR success:^(QWSyncTeamListModel *syncTeamListModel) {
        if ([syncTeamListModel.apiStatus integerValue] == 0) {
            [weakSelf removeInfoView];
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf.circleArray removeAllObjects];
                [strongSelf.circleArray addObjectsFromArray:syncTeamListModel.teamInfoList];
                [strongSelf showPrompView:(strongSelf.circleArray.count == 0)];
                [strongSelf.tableView reloadData];
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:syncTeamListModel.apiMessage duration:DURATION_LONG];
        };
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
        DebugLog(@"get syncteamList error: %@", e);
    }];
    
//    GetMyCircleListR* getMyCircleListR = [GetMyCircleListR new];
//    getMyCircleListR.token = QWGLOBALMANAGER.configure.userToken;
//    __weak __typeof(self) weakSelf = self;
//    [Forum getMyCircleList:getMyCircleListR success:^(QWMyCircleList *myCircleList) {
//        if ([myCircleList.apiStatus integerValue] == 0) {
//            [weakSelf removeInfoView];
//            __strong __typeof(weakSelf) strongSelf = weakSelf;
//            if (strongSelf) {
//                [strongSelf.circleArray removeAllObjects];
//                [strongSelf.circleArray addObjectsFromArray:myCircleList.teamList];
//                [strongSelf.circleArray addObjectsFromArray:myCircleList.attnTeamList];
////                strongSelf.myAttnCircleArray = myCircleList.attnTeamList;
////                [strongSelf showPrompView:(strongSelf.myAttnCircleArray.count == 0)];
//                [strongSelf showPrompView:(strongSelf.circleArray.count == 0)];
//                [strongSelf.tableView reloadData];
//            }
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:myCircleList.apiMessage duration:DURATION_LONG];
//        }
//    } failure:^(HttpException *e) {
//        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
//            [weakSelf showInfoView:kWarning12 image:@"网络信号icon"];
//        }else
//        {
//            if(e.errorCode!=-999){
//                if(e.errorCode == -1001){
//                    [weakSelf showInfoView:kWarning215N26 image:@"ic_img_fail"];
//                }else{
//                    [weakSelf showInfoView:kWarning39 image:@"ic_img_fail"];
//                }
//            }
//        }
//        DebugLog(@"get my CircleList error: %@", e);
//    }];
}

- (void)viewInfoClickAction:(id)sender
{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.circleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleCircleTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kChooseCircleCellIdentifier forIndexPath:indexPath];
    if (self.circleArray.count > indexPath.row) {
        QWCircleModel* circle = self.circleArray[indexPath.row];
        cell.chooseBtn.selected = [circle isEqual:self.selectedCircleModel];
        [cell setCell:circle];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.circleArray.count > indexPath.row) {
        QWCircleModel* circle = self.circleArray[indexPath.row];
        self.selectedCircleModel = circle;
        [self.tableView reloadData];
        if (self.SelectCircleBlock) {
            self.SelectCircleBlock(self.selectedCircleModel);
        }
        [self popVCAction:nil];
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
