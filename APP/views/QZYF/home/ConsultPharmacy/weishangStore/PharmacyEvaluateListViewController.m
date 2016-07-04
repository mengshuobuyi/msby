//
//  PharmacyEvaluateListViewController.m
//  APP
//
//  Created by PerryChen on 1/7/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "PharmacyEvaluateListViewController.h"
#import "PharmacyEvaluateListCell.h"
#import "ConsultStore.h"
#import "Appraise.h"

static NSString *const CellIdentifier = @"PharmacyEvaluateListCell";
@interface PharmacyEvaluateListViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger currPage;
}
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (strong, nonatomic) NSMutableArray *EvaluatList;
@end

@implementation PharmacyEvaluateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tbViewContent registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    currPage = 1;
    
    self.title = @"药房评价";
    _EvaluatList = [[NSMutableArray alloc]init];
    [self loadEvluationList];
    
    
    [_tbViewContent addFooterWithTarget:self action:@selector(refreshMoreData)];
}

- (void)headerRefresh
{
    currPage = 1;
    [self loadEvluationList];
}

- (void)refreshMoreData{
    
    currPage ++;
    [self loadEvluationList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
       [self showInfoView:kWarning52 image:@"ic_img_fail"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak typeof (self) __weakSelf = self;
    [self enableSimpleRefresh:self.tbViewContent block:^(SRRefreshView *sender) {
        [__weakSelf headerRefresh];
    }];
}

- (void)loadEvluationList{
    
//    BranchEvluationModelR *modelR = [BranchEvluationModelR new];
//    modelR.branchId = self.pharmacyID;
//    modelR.page = @(currPage);
//    modelR.pageSize = @(10);
//    
//    [ConsultStore BranchEvluationList:modelR success:^(AppraiseListVo *model) {
//        if(model.appraises == nil || model.appraises.count == 0){
//            if(currPage == 1){
//                [self showInfoView:kWarning52 image:@"ic_img_fail"];
//            }else{
//                [_tbViewContent.footer endRefreshing];
//                [_tbViewContent.footer setCanLoadMore:NO];
//            }
//        }else{
//            [_EvaluatList addObjectsFromArray:model.appraises];
//            [_tbViewContent reloadData];
//            [_tbViewContent.footer endRefreshing];
//        }
//    } failure:^(HttpException *e) {
//        
//    }];
    
    StoreAppraiseModelR *appraiseModelR = [StoreAppraiseModelR new];
    appraiseModelR.branchId = self.pharmacyID;
    appraiseModelR.page = @(currPage);
    appraiseModelR.pageSize = @10;
    
    if(currPage == 1){
        HttpClientMgr.progressEnabled = YES;
    }else{
        HttpClientMgr.progressEnabled = NO;
    }
    
    [Appraise queryAppraiseWithParams:appraiseModelR success:^(id resultObj) {
        
        QueryAppraiseModel *queryModel = (QueryAppraiseModel *)resultObj;
        if (currPage == 1) {
            [_EvaluatList removeAllObjects];
            if(queryModel.appraises.count == 0){
                [self showInfoView:@"该药房暂无评价" image:@"ic_img_fail"];
                return;
            } else {
                
            }
        }else{
            if (queryModel.appraises.count == 0) {
                [self.tbViewContent.footer setCanLoadMore:NO];
            }
            [_tbViewContent.footer endRefreshing];
            [self removeInfoView];
        }
        [_EvaluatList addObjectsFromArray:queryModel.appraises];
        [_tbViewContent reloadData];
        
    } failure:^(HttpException *e) {
        [_tbViewContent footerEndRefreshing];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods
- (void)configureCellStyleOneContent:(PharmacyEvaluateListCell *)cellE andEvaluation:(StoreAppraiseModel *)VO
{
    cellE.lblContent.textColor = RGBHex(qwColor6);
    cellE.lblContent.font = fontSystem(kFontS4);
    cellE.lblName.textColor = RGBHex(qwColor5);
    cellE.lblName.font = fontSystem(kFontS5);
    NSString *strUserName = @"";
    if ([VO.nick length] > 0) {
        strUserName = VO.nick;
    } else {
        strUserName = @"";
    }
    cellE.lblName.text = strUserName;
    cellE.lblContent.text = VO.remark;
}

- (CGFloat)calculateCellEvaluateContentWithIndexPath:(NSIndexPath *)path
{
    static PharmacyEvaluateListCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellIdentifier];
    });
    [self configureCellStyleOneContent:sizingCell andEvaluation:_EvaluatList[path.row]];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tbViewContent.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PharmacyEvaluateListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCellStyleOneContent:cell andEvaluation:_EvaluatList[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateCellEvaluateContentWithIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _EvaluatList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
