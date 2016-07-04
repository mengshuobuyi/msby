        //
//  CouponDrugListViewController.m
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyCouponDrugListViewController.h"
#import "Coupon.h"
#import "SVProgressHUD.h"
#import "CouponMyDrugTableViewCell.h"
#import "MyCouponDrugDetailViewController.h"

@interface MyCouponDrugListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    int currPage;
}

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyCouponDrugListViewController

- (instancetype)init{
    
    if(self = [super init]){
        currPage = 1;
        self.dataArray = [NSMutableArray new];
        
        self.mainTableView = [[UITableView alloc]initWithFrame:self.view.frame];
        self.mainTableView.dataSource = self;
        self.mainTableView.delegate = self;
        self.mainTableView.tableFooterView = [[UIView alloc]init];
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 14.5)];
        self.mainTableView.tableHeaderView = header;
        
        [self.view addSubview:self.mainTableView];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)footRefresh{
    
    currPage +=1;
    [self loadCouponDrugData];
}

- (void)restData{
    
    currPage =1;
    [self loadCouponDrugData];
}

- (void)loadCouponDrugData{
    
    myCouponDrugModelR *modelR = [myCouponDrugModelR new];
    if(self.type == Enum_CouponQuan_HasPicked){
        modelR.status = @1;
    }
    if(self.type == Enum_CouponQuan_HasUsed){
        modelR.status = @2;
    }
    if(self.type == Enum_CouponQuan_HasOverdDate){
        modelR.status = @3;
    }
    modelR.page = @(currPage);
    modelR.pageSize = @10;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    
    [Coupon myCouponDrug:modelR success:^(id obj) {
        
        MyDrugVoList *couponList = obj;
        
        if(couponList.list == nil || couponList.list.count == 0){
            
            [self showInfoView:@"没有券了" image:nil];
        }else{
            [self.dataArray addObjectsFromArray:couponList.list];
            [self.mainTableView reloadData];
        }
        
        
        
    } failure:^(HttpException *e) {
        
        [SVProgressHUD showErrorWithStatus:e.Edescription];
        
    }];
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CouponMyDrugTableViewCell getCellHeight:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Identifier = @"CouponMyDrugTableViewCell";
    CouponMyDrugTableViewCell *cell = (CouponMyDrugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"CouponMyDrugTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Identifier];
        cell = (CouponMyDrugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    }
    
    MyDrugVo *model = self.dataArray[indexPath.row];
    
    if(self.type == Enum_CouponQuan_HasPicked){
        cell.drugStatus = 0;
    }
    if(self.type == Enum_CouponQuan_HasUsed){
        cell.drugStatus = 1;
    }
    if(self.type == Enum_CouponQuan_HasOverdDate){
        cell.drugStatus = 2;
    }
    [cell setCell:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCouponDrugDetailViewController *drugDetail = [[MyCouponDrugDetailViewController alloc]init];
    MyDrugVo *model = self.dataArray[indexPath.row];
    drugDetail.status = self.type + 1;
    drugDetail.drug = model;
    [self.navigationController pushViewController:drugDetail animated:YES];
}

@end
