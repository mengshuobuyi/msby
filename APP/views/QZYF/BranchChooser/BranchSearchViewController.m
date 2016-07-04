//
//  BranchSearchViewController.m
//  APP
//  切换药房/选择药房-搜索药房
//  Created by 李坚 on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BranchSearchViewController.h"
#import "PharmacySotreSearchTableViewCell.h"
#import "ConsultStore.h"

static NSString *const BranchCellIdentifier = @"PharmacySotreSearchTableViewCell";

@interface BranchSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate>{
    
    int currPage;
}

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation BranchSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    currPage = 1;
    _dataArr = [NSMutableArray new];
    self.searchBarView.placeholder = @"搜索药房";
    
    self.searchBarView.delegate = self;
    
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
        [_mainTableView registerNib:[UINib nibWithNibName:BranchCellIdentifier bundle:nil] forCellReuseIdentifier:BranchCellIdentifier];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
    }
    [self.searchBarView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [_mainTableView.footer setCanLoadMore:YES];
    if(!StrIsEmpty(searchBar.text)){

        currPage = 1;
        [self requestSearchWithKey:searchBar.text];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if(!StrIsEmpty(searchBar.text)){
        
        currPage = 1;
        [self requestSearchWithKey:searchBar.text];
    }
}

- (void)loadMoreData{
    
    currPage ++;
    [self requestSearchWithKey:self.searchBarView.text];
}

#pragma mark - 药房搜索请求
- (void)requestSearchWithKey:(NSString *)keyStr{
    
    MallSearchModelR *modelR = [MallSearchModelR new];
    modelR.key = [QWGLOBALMANAGER replaceSymbolStringWith:keyStr];
    modelR.page = @(currPage);
    modelR.pageSize = @(10);
    
    MapInfoModel *mapInfoModel = [QWUserDefault getModelBy:kLastLocationSuccessAddressModel];
    //开通微商，跟手机走
    if(mapInfoModel.status == 3)
    {
        modelR.city = mapInfoModel.city;
        modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
        modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
    }
    else//未开通微商
    {
        if(StrIsEmpty([QWGLOBALMANAGER getMapInfoModel].branchCityName))//如果药房城市为空，跟手机走
        {
            modelR.city = mapInfoModel.city;
            modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
            modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
        }
        else
        {   //如果药房城市有值，跟药房走
            modelR.city = [QWGLOBALMANAGER getMapInfoModel].branchCityName;
            modelR.longitude = @([QWGLOBALMANAGER getMapInfoModel].location.coordinate.longitude);
            modelR.latitude = @([QWGLOBALMANAGER getMapInfoModel].location.coordinate.latitude);
        }
    }
    
    modelR.containsSociety = NO;
    modelR.national = [SHOW_NATIONWIDE boolValue];

    [ConsultStore MallSearch:modelR success:^(MicroMallBranchListVo *model) {
        if(currPage == 1){
            [_dataArr removeAllObjects];
            if(model.branchs.count == 0){   
                [self showInfoView:@"在您当前城市下没有搜索到结果" image:@"icon_no result_search1"];
            }else{
                [self removeInfoView];
                [_dataArr addObjectsFromArray:model.branchs];
                [_mainTableView addFooterWithTarget:self action:@selector(loadMoreData)];
                [_mainTableView reloadData];
            }
        }else{
            if(model.branchs.count == 0){
                [_mainTableView.footer setCanLoadMore:NO];
            }else{
                [_dataArr addObjectsFromArray:model.branchs];
                [_mainTableView reloadData];
            }
        }
        [_mainTableView.footer endRefreshing];
    } failure:^(HttpException *e) {
        [_mainTableView.footer endRefreshing];
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"icon_no result_search"];
            }else{
                [self showInfoView:kWarning39 image:@"icon_no result_search"];
            }
        }
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    
    //用户滑动TableView时，隐藏键盘
    [self.searchBarView resignFirstResponder];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PharmacySotreSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BranchCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MicroMallBranchVo *model = _dataArr[indexPath.row];
    
    [cell setCell:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [PharmacySotreSearchTableViewCell getCellHeight:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MicroMallBranchVo *model = _dataArr[indexPath.row];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [QWGLOBALMANAGER setMapBranchId:model.branchId branchName:model.branchName];
    
    //self.pageType，1.来自首页和第一次定位 2.来自分类
    if(self.pageType == 1){
        [QWGLOBALMANAGER postNotif:NotifChangeBranchFromHomePage data:model.branchName object:nil];
    }
    if(self.pageType == 2){
        [QWGLOBALMANAGER postNotif:NotifChangeBranchFromGoodList data:model.branchName object:nil];
    }
}

@end