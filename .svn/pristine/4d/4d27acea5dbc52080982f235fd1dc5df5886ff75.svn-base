//
//  MemberDiseaseListViewController.m
//  APP
//
//  Created by PerryChen on 8/21/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MemberDiseaseListViewController.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineR.h"
#import "SlowDiseaseListCell.h"

@interface MemberDiseaseListViewController ()<UITableViewDataSource, UITableViewDelegate, SlowDiseaseCellDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (nonatomic, strong) NSMutableArray *arrDiseaseList;   // 服务器端的慢病接口
@end

@implementation MemberDiseaseListViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.arrDiseaseList = [@[] mutableCopy];
    self.arrSelected = [@[] mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        [self showInfoView:kWarning12 image:@"网络信号icon"];
    } else {
        [self getAllMemberDisease];
    }
    self.navigationItem.title = @"添加慢性疾病";
}

// 同步本地和服务器的关注状态
- (void)syncFocusStatus
{
    // focus 2 是代表未关注
    NSMutableArray *arrTemp = [@[] mutableCopy];
    [self.arrDiseaseList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SlowDiseaseVo *modelVo = (SlowDiseaseVo *)obj;
        modelVo.isFocus = @"2";         // 统一设成未关注
        NSUInteger intFound = [QWGLOBALMANAGER valueExists:@"slowId" withValue:modelVo.slowId withArr:self.arrSelected];        // 如果找到本地和服务器端相同的关注慢病的id
        if (intFound != NSNotFound) {
            modelVo.isFocus = @"1";
            [arrTemp addObject:modelVo];
        }
    }];
    self.arrSelected = arrTemp;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 通知上一页面刷新
    if ([self.diseaseDelegate respondsToSelector:@selector(savedMemberDiseaseList:)]) {
        [self.diseaseDelegate savedMemberDiseaseList:self.arrSelected];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取慢病信息
- (void)getAllMemberDisease
{
    QueryMemberSlowDiseaseR *modelRSlowDisease = [[QueryMemberSlowDiseaseR alloc] init];
    if (self.modelMember.memberId==nil) {
        self.modelMember.memberId = @"";
    }
    modelRSlowDisease.memberId = self.modelMember.memberId;
    [FamilyMedicine queryMemberSlowDisease:modelRSlowDisease success:^(id diseases) {
        self.arrDiseaseList = [diseases mutableCopy];
        if (self.isEditMode) {
            [self syncFocusStatus];
        } else {
            for (SlowDiseaseVo *modelVo in self.arrDiseaseList) {
                if ([modelVo.isFocus intValue] == 1) {
                    [self.arrSelected addObject:modelVo];
                }
            }
        }
        if (self.arrDiseaseList.count == 0) {
            [self showInfoView:kWarning30 image:@"ic_img_fail"];
        } else {
            [self.tbViewContent reloadData];
        }
    } failure:^(HttpException *e) {
        [self showInfoView:kWarning30 image:@"ic_img_fail"];
    }];
}

// 点选了慢病
- (void)selectDiseaseCell:(BOOL)isSelect withIndex:(NSInteger)index
{
    SlowDiseaseVo *modelVo = self.arrDiseaseList[index];
    if ([modelVo.isFocus intValue] == 1) {
        modelVo.isFocus = @"2";
    } else {
        if (self.arrSelected.count >= 6) {
            [self showError:@"最多可添加6种慢病"];
            SlowDiseaseListCell *cellSlow = (SlowDiseaseListCell *)[self.tbViewContent cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            cellSlow.btnSelect.selected = NO;
            return;
        }
        modelVo.isFocus = @"1";
    }
    if (isSelect == YES) {
        [self.arrSelected addObject:modelVo];
    } else {
        __block NSUInteger intDelete = NSNotFound;
        [self.arrSelected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SlowDiseaseVo *modelV = (SlowDiseaseVo *)obj;
            if ([modelV.slowId isEqualToString:modelVo.slowId]) {
                intDelete = idx;
                *stop = YES;
            }
        }];
        if (intDelete != NSNotFound) {
            [self.arrSelected removeObjectAtIndex:intDelete];
        }
    }
    [self.tbViewContent reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlowDiseaseListCell *cellDisease = (SlowDiseaseListCell *)[tableView dequeueReusableCellWithIdentifier:@"SlowDiseaseListCell"];
    SlowDiseaseVo *modelVo = self.arrDiseaseList[indexPath.row];
    cellDisease.lblDiseaseTitle.text = modelVo.name;
    cellDisease.intSelectedIndex = indexPath.row;       // 给cell做处理
    cellDisease.btnSelect.selected = NO;
    cellDisease.cellDelegate = self;
    if ([modelVo.isFocus intValue] == 1) {
        cellDisease.btnSelect.selected = YES;       // 设置关注状态
    }
    cellDisease.separatorLine.hidden = YES;
    return cellDisease;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrDiseaseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlowDiseaseVo *modelVo = self.arrDiseaseList[indexPath.row];
    if ([modelVo.isFocus intValue] == 1) {
        modelVo.isFocus = @"2";
        __block NSUInteger intDelete = NSNotFound;
        [self.arrSelected enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SlowDiseaseVo *modelV = (SlowDiseaseVo *)obj;
            if ([modelV.slowId isEqualToString:modelVo.slowId]) {
                intDelete = idx;
                *stop = YES;
            }
        }];
        if (intDelete != NSNotFound) {
            [self.arrSelected removeObjectAtIndex:intDelete];
        }
    } else {
        if (self.arrSelected.count >= 6) {
            [self showError:@"最多可添加6种慢病"];
        } else {
            modelVo.isFocus = @"1";
            [self.arrSelected addObject:modelVo];
        }
    }
    [self.tbViewContent reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
