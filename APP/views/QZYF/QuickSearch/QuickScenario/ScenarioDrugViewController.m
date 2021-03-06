//
//  ScenarioDrugViewController.m
//  APP
//
//  Created by caojing on 15-3-10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ScenarioDrugViewController.h"
#import "ScenarioDrugCell.h"
#import "DrugModel.h"
#import "DrugModelR.h"
#import "Drug.h"
#import "MedicineListViewController.h"
#import "MJRefresh.h"
 
#import "SVProgressHUD.h"

@interface ScenarioDrugViewController ()
{
    NSInteger currentPage;
}
@property (nonatomic, strong) NSMutableArray        *regularList;
@end

@implementation ScenarioDrugViewController
- (id)init{
    if (self = [super init]) {
        self.tableMain = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H - 35) style:UITableViewStylePlain];
        self.tableMain.delegate=self;
        self.tableMain.dataSource=self;
        [self.tableMain addStaticImageHeader];
        [self.view addSubview:self.tableMain];
        [self.tableMain setBackgroundColor:[UIColor clearColor]];
        self.regularList = [[NSMutableArray alloc]init];
        currentPage = 1;
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常备药品";
}

-(void)viewDidCurrentView{
    
    if(self.regularList.count > 0){
        return;
    }else{
        currentPage = 1;
        [self.regularList removeAllObjects];
        [self loadData];
    }
}

- (void)loadData
{
    
    HealthyScenarioModelR *model = [HealthyScenarioModelR new];
    model.currClassId = [self.drugDict objectForKey:@"id"];
    model.currPage = [NSString stringWithFormat:@"%ld",(long)currentPage];;
    model.pageSize = [NSString stringWithFormat:@"%d",PAGE_ROW_NUM];
    
    
    //设置主键
    NSString * key = [NSString stringWithFormat:@"drugs_%@_%@",model.currClassId,model.currPage];
    
    if(QWGLOBALMANAGER.currentNetWork==kNotReachable){
        
        //数据库读取功能
        
        HealthyScenarioListModel* page = [HealthyScenarioListModel getObjFromDBWithKey:key];
        
//        self.tableMain.footer.canLoadMore=[self checkTotal:page.totalRecords.integerValue pageSize:page.pageSize.integerValue pageNum:page.page.integerValue];
        
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
        
        [Drug queryRecommendClassWithParam:model success:^(id UFModel) {
            HealthyScenarioListModel *scneario = UFModel;
            
//            self.tableMain.footer.canLoadMore=[self checkTotal:scneario.totalRecords.integerValue pageSize:scneario.pageSize.integerValue pageNum:scneario.page.integerValue];
            
            [self.regularList addObjectsFromArray:scneario.list];
            
            //添加到本地数据库
            scneario.scenarioId = key;
            [HealthyScenarioListModel updateObjToDB:scneario WithKey:scneario.scenarioId];
            
            if(scneario.list.count>0){
            [self.tableMain reloadData];
            currentPage++;
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


- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self loadData];
    }
}

- (void)footerRereshing
{
    HttpClientMgr.progressEnabled = NO;
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ScenarioDrugCell getCellHeight:nil];
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [self.regularList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ScenarioDrugCellIdentifier = @"ScenarioDrugCell";
    ScenarioDrugCell *cell = (ScenarioDrugCell *)[tableView dequeueReusableCellWithIdentifier:ScenarioDrugCellIdentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"ScenarioDrugCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ScenarioDrugCellIdentifier];
        cell = (ScenarioDrugCell *)[tableView dequeueReusableCellWithIdentifier:ScenarioDrugCellIdentifier];
        
       
    }
    
    HealthyScenarioModel *scenario = self.regularList[indexPath.row];
    [cell setDrugCell:scenario row:(NSInteger)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MedicineListViewController *drugListViewController = [[MedicineListViewController alloc] init];
    HealthyScenarioModel *scenario = self.regularList[indexPath.row];
    drugListViewController.className = @"SubRegularDrugsViewController";
    drugListViewController.classId = scenario.id;
    [self.navigationController pushViewController:drugListViewController animated:YES];
    
}

@end
