//
//  SearchParentViewController.m
//  wenyao
//
//  Created by Meng on 14-9-20.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "SearchRootViewController.h"
#import "Drug.h"
#import "SearchDisease_SymptomListViewController.h"
#import "SearchMedicineListViewController.h"

@interface SearchRootViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *  footView;

    NSInteger currentPage;
    NSString *keyNewWord;
    
}
@property (nonatomic ,strong) UITableView * mTableView;
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic ,strong) NSMutableArray * searchHistoryArray;//搜索历史的存储
@end

@implementation SearchRootViewController
@synthesize searchBar = _searchBar;

- (instancetype)init{
    if (self = [super init]) {
        self.mTableView.rowHeight = 35;
        self.dataSource = [NSMutableArray array];
        keyNewWord=@"";
    }
    return self;
}

- (void)setSearchBar:(UISearchBar *)searchBar
{
    _searchBar = searchBar;
    
}

- (void)setKeyWord:(NSString *)keyWord{
    _keyWord = keyWord;
    [self keyWordSet];
}

- (void)keyWordSet
{
    //搜索关键字不存在
    if (self.keyWord == nil ||self.keyWord.length == 0)  {

        //判断搜索类型
        switch (self.histroySearchType)
        {
            case 0:
                self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:getHistoryConfig(@"medicineSearch")];
                break;
            case 1:
                self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:getHistoryConfig(@"diseaseSearch")];
                break;
            case 2:
                self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:getHistoryConfig(@"symptomSearch")];
                break;
            default:
                break;
        }
        //如果有搜索历史
        if (self.searchHistoryArray.count > 0) {
            footView.hidden = NO;
            [footView setFrame:CGRectMake(0, self.mTableView.frame.size.height+self.mTableView.frame.origin.y, APP_W, 44)];
            [self.mTableView reloadData];
        }else{
            [self showInfoView:@"暂无搜索记录" image:nil];
        }
    }else{

        
        [footView setFrame:CGRectMake(0, self.mTableView.frame.size.height+self.mTableView.frame.origin.y, APP_W, 0)];
        footView.hidden = YES;
        self.mTableView.frame = CGRectMake(0, 0, APP_W, APP_H-35-NAV_H);
        currentPage = 1;
        [self.mTableView addFooterWithTarget:self action:@selector(footerRereshing)];
        self.mTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
        self.mTableView.footerReleaseToRefreshText = @"松开加载更多数据了";
        self.mTableView.footerRefreshingText = @"正在帮你加载中";
        self.mTableView.footerNoDataText = kWarning44;
        self.loadMore = NO;
        self.mTableView.footer.canLoadMore=YES;
        [self loadDataWithKeyWord:self.keyWord];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpTableViewFootView];
}

#pragma mark ------ setup ------
- (void)setUpTableView{
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H + 20) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.backgroundColor = RGBHex(qwColor11);
    [self.view addSubview:self.mTableView];
}

- (void)setUpTableViewFootView{
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 44)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.clipsToBounds = YES;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"清空搜索记录icon.png"]];
    image.frame = CGRectMake(APP_W*0.35 - 20, 15, 15, 15);
    
    UIButton * clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(APP_W*0.35, 15, 100, 15)];
    clearBtn.titleLabel.font = fontSystem(kFontS1);
    [clearBtn setTitle:@"清空搜索历史" forState:0];
    [clearBtn setTitleColor:RGBHex(qwColor7) forState:0];
    [clearBtn setBackgroundColor:[UIColor clearColor]];
    [clearBtn addTarget:self action:@selector(onClearBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:image];
    [footView addSubview:clearBtn];
    
    self.mTableView.tableFooterView.frame = footView.frame;
    self.mTableView.tableFooterView = footView;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar == self.searchBar) {
        [self keyWordSet];
    }
}


