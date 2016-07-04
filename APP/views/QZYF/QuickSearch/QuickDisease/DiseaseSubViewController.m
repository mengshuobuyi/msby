//
//  DiseaseSubViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DiseaseSubViewController.h"
#import "DiseaseSubCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "DiseaseModelR.h"
#import "Disease.h"
#import "WebDirectViewController.h"


#define SECTION_H 45
#define SECTION_LABEL_H 15

@interface DiseaseSubViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    BOOL isExtend;
    NSInteger didSection;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *dataSource;
@property (nonatomic,retain)NSMutableArray *subDataSource;

@end

@implementation DiseaseSubViewController

- (id)init{
    if (self = [super init]) {
        self.title = @"常见疾病";
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [self.tableView setTableFooterView:view];
        self.tableView.frame = CGRectMake(0, 0, APP_W, APP_H-NAV_H-35.0f);
        self.dataSource = [NSMutableArray array];
        self.subDataSource = [NSMutableArray array];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        didSection = 1000;
        isExtend = NO;
    }
    return self;
}

#pragma mark  =====缓存

- (void)queryAllDisease
{
    self.dataSource = (NSMutableArray *)[DiseaseClassModel getArrayFromDBWithWhere:nil];
    [self.tableView reloadData];
}

 
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.dataSource.count > 0) {
        return;
    }else{
        [self.dataSource removeAllObjects];
        [self loadDiseaseData];
    }
}


#pragma mark ------ section ------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DiseaseSubCell getCellHeight:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (didSection == section) {
        return self.subDataSource.count;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DiseaseClassListModel *listModel = self.dataSource[section];
    
    UIView * mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, SECTION_H - 1)];
    mView.backgroundColor = [UIColor whiteColor];
    //添加Button
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = section;
    [button addTarget:self action:@selector(sectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, APP_W, SECTION_H);
    [mView addSubview:button];
    //添加标题Label
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (SECTION_H-SECTION_LABEL_H)/2-1, 140, SECTION_LABEL_H+2)];

    titleLabel.text = listModel.name;
    titleLabel.font = fontSystem(kFontS3);
    titleLabel.textColor = RGBHex(qwColor6);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [button addSubview:titleLabel];
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, mView.frame.size.height+0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [mView addSubview:line];
    
    //展开image图标定义
    UIImageView *imageViewArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"展开"]];
    imageViewArrow.frame = CGRectMake(0, mView.frame.size.height - 4, APP_W, 5);
    [mView addSubview:imageViewArrow];
    
    
    if(didSection == section){
        if(isExtend){
            //只有当有section被点击且是展开的时候，显示image
            imageViewArrow.hidden = NO;
        }
        else{
            imageViewArrow.hidden = YES;
        }
    }
    else{
        imageViewArrow.hidden = YES;
    }
    
    return mView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"DiseaseSubCell";
    DiseaseSubCell * cell = (DiseaseSubCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"DiseaseSubCell" owner:self options:nil];
        cell = [nibs firstObject];
    }
    DiseaseSubClassModel *model = self.subDataSource[indexPath.row];
    [cell setCell:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
    DiseaseSubClassModel *model = self.subDataSource[indexPath.row];
    
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebDirect.showConsultBtn = YES;
    
    WebDiseaseDetailModel *modelDisease = [[WebDiseaseDetailModel alloc] init];
    modelDisease.diseaseId = model.diseaseId;
    
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.modelDisease = modelDisease;
    modelLocal.title = model.name;
    modelLocal.typeLocalWeb = WebPageToWebTypeDisease;
    [vcWebDirect setWVWithLocalModel:modelLocal];

    
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

- (void)sectionButtonClick:(UIButton *)button{
    if (didSection == button.tag) {//与上一次点击的是同一行
        if (isExtend) {   //如果现在是展开状态(那么将其收起)
            isExtend = NO;
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.subDataSource.count; i++) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:button.tag];
                [arr addObject:indexPath];
            }
            [self.subDataSource removeAllObjects];
            [SVProgressHUD dismiss];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }else{  //如果现在时收起状态(那么将其展开)
            didSection = button.tag;
            isExtend = YES;
            [self.subDataSource removeAllObjects];
            DiseaseClassListModel *listModel = self.dataSource[button.tag];
            [self.subDataSource addObjectsFromArray:listModel.subClass];
            if (self.subDataSource.count == 0) {
                [self showInfoView:@"暂无数据" image:nil];
                return;
            }
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.subDataSource.count; i++) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:button.tag];
                [arr addObject:indexPath];
            }
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:button.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }else{
        //先把前一段的行全部删除后(收起),再进行新段中行的增加(展开)
        NSMutableArray * arr1 = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.subDataSource.count; i++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:didSection];
            [arr1 addObject:indexPath];
        }
        [self.subDataSource removeAllObjects];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:arr1 withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        
        didSection = button.tag;
        isExtend = YES;
        DiseaseClassListModel *listModel = self.dataSource[button.tag];
        [self.subDataSource addObjectsFromArray:listModel.subClass];
        if (self.subDataSource.count == 0) {
             [self showInfoView:@"暂无数据" image:nil];
             return;
        }
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        
        //新段中行的增加
        for (int i = 0; i < self.subDataSource.count; i++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:button.tag];
            [arr addObject:indexPath];
        }
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:button.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.dataSource.count)] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)viewDidCurrentView{
    if (self.dataSource.count > 0) {
        return;
    }else{
        [self.dataSource removeAllObjects];
        [self loadDiseaseData];
    }
}

- (IBAction)viewInfoClickAction:(id)sender{
    [self removeInfoView];
    [self loadDiseaseData];
}

//数据请求
- (void)loadDiseaseData{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        
        [self queryAllDisease];
        if(!self.dataSource.count > 0){
            [self showInfoView:kWarning12 image:@"网络信号icon"];
            return;
        }
        
    } else {
        
        [self removeInfoView];
        DiseaseClassModelR *model = [DiseaseClassModelR new];
        model.currPage = @"1";
        model.pageSize = @"0";//不需要分页
        
        [Disease queryDiseaseClassWithParams:model success:^(id obj) {
            
            DiseaseClassModel *classModel = (DiseaseClassModel *)obj;
            
            NSArray * arr = classModel.list;
            for (DiseaseClassListModel *listModel in arr) {
                [self.dataSource addObject:listModel];
            }
            [self.tableView reloadData];

            //缓存数据
            [DiseaseClassModel saveObjToDBWithArray:classModel.list];
            
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




@end
