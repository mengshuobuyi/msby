//
//  SearchDisease+SymptomListViewController.m
//  wenyao
//
//  Created by Meng on 14/12/2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "SearchDisease_SymptomListViewController.h"
#import "Disease.h"
#import "SpmApi.h"
#import "CommonDiseaseDetailViewController.h"
#import "WebDirectViewController.h"

@interface SearchDisease_SymptomListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_nodataView;
}
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation SearchDisease_SymptomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
}

- (void)setKwId:(NSString *)kwId
{
    _kwId = kwId;
    DiseasekwidR *kwid=[DiseasekwidR new];
    kwid.kwId=kwId;
    kwid.type = @"1";
    kwid.currPage=[NSString stringWithFormat:@"%i",1];
    kwid.pageSize=[NSString stringWithFormat:@"%i",1000];
    DiseaseSpmbykwidR *spmkwid=[DiseaseSpmbykwidR new];
    spmkwid.kwId=kwId;
    spmkwid.type = @"1";
    spmkwid.currPage=[NSString stringWithFormat:@"%i",1];
    spmkwid.pageSize=[NSString stringWithFormat:@"%i",1000];
    if (self.requsetType == RequsetTypeDisease) {
        [Disease queryDiseasekwIdWithParam:kwid success:^(id resultObj) {
            Diseasekwid *kwids=resultObj;
            [self.dataSource removeAllObjects];
            for (Diseaseclasskwid *kwidclass in kwids.list) {
                [self.dataSource addObject:kwidclass];
            }
                            if (self.dataSource.count > 0) {
                                [self.tableView reloadData];
                            }else
                            {
                                [self showInfoView:@"暂无数据" image:nil];
                            }
            
                    } failure:^(HttpException *error) {

                    }];
                } else if (self.requsetType == RequsetTypeSymptom){
                    [SpmApi querySearchSpmkwidWithParam:spmkwid success:^(id resultObj) {
                        SpmListPage *spmkwids=resultObj;
                        
                        [self.dataSource removeAllObjects];
                        for (SpmSearchId *spmclass in spmkwids.list) {
                            [self.dataSource addObject:spmclass];
                        }
                        
                                        if (self.dataSource.count > 0) {
                                            [self.tableView reloadData];
                                        }else{
                                            [self showInfoView:@"暂无数据" image:nil];

                                        }
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //searchdiseasespm
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, APP_W, 0.5)];
    line.backgroundColor =RGBHex(qwColor10);
    [cell addSubview:line];
    if ([self.dataSource[indexPath.row] isKindOfClass:[Diseaseclasskwid class]]) {
        Diseaseclasskwid *diseasek=self.dataSource[indexPath.row];
        cell.textLabel.text=diseasek.name;
    }else if ([self.dataSource[indexPath.row] isKindOfClass:[SpmSearchId class]]){
        SpmSearchId *spm=self.dataSource[indexPath.row];
        cell.textLabel.text= spm.name;
    }
  
    cell.textLabel.font =font(kFont1, kFontS1);
    cell.textLabel.textColor =RGBHex(qwColor6);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.requsetType == RequsetTypeDisease) {
        
        Diseaseclasskwid *classkwd=self.dataSource[indexPath.row];
        NSString *type = classkwd.type;
        if ([type isEqualToString:@"A"]) {

            CommonDiseaseDetailViewController *commonDiseaseDetail = [[CommonDiseaseDetailViewController alloc] init];
            commonDiseaseDetail.diseaseId = classkwd.diseaseId;
            commonDiseaseDetail.title = classkwd.name;
            [self.navigationController pushViewController:commonDiseaseDetail animated:YES];
        }else{
            WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            vcWebDirect.showConsultBtn = YES;
            WebDiseaseDetailModel *modelDisease = [[WebDiseaseDetailModel alloc] init];
            modelDisease.diseaseId = classkwd.diseaseId;
            
            WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
            modelLocal.modelDisease = modelDisease;
            modelLocal.title = classkwd.name;
            modelLocal.typeTitle = WebTitleTypeOnlyShare;
            modelLocal.typeLocalWeb = WebPageToWebTypeDisease;
            [vcWebDirect setWVWithLocalModel:modelLocal];
            vcWebDirect.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vcWebDirect animated:YES];
        }
    }else if (self.requsetType == RequsetTypeSymptom){
        SpmSearchId *spmclass=self.dataSource[indexPath.row];
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        NSString *strToken = @"";
        if (QWGLOBALMANAGER.configure.userToken.length > 0) {
            strToken = QWGLOBALMANAGER.configure.userToken;
        }
        NSString *url = [NSString stringWithFormat:@"%@/symptom.html?id=%@&token=%@",HTML5_DIRECT_URL,spmclass.spmCode,strToken];
        vcWebDirect.showConsultBtn = YES;
        WebSymptomDetailModel *modelSymptom = [[WebSymptomDetailModel alloc] init];
        modelSymptom.symptomId = spmclass.spmCode;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        modelLocal.modelSymptom = modelSymptom;
        modelLocal.typeLocalWeb = WebPageToWebTypeSympton;
        modelLocal.title = spmclass.name;
        [vcWebDirect setWVWithLocalModel:modelLocal];

        
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