#pragma mark ------数据请求------
- (void)loadDataWithKeyWord:(NSString *)keyWord
{
    GetSearchKeywordsR *keywords=[GetSearchKeywordsR new];
    keywords.keyword=keyWord;
    keywords.currPage=[NSString stringWithFormat:@"%@",@(currentPage)];
    keywords.pageSize=[NSString stringWithFormat:@"%i",10];
    if (self.histroySearchType == 0){
        keywords.type = @"0";
    }else if (self.histroySearchType == 1){
        keywords.type = @"1";
    }else if (self.histroySearchType == 2){
        keywords.type = @"2";
    }
    [self removeInfoView];
    [Drug getsearchKeywordsWithParam:keywords Success:^(id DFUserModel) {
//        [self.mTableView footerEndRefreshing];
//        GetSearchKeywordsModel *searchkey=DFUserModel;
//        NSArray *list = searchkey.list;
//        if (currentPage == 1) {
//            [self.dataSource removeAllObjects];
//            if (list.count == 0) {
//                //没有搜索结果
//                [self showInfoView:@"没有搜索结果" image:@"ic_img_fail"];
//            }else{
//                [self.dataSource addObjectsFromArray:list];
//            }
//        }else{
//            if (list.count > 0) {
//                currentPage++;
//                [self.dataSource addObjectsFromArray:list];
//            }
//        }
//        if (self.dataSource.count > 0) {
//            [self.mTableView reloadData];
//        }else{
//            //没有搜索结果
//            [self showInfoView:@"没有搜索结果" image:@"ic_img_fail"];
//        }
//        [self.tableMain reloadData];
        
        GetSearchKeywordsModel *searchkey=DFUserModel;
        if(self.loadMore)
        {
            NSArray *array = searchkey.list;
            if(array.count > 0)
                for (GetSearchKeywordsclassModel *key in searchkey.list) {
                    [self.dataSource addObject:key];
                }
        }else{
            self.dataSource = [NSMutableArray array];
            for (GetSearchKeywordsclassModel *key in searchkey.list) {
                [self.dataSource addObject:key];
            }
        }
        if (searchkey.list.count > 0) {
            currentPage++;
            [self removeInfoView];
        }else{
            if(currentPage==1){
                [self showInfoView:@"暂无搜索结果" image:nil];
            }else{
                //没有搜索结果
                self.mTableView.footer.canLoadMore=NO;
                [self removeInfoView];
            }
        }
        [self.mTableView footerEndRefreshing];
        [self.mTableView reloadData];
    } failure:^(HttpException *e) {
        [self.mTableView footerEndRefreshing];
        [self.mTableView reloadData];
    }];
    
}

- (void)footerRereshing
{
    self.loadMore = YES;
    [self loadDataWithKeyWord:self.keyWord];
}

#pragma mark ------ Table view data source -------

