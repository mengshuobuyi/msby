//
//  QuickSearchDrugViewController.m
//  wenYao-store
//
//  Created by YYX on 15/6/8.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuickSearchDrugViewController.h"
#import "QCSlideSwitchView.h"
#import "ThreeChildrenViewController.h"
#import "MedicineListViewController.h"
#import "QuickSearchDrugListViewController.h"
#import "QuickScanDrugViewController.h"
#import "QYPhotoAlbum.h"
@interface QuickSearchDrugViewController ()<UISearchBarDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar* m_searchBar;
    UITextField* m_searchField;
    
    UIView *  footView;
    UIView * bgView;
    NSInteger currentPage;
}

@property (nonatomic ,strong) NSString *keyWord;
@property (nonatomic ,strong) UITableView * mTableView;
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic ,strong) NSMutableArray * searchHistoryArray;

@end

@implementation QuickSearchDrugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mTableView.rowHeight = 35;
        
    }
    return self;
}
- (void)popVCAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_searchBar becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self keyWordSet];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [m_searchField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:m_searchBar];
    
    UIView* status_bg = [[UIView alloc] initWithFrame:RECT(0, 0, APP_W, STATUS_H)];
    status_bg.backgroundColor = RGBHex(qwColor1);
    [self.view addSubview:status_bg];
    
    UIView* searchbg = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_H, APP_W, NAV_H)];
    searchbg.backgroundColor=RGBHex(qwColor1);
    [self.view addSubview:searchbg];
    
    m_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, STATUS_H, APP_W-50, NAV_H)];
    m_searchBar.tintColor = [UIColor blueColor];
    m_searchBar.backgroundColor = RGBHex(qwColor1);
    m_searchBar.placeholder = @"请搜索一个药品咨询";
    m_searchBar.delegate = self;
    [self.view addSubview:m_searchBar];
    
    if (iOSv7) {
        UIView* barView = [m_searchBar.subviews objectAtIndex:0];
        [[barView.subviews objectAtIndex:0] removeFromSuperview];
        UITextField* searchField = [barView.subviews objectAtIndex:0];
        searchField.font = [UIFont systemFontOfSize:13.0f];
        [searchField setReturnKeyType:UIReturnKeySearch];
        m_searchField = searchField;
    } else {
        [[m_searchBar.subviews objectAtIndex:0] removeFromSuperview];
        UITextField* searchField = [m_searchBar.subviews objectAtIndex:0];
        searchField.delegate = self;
        searchField.font = [UIFont systemFontOfSize:13.0f];
        [searchField setReturnKeyType:UIReturnKeySearch];
        m_searchField = searchField;
    }
    m_searchField.clearButtonMode = UITextFieldViewModeNever;
    UIButton* scanDrug = [[UIButton alloc] initWithFrame:CGRectMake(APP_W-80, STATUS_H+12, 22, 22)];
    scanDrug.backgroundColor = [UIColor whiteColor];
    [scanDrug setImage:[UIImage imageNamed:@"扫码-搜索"] forState:UIControlStateNormal];
    [scanDrug addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    scanDrug.tag = 555;
    [self.view addSubview:scanDrug];

    
    
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:RECT(APP_W-60, STATUS_H, 60, NAV_H)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.titleLabel.font = fontSystem(kFontS3);
    [cancelBtn setTitle:kWarning5 forState:0];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:0];
    [cancelBtn addTarget:self action:@selector(onCancelBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 888;
    [self.view addSubview:cancelBtn];
    
    [self.view bringSubviewToFront:scanDrug];
    [self setUpTableView];
    [self setUpTableViewFootView];
    
}

//扫码
- (void)scanAction
{
    if (![QYPhotoAlbum checkCameraAuthorizationStatus]) {
        [QWGLOBALMANAGER getCramePrivate];
        return;
    }
    QuickScanDrugViewController *scanReaderViewController = [[QuickScanDrugViewController alloc] init];
    scanReaderViewController.hidesBottomBarWhenPushed = YES;
    scanReaderViewController.useType = 1;
    [self.navigationController pushViewController:scanReaderViewController animated:YES];
    
    if (self.returnValueBlock) {
        
        scanReaderViewController.block = ^(id model){
            productclassBykwId *product = model;
            self.returnValueBlock(product);
        };
    }
}


#pragma mark ------ setup ------
- (void)setUpTableView{
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, APP_W, APP_H-NAV_H) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.backgroundColor = RGBHex(qwColor11);
    [self.view addSubview:self.mTableView];
}

