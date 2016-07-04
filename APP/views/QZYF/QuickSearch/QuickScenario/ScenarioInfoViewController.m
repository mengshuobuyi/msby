//
//  ScenarioInfoViewController.m
//  APP
//
//  Created by caojing on 15-3-10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ScenarioInfoViewController.h"
#import "DrugModel.h"
#import "DrugModelR.h"
#import "Drug.h"
#import "ScenarioInfoCell.h"

#define SECTION_H 50.0f
#define SECTION_LABEL_H 30.0f
@interface ScenarioInfoViewController ()
{
   
        int currentPage;
        NSInteger didSection;
        BOOL isExtend;
        float rowHeight;
   
}

@end

@implementation ScenarioInfoViewController
- (id)init{
    if (self = [super init]) {
        didSection = 0;
        isExtend = YES;
        self.regularList = [NSMutableArray array];
        self.tableMain = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H - 35) style:UITableViewStyleGrouped];
        self.tableMain.dataSource = self;
        self.tableMain.delegate = self;
        [self.tableMain addStaticImageHeader];
        [self.view addSubview:self.tableMain];
        [self.tableMain setBackgroundColor:[UIColor clearColor]];
        currentPage = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常备必知";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 分页加载
- (void)footerRereshing{
    HttpClientMgr.progressEnabled = NO;
    [self loadData];
}

-(void)viewDidCurrentView{
    [super viewDidCurrentView];
    if(self.regularList.count > 0){
        return;
    }
    currentPage = 1;
    [self.regularList removeAllObjects];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.25f];

}

#pragma mark - 数据请求
- (void)loadData{
    
    HealthyScenarioDiseaseModelR *diseaseModel = [HealthyScenarioDiseaseModelR new];
    diseaseModel.classId = [self.knowledgeDict objectForKey:@"id"];
    diseaseModel.currPage = [NSString stringWithFormat:@"%d",currentPage];
    diseaseModel.pageSize = @"15";
    
    //设置主键
    NSString * key = [NSString stringWithFormat:@"disease_%@_%@",diseaseModel.classId,diseaseModel.currPage];
    
    //未联网，取缓存数据
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
        //数据库读取功能
        HealthyScenarioListModel* page = [HealthyScenarioListModel getObjFromDBWithKey:key];
        if(page==nil){
            if(currentPage==1){
                [self showInfoView:kWarning12 image:@"网络信号icon.png"];
            }else{
                [self showError:kWarning12];
                [self.tableMain footerEndRefreshing];
            }
            
            return;
        }
        [self.regularList addObjectsFromArray:page.list];
        [self.tableMain reloadData];
        currentPage++;
        [self.tableMain footerEndRefreshing];
        
    
    }else{
        //网络正常，去请求
        [Drug queryRecommendKnowledgeWithParam:diseaseModel success:^(id UFModel) {
                
            HealthyScenarioListModel *scnearioDisease = UFModel;
            [self.regularList addObjectsFromArray:scnearioDisease.list];
                 
            //添加到本地数据库
            scnearioDisease.scenarioId = key;
            [HealthyScenarioListModel updateObjToDB:scnearioDisease WithKey:scnearioDisease.scenarioId];
                 
            if(scnearioDisease.list.count>0){
                 currentPage++;
                 [self.tableMain reloadData];
                 }else{
                  self.tableMain.footer.canLoadMore=NO;
                 }
                 [self.tableMain footerEndRefreshing];
                
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
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    HealthyScenarioDiseaseModel *scenario = self.regularList[section];

    CGSize size=[GLOBALMANAGER sizeText:[QWGLOBALMANAGER replaceSpecialStringWith: scenario.question] font:fontSystem(kFontS1) limitWidth:SCREEN_W - 24];
    
    return size.height + 24;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return [ScenarioInfoCell getCellHeight:self.regularList[indexPath.section]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.regularList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(didSection == section && isExtend)
        return 1;
    else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HealthyScenarioDiseaseModel *scenario = self.regularList[section];
    CGSize size=[GLOBALMANAGER sizeText:[QWGLOBALMANAGER replaceSpecialStringWith: scenario.question] font:fontSystem(kFontS1) limitWidth:SCREEN_W - 24];
    
    UIView * mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, size.height + 24)];
    mView.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = section;
    [button addTarget:self action:@selector(sectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = mView.frame;
    [mView addSubview:button];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, SCREEN_W - 24, size.height)];
    titleLabel.numberOfLines = 0;
    titleLabel.text = scenario.question;
    titleLabel.textColor = RGBHex(qwColor6);
    titleLabel.font = fontSystem(kFontS1);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [button addSubview:titleLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, mView.frame.size.height - 0.5, SCREEN_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [mView addSubview:line];
    
    return mView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"ScenarioInfoCell";
    ScenarioInfoCell * cell = (ScenarioInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"ScenarioInfoCell" owner:self options:nil];
        cell = nibs[0];
    }

    HealthyScenarioDiseaseModel *scenarioDisease = self.regularList[indexPath.section];
    [cell setCell:scenarioDisease];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *selection = [self.tableMain indexPathForSelectedRow];
    if (selection) {
        [self.tableMain deselectRowAtIndexPath:selection animated:YES];
    }
}


#pragma mark - Section点击展开/收起
- (void)sectionButtonClick:(UIButton *)button{
    if (didSection == button.tag) {//与上一次点击的是同一行
        if (isExtend) {   //如果现在是展开状态(那么将其收起)
            isExtend = NO;
        }
        else{  //如果现在时收起状态(那么将其展开)
            didSection = button.tag;
            isExtend = YES;
        }
    }
    else{
        didSection = button.tag;
        isExtend = YES;
    }
    [self.tableMain reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.regularList.count)] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - 断网重连点击事件
- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self loadData];
    }
}

@end
