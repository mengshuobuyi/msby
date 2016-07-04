//
//  DiseaseWikiViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DiseaseWikiViewController.h"
#import "BATableView.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "DiseaseModelR.h"
#import "DiseaseModel.h"
#import "Disease.h"
#import "DiseaseVikiCell.h"
#import "QWFileManager.h"
#import "CommonDiseaseDetailViewController.h"
#import "WebDirectViewController.h"


@interface DiseaseWikiViewController ()<BATableViewDelegate>
{
    BATableView * myTableView;
}
@property (nonatomic ,strong) NSMutableArray *rightIndexArray;
//设置每个section下的cell内容
@property (nonatomic ,strong) NSMutableArray *LetterResultArr;

@property (nonatomic ,strong) NSMutableArray * usualArray;
@property (nonatomic ,strong) NSMutableArray * unusualArray;
@property (nonatomic ,strong) NSMutableArray * dataSource;
@end

@implementation DiseaseWikiViewController

@synthesize rightIndexArray,LetterResultArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.dataSource.count > 1) {
        return;
    }
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        //read缓存
        if ([QWFileManager IsFileExists:[NSString stringWithFormat:@"%@/diseasewiki.plist",[QWFileManager GetCachePath]]]) {
            NSDictionary *subDict = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/diseasewiki.plist",[QWFileManager GetCachePath]]];
            [self httpRequestResult:subDict];
        }

    } else {
        [self getDataFromService];
    }
    
}

#pragma mark   新接口 NSDictionary
- (void)httpRequestResult:(id)resultObj
{
    NSDictionary *subDict = resultObj[@"data"];
    if([[subDict allKeys] count] == 0) {
        [self showInfoView:kWarning12 image:@"网络信号icon"];
        return;
    }
    [self sortIndexDisease:subDict];
    [myTableView reloadData];
    
}

- (void)sortIndexDisease:(NSDictionary *)subDict
{
    [self.rightIndexArray removeAllObjects];
    [self.LetterResultArr removeAllObjects];
    self.rightIndexArray  = [[subDict allKeys] mutableCopy];
    
    [self.rightIndexArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        if([string1 isEqualToString:@"#"]) {
            return 1;
        }else if([string2 isEqualToString:@"#"]) {
            return -1;
        }
        return [string1 compare:string2];
    }];
    
    for(NSString *keyValue in self.rightIndexArray)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:15];
        for(NSDictionary *singlePerson in subDict[keyValue])
        {
            [array addObject:singlePerson];
        }

        [self.LetterResultArr addObject:array];
        
    }
   
    
    if (self.self.rightIndexArray .count == 0)
    {
        [self showInfoView:kWarning12 image:@"网络信号icon"];
    }else
    {
        [myTableView reloadData];
    }
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_1_fh" withLable:@"药品" withParams:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"疾病百科";
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.dataSource = [NSMutableArray array];
    self.usualArray = [NSMutableArray array];
    self.unusualArray = [NSMutableArray array];
    self.rightIndexArray = [NSMutableArray array];
    self.LetterResultArr = [NSMutableArray array];
    [self makeTableView];
}

- (void)makeTableView
{
    myTableView = [[BATableView alloc]init];
    myTableView = [[BATableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H-35)];
    myTableView.delegate = self;
    myTableView.backgroundColor = RGBHex(qwColor11);
    
    [self.view addSubview:myTableView];
}

#pragma mark - UITableViewDataSource
- (NSArray *) sectionIndexTitlesForABELTableView:(BATableView *)tableView {
    return self.rightIndexArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rightIndexArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)self.LetterResultArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * cellName = @"DiseaseVikiCell";
    DiseaseVikiCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[DiseaseVikiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        
    }
    
    if((indexPath.row + 1) != [(NSArray *)self.LetterResultArr[indexPath.section] count]){
        
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 0.5, 550, 0.5)];
        [separator setBackgroundColor:RGBHex(qwColor10)];
        [cell.contentView addSubview:separator];
    }
    cell.name.text = self.LetterResultArr[indexPath.section][indexPath.row][@"name"];
    cell.selectedBackgroundView = [[UIView alloc]init];
    cell.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , APP_W, 28)];
    v.backgroundColor = RGBHex(qwColor11);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 28)];
    label.font = [UIFont systemFontOfSize:12.0f];
    if (section == 0 && self.usualArray.count > 0) {
        label.text = @"常见疾病";
    }else{
        label.text = self.rightIndexArray[section];
    }
    [v addSubview:label];
    return v;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selection = [myTableView.tableView indexPathForSelectedRow];
    if (selection) {
        [myTableView.tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    NSString *type = self.LetterResultArr[indexPath.section][indexPath.row][@"type"];
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"点击内容"] = type;
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_1" withLable:@"疾病百科" withParams:tdParams];
    
    if ([type isEqualToString:@"A"]) {
        CommonDiseaseDetailViewController *commonDiseaseDetail = [[CommonDiseaseDetailViewController alloc] init];
        commonDiseaseDetail.diseaseId = self.LetterResultArr[indexPath.section][indexPath.row][@"diseaseId"];
        commonDiseaseDetail.title = self.LetterResultArr[indexPath.section][indexPath.row][@"name"];
        [self.navigationController pushViewController:commonDiseaseDetail animated:YES];
    }else{
        NSString *diseaseId = self.LetterResultArr[indexPath.section][indexPath.row][@"diseaseId"];//@"141633";//
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        vcWebDirect.showConsultBtn = YES;
        WebDiseaseDetailModel *modelDisease = [[WebDiseaseDetailModel alloc] init];
        modelDisease.diseaseId = diseaseId;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        modelLocal.modelDisease = modelDisease;
        NSString *title = [NSString stringWithFormat:@"%@详情",self.LetterResultArr[indexPath.section][indexPath.row][@"name"]];
        modelLocal.title = title;
        modelLocal.typeTitle = WebTitleTypeOnlyShare;
        modelLocal.typeLocalWeb = WebPageToWebTypeDisease;
        [vcWebDirect setWVWithLocalModel:modelLocal];
        
        
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];
    
    }
}

- (void)viewDidCurrentView
{
    if (self.dataSource.count > 1) {
        return;
    }
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        
        //read缓存
        if ([QWFileManager IsFileExists:[NSString stringWithFormat:@"%@/diseasewiki.plist",[QWFileManager GetCachePath]]]) {
            NSDictionary *subDict = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/diseasewiki.plist",[QWFileManager GetCachePath]]];
            [self httpRequestResult:subDict];
        }else
        {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
            return;
        }
        
    } else {
        [self getDataFromService];
    }
}

- (void)getDataFromService
{
    DiseaseViKiModelR *model = [DiseaseViKiModelR new];
    model.currPage = @"1";
    model.pageSize = @"0";

    [Disease queryAllDiseaseWithParams:model success:^(id obj) {
        
        //缓存数据
        NSDictionary *subDict = obj;
        [QWFileManager WriteFileDictionary:subDict SpecifiedFile:[NSString stringWithFormat:@"%@/diseasewiki.plist",[QWFileManager GetCachePath]]];
        
        [self httpRequestResult:obj];
        
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
            
        }
        return;
    }];

}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self getDataFromService];
    }
}


@end