- (void)setUpTableViewFootView{
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 20)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.clipsToBounds = YES;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"清空搜索记录icon.png"]];
    image.frame = CGRectMake(APP_W*0.35 - 20, 15, 15, 15);
    
    UIButton * clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(APP_W*0.35, 15, 100, 15)];
    clearBtn.titleLabel.font = font(kFont2, kFontS1);
    [clearBtn setTitle:@"清空搜索历史" forState:0];
    [clearBtn setTitleColor:RGBHex(qwColor7) forState:0];
    [clearBtn setBackgroundColor:[UIColor clearColor]];
    [clearBtn addTarget:self action:@selector(onClearBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:image];
    [footView addSubview:clearBtn];
    DebugLog(@"高度%f",footView.frame.size.height);
    
    self.mTableView.tableFooterView.frame = footView.frame;
    self.mTableView.tableFooterView = footView;
}

#pragma mark ------数据请求------
- (void)loadDataWithKeyWord:(NSString *)keyWord
{
    GetSearchKeywordsR *keywords=[GetSearchKeywordsR new];
    keywords.keyword=keyWord;
    keywords.currPage=[NSString stringWithFormat:@"%@",@(currentPage)];
    keywords.pageSize=[NSString stringWithFormat:@"%i",10];
    keywords.type = @"0";
    
    [self removeInfoView];
    [Drug getsearchKeywordsWithParam:keywords Success:^(id DFUserModel) {
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
        if(searchkey.list.count==0){
            self.mTableView.footer.canLoadMore=NO;
        }
        if (self.dataSource.count > 0) {
            [self.mTableView reloadData];
            currentPage++;
            [self.mTableView footerEndRefreshing];
        }else{
            //没有搜索结果
            [self showMyView:@"暂无搜索结果" image:@"ic_img_cry"];
        }
        
    } failure:^(HttpException *e) {
    }];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar == m_searchBar) {
        [m_searchField resignFirstResponder];
        [self keyWordSet];
    }
}

- (void)footerRereshing
{
    self.loadMore = YES;
    [self loadDataWithKeyWord:self.keyWord];
}

#pragma mark ------ Table view data source -------

