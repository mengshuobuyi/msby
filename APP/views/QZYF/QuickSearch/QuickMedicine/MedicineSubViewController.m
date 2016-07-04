//
//  MedicineSubViewController.m
//  wenyao
//
//  Created by Meng on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MedicineSubViewController.h"
#import "MedicineSubCell.h"
#import "MedicineListViewController.h"
#import "FinderSearchViewController.h"
#import "Drug.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"


#define SECTION_H 45
#define SECTION_LABEL_H 15

@interface MedicineSubViewController ()
{
    BOOL isExtend;
    NSInteger didSection;
}
@property (nonatomic, strong) QueryProductSecondModel *querySecondModel;
@property (nonatomic, strong) DrugModel *querySecondAllModel ;
@property (nonatomic,retain)NSMutableArray *dataSource;
@property (nonatomic,retain)NSMutableArray *subDataSource;

@property (nonatomic, strong) IBOutlet UITableView               *tableMainNew;
@property (nonatomic,strong)UIImageView *imgViewArrow;


@end

@implementation MedicineSubViewController

- (id)init{
    if (self = [super init]) {
        
        didSection = 1000;
        isExtend = NO;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpRightItem];
    if (self.dataSource.count > 0) {
        return;
    }else{
        [self.dataSource removeAllObjects];
        [self loadMedicineData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.querySecondAllModel  =[DrugModel new];
    self.querySecondModel =[QueryProductSecondModel new];
    
        self.tableMainNew=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableMainNew.backgroundColor=RGBAHex(qwColor4, 1);
    self.tableMainNew.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableMainNew addStaticImageHeader];
    
    self.tableMainNew.frame = CGRectMake(0, 0, APP_W, APP_H-NAV_H);
    [ self.tableMainNew setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableMainNew.dataSource=self;
    self.tableMainNew.delegate=self;
    
    self.dataSource = [NSMutableArray array];
    self.subDataSource = [NSMutableArray array];
    
    [self.view addSubview:self.tableMainNew];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_2_fh" withLable:@"药品" withParams:nil];
}

- (void)setUpRightItem
{
    
    UIView *yhxqBarItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 55)];
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(23, 0, 55, 55)];
    [searchButton setImage:[UIImage imageNamed:@"icon_navigation_search_common"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchDown];
    [yhxqBarItems addSubview:searchButton];

    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixed.width = -20;
//    self.navigationItem.rightBarButtonItems = @[fixed,[[UIBarButtonItem alloc] initWithCustomView:yhxqBarItems]];
    fixed.width = -48;
    self.navigationItem.rightBarButtonItems = @[fixed,[[UIBarButtonItem alloc] initWithCustomView:yhxqBarItems]];


}

- (void)rightBarButtonClick{
    FinderSearchViewController * searchViewController = [[FinderSearchViewController alloc] initWithNibName:@"FinderSearchViewController" bundle:nil];
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];
}



- (void)getCachedAllMedicineTypeList:(NSString *)key
{
    //本地缓存读取功能
    DrugModel* page = [DrugModel getObjFromDBWithKey:key];
    if(page==nil){
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
        return;
    }
    self.querySecondAllModel = page;
    [self.dataSource  addObjectsFromArray:page.list];
    [self.tableMainNew reloadData];
}