- (NSInteger)tableView:(UITableView *)tawbleView numberOfRowsInSection:(NSInteger)section{
    if (self.keyWord==nil||self.keyWord.length == 0) {
        if(self.searchHistoryArray.count>0){
            return self.searchHistoryArray.count;
        }else{
            return 0;
        }
        
    }else{
        
        if(self.dataSource.count>0){
             return self.dataSource.count;
        }else{
            return 0;
        }
   
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.font = font(kFont2, kFontS5);
    if (self.keyWord.length > 0 && self.dataSource.count>indexPath.row) {
        cell.textLabel.frame = CGRectMake(14, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
        GetSearchKeywordsclassModel *key=self.dataSource[indexPath.row];
        cell.textLabel.text=key.gswCname;
        cell.textLabel.font = fontSystem(kFontS1);
        cell.textLabel.textColor = RGBHex(qwColor6);
        UIView *bkView = [[UIView alloc]initWithFrame:cell.frame];
        bkView.backgroundColor = RGBHex(qwColor10);
        cell.selectedBackgroundView = bkView;
        
    }else{
        
        if(self.searchHistoryArray.count>indexPath.row){
            cell.textLabel.text = self.searchHistoryArray[indexPath.row];
            cell.textLabel.font = fontSystem(kFontS1);
            cell.textLabel.textColor = RGBHex(qwColor6);
        }
      
        
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(14, 44.5, APP_W - 14, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell addSubview:line];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath*    selection = [self.mTableView indexPathForSelectedRow];
    
    if (selection) {
        [self.mTableView deselectRowAtIndexPath:selection animated:YES];
    }
    if (self.keyWord.length > 0) {//搜索表
        if(self.dataSource.count > indexPath.row){
        GetSearchKeywordsclassModel *key = self.dataSource[indexPath.row];
        if(key){
            keyNewWord=key.gswCname;
        }else{
            keyNewWord=self.keyWord;
        }
        if ([self.searchHistoryArray containsObject:keyNewWord]) {
            [self.searchHistoryArray removeObject:keyNewWord];
        }
        if (self.searchHistoryArray.count == 5) {
            [self.searchHistoryArray removeObjectAtIndex:self.searchHistoryArray.count-1];
        }
        
        [self.searchHistoryArray insertObject:keyNewWord atIndex:0];

        switch (self.histroySearchType) {
            case 0:
            {
                setHistoryConfig(@"medicineSearch", self.searchHistoryArray);
                SearchMedicineListViewController * medicineList = [[SearchMedicineListViewController alloc] init];
                medicineList.kwId = key.gswId;
                medicineList.title = key.gswCname;
                [self.navigation pushViewController:medicineList animated:YES];
            }
                break;
            case 1:
            {
                setHistoryConfig(@"diseaseSearch", self.searchHistoryArray);
                SearchDisease_SymptomListViewController * searchDisease_Symptom = [[SearchDisease_SymptomListViewController alloc] init];
                searchDisease_Symptom.requsetType = RequsetTypeDisease;
                searchDisease_Symptom.kwId = key.gswId;
                searchDisease_Symptom.title = key.gswCname;
                [self.navigation pushViewController:searchDisease_Symptom animated:YES];
            }
                break;
            case 2:
            {
                setHistoryConfig(@"symptomSearch", self.searchHistoryArray);
                SearchDisease_SymptomListViewController * searchDisease_Symptom = [[SearchDisease_SymptomListViewController alloc] init];
                searchDisease_Symptom.requsetType = RequsetTypeSymptom;
                searchDisease_Symptom.kwId = key.gswId;
                searchDisease_Symptom.title = key.gswCname;
                [self.navigation pushViewController:searchDisease_Symptom animated:YES];
            }
                break;
            default:
                break;
        }
    }
    }else{
        if(self.searchHistoryArray.count>0&&self.searchHistoryArray.count>indexPath.row){
        NSString * historyKeyWord = self.searchHistoryArray[indexPath.row];
        self.keyWord = historyKeyWord;
        [self keyWordSet];
        if ([self.delegate respondsToSelector:@selector(searchBarText:)]) {
            [self.delegate searchBarText:historyKeyWord];
        }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.keyWord==nil||self.keyWord.length == 0) {
        if(self.searchHistoryArray.count>0){
        return 30;
        }else{
        return 0;
        }
    }else{
    return 0;
    }
}
//进入的时候关键字为空，加入最近搜索的lable
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , APP_W, 12)];
        v.backgroundColor = RGBHex(qwColor11);
        
        UIImage* icon = [UIImage imageNamed:@"clock"];
        UIImageView* iconView = [[UIImageView alloc ] initWithImage:icon];
        iconView.frame = RECT(14, 9, icon.size.width, icon.size.height);
        [v addSubview:iconView];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(14+icon.size.width+5, 9, 200, 12)];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.text = @"最近搜索";
        [v addSubview:label];
        return v;
}


- (void)onClearBtnTouched:(UIButton *)button{
    [self.searchHistoryArray removeAllObjects];
    switch (self.histroySearchType) {
        case 0://清除药品搜索历史
            setHistoryConfig(@"medicineSearch",nil);
            break;
        case 1://清除疾病搜索历史
            setHistoryConfig(@"diseaseSearch",nil);
            break;
        case 2://清除症状搜索历史
            setHistoryConfig(@"symptomSearch",nil);
            break;
        default:
            break;
    }
    self.keyWord = @"";
    [self keyWordSet];
}

#pragma mark ------其他函数方法------
- (void)viewDidCurrentView{
    
}


- (void)keyboardHidenClick{
    if (self.scrollBlock) {
        self.scrollBlock();
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.scrollBlock) {
        self.scrollBlock();
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