- (NSInteger)tableView:(UITableView *)tawbleView numberOfRowsInSection:(NSInteger)section{
    if (self.keyWord.length == 0) {
        return self.searchHistoryArray.count;
    }
    return self.dataSource.count;
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
    cell.textLabel.font = fontSystem(kFontS1);
    cell.textLabel.textColor = RGBHex(qwColor6);
    if (self.keyWord.length > 0) {
        cell.textLabel.frame = CGRectMake(14, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
        GetSearchKeywordsclassModel *key=self.dataSource[indexPath.row];
        cell.textLabel.text=key.gswCname;
        UIView *bkView = [[UIView alloc]initWithFrame:cell.frame];
        bkView.backgroundColor = RGBHex(qwColor10);
        cell.selectedBackgroundView = bkView;
        
    }else{
        cell.textLabel.text = self.searchHistoryArray[indexPath.row];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(14, 44.5, APP_W - 14, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell addSubview:line];
    cell.selectedBackgroundView.backgroundColor=RGBHex(qwColor10);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath*    selection = [self.mTableView indexPathForSelectedRow];
    if (selection) {
        [self.mTableView deselectRowAtIndexPath:selection animated:YES];
    }
    if (self.keyWord.length > 0 && self.dataSource.count > 0) {
        //搜索表
        
        GetSearchKeywordsclassModel *key = self.dataSource[indexPath.row];
        
        if ([self.searchHistoryArray containsObject:key.gswCname]) {
            [self.searchHistoryArray removeObject:key.gswCname];
        }
        if (self.searchHistoryArray.count == 5) {
            [self.searchHistoryArray removeObjectAtIndex:self.searchHistoryArray.count-1];
        }
        
        [self.searchHistoryArray insertObject:key.gswCname atIndex:0];
        
        setHistoryConfig(@"medicineSearch", self.searchHistoryArray);
        
        QuickSearchDrugListViewController * medicineList = [[QuickSearchDrugListViewController alloc] init];
        medicineList.kwId = key.gswId;
        [self.navigationController pushViewController:medicineList animated:YES];
        
        if (self.returnValueBlock) {
           
            medicineList.block = ^(id model){
                productclassBykwId *product = model;
                self.returnValueBlock(product);
            };
        }
        
        
    
    }else{
        NSString * historyKeyWord = self.searchHistoryArray[indexPath.row];
        self.keyWord = historyKeyWord;
        [self keyWordSet];
        m_searchField.text = self.keyWord;
        
    }
}

- (void)onClearBtnTouched:(UIButton *)button{
    [self.searchHistoryArray removeAllObjects];
    setHistoryConfig(@"medicineSearch",nil);
    self.keyWord = @"";
    [self keyWordSet];
}


- (void)textFieldValueChanged:(NSNotification *)notification
{
    UISearchBar * searchBar = (UISearchBar *)notification.object;
    NSString * key = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.keyWord = key;
    [self keyWordSet];
}

- (void)keyWordSet
{
    
    if (self.keyWord.length == 0 || self.keyWord == nil) {
        
        if (bgView) {
            [bgView removeFromSuperview];
            bgView = nil;
        }
        //判断搜索类型
        self.searchHistoryArray = [[NSMutableArray alloc] initWithArray:getHistoryConfig(@"medicineSearch")];
        
        if (self.searchHistoryArray.count > 0) {
            footView.hidden = NO;
            [footView setFrame:CGRectMake(0, self.mTableView.frame.size.height+self.mTableView.frame.origin.y, APP_W, 45)];
            [self.mTableView reloadData];
        }else{
            [self showMyView:@"暂无搜索记录" image:@"ic_img_cry"];
        }
    }else{
        if (bgView) {
            [bgView removeFromSuperview];
            bgView = nil;
        }
        
        [footView setFrame:CGRectMake(0, self.mTableView.frame.size.height+self.mTableView.frame.origin.y, APP_W, 0)];
//        footView.hidden = YES;
        self.mTableView.frame = CGRectMake(0, 64, APP_W, APP_H-NAV_H);
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


- (void)onCancelBtnTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hidekeyboard
{
    CGRect rect = m_searchField.frame;
    [m_searchField resignFirstResponder];
    m_searchField.frame = rect;
    m_searchBar.tintColor = [UIColor blueColor];
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)showMyView:(NSString *)text image:(NSString*)imageName {
    [self showMyView:text image:imageName tag:0];
}

-(void)showMyView:(NSString *)text image:(NSString*)imageName tag:(NSInteger)tag
{
    UIImage * imgInfoBG = [UIImage imageNamed:imageName];
    
    
    if (self.vInfo==nil) {
        self.vInfo = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APP_W, APP_H-NAV_H)];
        self.vInfo.backgroundColor = RGBHex(qwColor11);
    }
    
    for (id obj in self.vInfo.subviews) {
        [obj removeFromSuperview];
    }
    
    UIImageView *imgvInfo;
    UILabel* lblInfo;
    
    imgvInfo=[[UIImageView alloc]init];
    [self.vInfo addSubview:imgvInfo];
    
    lblInfo = [[UILabel alloc]init];
    lblInfo.numberOfLines=0;
    lblInfo.font = fontSystem(kFontS1);
    lblInfo.textColor = RGBHex(qwColor8);//0x89889b 0x6a7985
    lblInfo.textAlignment = NSTextAlignmentCenter;
    [self.vInfo addSubview:lblInfo];
    
    UIButton *btnClick = [[UIButton alloc] initWithFrame:self.vInfo.bounds];
    btnClick.tag=tag;
    [btnClick addTarget:self action:@selector(viewInfoClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.vInfo addSubview:btnClick];
    
    
    float vw=CGRectGetWidth(self.vInfo.bounds);
    
    CGRect frm;
    frm=RECT((vw-imgInfoBG.size.width)/2,90, imgInfoBG.size.width, imgInfoBG.size.height);
    imgvInfo.frame=frm;
    imgvInfo.image = imgInfoBG;
    
    float lw=vw-40*2;
    float lh=(imageName!=nil)?CGRectGetMaxY(imgvInfo.frame) + 24:140;
    CGSize sz=[QWGLOBALMANAGER sizeText:text font:lblInfo.font limitWidth:lw];
    frm=RECT((vw-lw)/2, lh, lw,sz.height);
    lblInfo.frame=frm;
    lblInfo.text = text;
    
    [self.view addSubview:self.vInfo];
    [self.view bringSubviewToFront:self.vInfo];
}




@end