- (void)loadMedicineData{
    NSString * key = [NSString stringWithFormat:@"medicineSubId_%@",self.classId];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self getCachedAllMedicineTypeList:key];
        return;
    } else {
    QueryProductSecondModelR *queryProductSecondR= [QueryProductSecondModelR new];
    queryProductSecondR.currClassId=self.classId;

    [Drug queryProductSecondWithParam:queryProductSecondR Success:^(id DFUserModel) {
         self.querySecondAllModel =  DFUserModel;
         [self.dataSource  addObjectsFromArray:self.querySecondAllModel.list];
          self.querySecondAllModel.medcineSubId = key;
         [DrugModel updateObjToDB:self.querySecondAllModel WithKey:self.querySecondAllModel.medcineSubId];
         [self.tableMainNew reloadData];
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
#pragma mark ------ section ------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.querySecondAllModel.list count]?[self.querySecondAllModel.list count]:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    
    if (didSection == section) {
        return self.subDataSource.count;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.querySecondModel = (QueryProductSecondModel*)self.querySecondAllModel.list[section];
    UIView * mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, SECTION_H - 1)];
    mView.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = section;
    [button addTarget:self action:@selector(sectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, APP_W, SECTION_H);
    [mView addSubview:button];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (SECTION_H-SECTION_LABEL_H)/2-1, 140, SECTION_LABEL_H+2)];
    
    titleLabel.text =self.querySecondModel.name;
    titleLabel.font = fontSystem(kFontS3);
    titleLabel.textColor = RGBHex(qwColor6);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [button addSubview:titleLabel];
    
    UILabel * subLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_W-60, (SECTION_H-SECTION_LABEL_H)/2, 60, SECTION_LABEL_H)];
    subLabel.textColor = RGBHex(qwColor8);
    if (self.requestType == RequestTypeMedicine) {
        NSString * str = [NSString stringWithFormat:@"%@",self.querySecondModel.size];
        if (str.length == 0) {
            str = @"0";
        }
        subLabel.text = [NSString stringWithFormat:@"%@种分类",str];
    }
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.font = fontSystem(kFontS5);
    [button addSubview:subLabel];
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, mView.frame.size.height+0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [mView addSubview:line];
    
    UIImageView *imgViewArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"展开"]];
    imgViewArrow.frame = CGRectMake(0, mView.frame.size.height-4, APP_W, 5);
    [mView addSubview:imgViewArrow];
    if (didSection == section) {
        if (isExtend) {
            imgViewArrow.hidden = NO;
        } else {
            imgViewArrow.hidden = YES;
        }
    } else {
        imgViewArrow.hidden = YES;
    }

    
    return mView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.querySecondModel = self.querySecondAllModel.list[indexPath.section];
    static NSString * cellIdentifier = @"cellIdentifier";
    MedicineSubCell * cell = (MedicineSubCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"MedicineSubCell" owner:self options:nil];
        cell = nibs[0];
        cell.contentView.backgroundColor = RGBHex(qwColor11);
    
        cell.bgImageView.backgroundColor = RGBHex(qwColor11);
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        cell.selectedBackgroundView = [[UIView alloc]init];
//        cell.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);

    }
    if (indexPath.row == 0) {

    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(cell.titleLabel.frame.origin.x, 40 - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell addSubview:line];
    QueryProductFirstModel *model =   self.querySecondModel.children[indexPath.row];
    cell.titleLabel.text = model.name;
    cell.titleLabel.font = fontSystem(kFontS1);
    cell.titleLabel.textColor = RGBHex(qwColor6);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath*    selection = [ self.tableMainNew indexPathForSelectedRow];
    if (selection) {
        [ self.tableMainNew deselectRowAtIndexPath:selection animated:YES];
    }
    self.querySecondModel = self.querySecondAllModel.list[indexPath.section];
    QueryProductFirstModel *model = self.querySecondModel.children[indexPath.row];
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"点击内容"] = model.name;
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_3" withLable:@"药品" withParams:tdParams];
    if (self.requestType == RequestTypeMedicine) {
        MedicineListViewController * medicineList = [[MedicineListViewController alloc] init];
        medicineList.isShow = 1;
        medicineList.classId = model.classId;
        [self.navigationController pushViewController:medicineList animated:YES];

    }
}

- (void)sectionButtonClick:(UIButton *)button{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
     QueryProductSecondModel* model = (QueryProductSecondModel*)self.querySecondAllModel.list[button.tag];
    tdParams[@"点击内容"] = model.name;
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_2" withLable:@"药品" withParams:tdParams];

    if (didSection == button.tag) {//与上一次点击的是同一行
        if (isExtend) {   //如果现在是展开状态(那么将其收起)
            isExtend = NO;
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.subDataSource.count; i++) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:button.tag];
                [arr addObject:indexPath];
            }
            [self.subDataSource removeAllObjects];
            [ self.tableMainNew beginUpdates];
            [ self.tableMainNew deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [ self.tableMainNew endUpdates];
            
        }else{  //如果现在时收起状态(那么将其展开)
            didSection = button.tag;
            isExtend = YES;
            [self.subDataSource removeAllObjects];
            QueryProductSecondModel *model =  self.querySecondAllModel.list[button.tag];
            [self.subDataSource addObjectsFromArray:model.children];
            
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.subDataSource.count; i++) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:button.tag];
                [arr addObject:indexPath];
            }
            [ self.tableMainNew beginUpdates];
            [ self.tableMainNew insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            [ self.tableMainNew endUpdates];
            
            [ self.tableMainNew scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:button.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }
    }else{
        //先把前一段的行全部删除后(收起),再进行新段中行的增加(展开)
        NSMutableArray * arr1 = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.subDataSource.count; i++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:didSection];
            [arr1 addObject:indexPath];
        }
        [self.subDataSource removeAllObjects];
        [ self.tableMainNew beginUpdates];
        [ self.tableMainNew deleteRowsAtIndexPaths:arr1 withRowAnimation:UITableViewRowAnimationFade];
        [ self.tableMainNew endUpdates];
        
        
        didSection = button.tag;
        isExtend = YES;
        [self.subDataSource removeAllObjects];
        QueryProductSecondModel *model =  self.querySecondAllModel.list[button.tag];
        
        [self.subDataSource addObjectsFromArray:model.children];
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        
        //新段中行的增加
        for (int i = 0; i < self.subDataSource.count; i++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:button.tag];
            [arr addObject:indexPath];
        }
        [ self.tableMainNew beginUpdates];
        [ self.tableMainNew insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [ self.tableMainNew endUpdates];
        [ self.tableMainNew scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:button.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

    [ self.tableMainNew reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.dataSource.count)] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
