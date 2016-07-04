//
//  ChooseExpertViewController.m
//  APP
//
//  Created by Martin.Liu on 16/1/14.
//  Copyright © 2016年 carret. All rights reserved.
//
//    SeparateStr  分隔符
#import "ChooseExpertViewController.h"
#import "ExpertTableCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Forum.h"
#import "SVProgressHUD.h"
#import "ConstraintsUtility.h"
#define ChooseExpert_MaxSelectExpertNum 10

@interface ChooseExpertViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* expertArray;
@property (strong, nonatomic) UIView* promptView;
@end

@implementation ChooseExpertViewController
@synthesize expertArray = expertArray;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"提醒专家看";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpertTableCell" bundle:nil] forCellReuseIdentifier:@"ExpertTableCell"];
    [self loadData];
}

- (void)UIGlobal
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(finishBtnAction:)];
}

- (void)finishBtnAction:(id)sender
{
    if (self.CallBackBlock) {
        self.CallBackBlock(self.selectedExpertArray);
        NSMutableString* expertNames = [NSMutableString stringWithString:@""];
        for (QWExpertInfoModel* expertInfo in self.selectedExpertArray) {
            if (StrIsEmpty(expertInfo.nickName)) {
                [expertNames appendString:expertInfo.nickName];
            }
        }
        [QWGLOBALMANAGER statisticsEventId:@"x_ft_txzj" withLable:@"发帖-添加图片" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"点击时间":[QWGLOBALMANAGER timeStrNow],@"圈子名":StrDFString(self.circleName, @"圈子名"),@"专家名":expertNames}]];
    }
    [self popVCAction:nil];
}

- (NSMutableArray *)selectedExpertArray
{
    if (!_selectedExpertArray) {
        _selectedExpertArray = [NSMutableArray array];
    }
    else if (![_selectedExpertArray isKindOfClass:[NSMutableArray class]])
    {
        if ([_selectedExpertArray isKindOfClass:[NSArray class]]) {
            _selectedExpertArray = [NSMutableArray arrayWithArray:_selectedExpertArray];
        }
    }
    return _selectedExpertArray;
}

- (UIView *)promptView
{
    if (!_promptView) {
        _promptView = [[UIView alloc] init];
        _promptView.backgroundColor = [UIColor whiteColor];
        UIImageView* promptImageView = [[UIImageView alloc] init];
        promptImageView.image = [UIImage imageNamed:@"ic_quanzi_noattention"];
        
        UILabel* promptLabel1 = [[UILabel alloc] init];
        promptLabel1.text = @"想提醒专家查看您的问题？";
        promptLabel1.font = [UIFont systemFontOfSize:kFontS13];
        promptLabel1.textColor = RGBHex(qwColor20);
        
        UILabel* promptLabel2 = [[UILabel alloc] init];
        promptLabel2.text = @"那先去关注专家吧";
        promptLabel2.font = [UIFont systemFontOfSize:kFontS13];
        promptLabel2.textColor = RGBHex(qwColor20);
        
        [_promptView addSubview:promptImageView];
        [_promptView addSubview:promptLabel1];
        [_promptView addSubview:promptLabel2];
        [self.view addSubview:_promptView];
        
        PREPCONSTRAINTS(_promptView);
        PREPCONSTRAINTS(promptImageView);
        PREPCONSTRAINTS(promptLabel1);
        PREPCONSTRAINTS(promptLabel2);
        
        ALIGN_TOPLEFT(_promptView, 0);
        ALIGN_BOTTOMRIGHT(_promptView, 0);
        
        CENTER_H(promptImageView);
        ALIGN_TOP(promptImageView, 125);
        
        LAYOUT_V(promptImageView, 28, promptLabel1);
        LAYOUT_V(promptLabel1, 5, promptLabel2);
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
//    [Forum getAllExpertInfoSuccess:^(NSArray *expertArray_) {
//        expertArray = expertArray_;
//        [self.tableView reloadData];
//    } failure:^(HttpException *e) {
//        DebugLog(@"getAllExpertInfo error : %@", e);
//    }];
    GetMyAttnExpertListR* getMyAttnExpertListR = [GetMyAttnExpertListR new];
    getMyAttnExpertListR.token = QWGLOBALMANAGER.configure.userToken;
    __weak typeof(self) weakSelf = self;
    [Forum getMyAttnExpertList:getMyAttnExpertListR success:^(NSArray *expertList) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf removeInfoView];
            strongSelf.expertArray = expertList;
            [strongSelf showPrompView:(strongSelf.expertArray.count == 0)];
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
        DebugLog(@"getMyAttnExpertList error : %@", e);
    }];
}

- (void)viewInfoClickAction:(id)sender
{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return expertArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertTableCell" forIndexPath:indexPath];
    [self configure:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"ExpertTableCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configure:cell indexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertTableCell* expertTableCell = [tableView cellForRowAtIndexPath:indexPath];
    QWExpertInfoModel* expertInfo = expertArray[indexPath.row];
    if ([expertTableCell isKindOfClass:[ExpertTableCell class]]) {
        
        if (!expertTableCell.chooseBtn.selected) {
            if (self.selectedExpertArray.count >= ChooseExpert_MaxSelectExpertNum) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"您最多只可选择%ld个专家进行提醒", (long)ChooseExpert_MaxSelectExpertNum]];
                return;
            }
            expertTableCell.chooseBtn.selected = YES;
            [self.selectedExpertArray addObject:expertInfo];
        }
        else
        {
            expertTableCell.chooseBtn.selected = NO;
            [self.selectedExpertArray removeObject:expertInfo];
        }
    }
}

- (void)configure:(ExpertTableCell*)cell indexPath:(NSIndexPath*)indexPath
{
    QWExpertInfoModel* expertInfo = expertArray[indexPath.row];
    [cell showChooseBtn:YES];
    cell.chooseBtn.selected = [self.selectedExpertArray containsObject:expertInfo];
    [cell setCell:expertInfo];
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
