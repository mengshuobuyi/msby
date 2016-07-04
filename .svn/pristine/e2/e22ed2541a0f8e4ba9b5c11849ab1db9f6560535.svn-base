//
//  PromotionDrugDetailViewController.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "PromotionDrugDetailViewController.h"
#import "CouponModel.h"
#import "CouponPromotionTableViewCell.h"
#import "PromotionBranchTableViewCell.h"
#import "WebDirectViewController.h"
#import "PickPromotionSuccessViewController.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"

@interface PromotionDrugDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation PromotionDrugDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"优惠商品";
    
    self.dataArray = [NSMutableArray array];
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = footView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.mainTableView];
    [self loadData];
}

#pragma mark - 请求
- (void)loadData{
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        PromotionGroupModelR *modelR = [PromotionGroupModelR new];
        modelR.proId = self.vo.proId;
        
        if(mapInfoModel){
            modelR.city = mapInfoModel.city;
            modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
            modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
        }else{
            modelR.city = @"苏州市";
            modelR.longitude = @(120.730435);
            modelR.latitude = @(31.273391);
        }
        
        
        [Promotion queryPromotionGroupWithParams:modelR success:^(id obj) {
            
            GroupVoList *vo = obj;
            self.vo.imgUrl = vo.imgUrl;
            self.vo.spec = vo.spec;
            self.vo.proName = vo.proName;
            self.vo.factoryname = vo.factoryName;
            [self.dataArray addObjectsFromArray:vo.groupVoList];
            
            [self.mainTableView reloadData];
            
        } failure:^(HttpException *e) {
            
            
        }];
    }];
}


#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        return 7.0;
    }else{
        return 0.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 7.0)];
        view.backgroundColor = RGBHex(qwColor11);
        return view;
    }else{
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return [CouponPromotionTableViewCell getCellHeight:nil];
    }else{
        return 61.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        static NSString *Identifier = @"CouponPromotionTableViewCell";
        CouponPromotionTableViewCell *cell = (CouponPromotionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if(cell == nil){
            UINib *nib = [UINib nibWithNibName:@"CouponPromotionTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Identifier];
            cell = (CouponPromotionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        }
        DrugVo *vo = self.vo;
    
        [cell.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        cell.proName.text = vo.proName;
        cell.spec.text = vo.spec;
        cell.factoryName.text = vo.factoryname;
        
        [cell.label removeFromSuperview];
        [cell.gift removeFromSuperview];
        [cell.discount removeFromSuperview];
        [cell.voucher removeFromSuperview];
        [cell.special removeFromSuperview];
       
    
        return cell;
    }else{
        static NSString *Identifier = @"PromotionBranchTableViewCell";
        PromotionBranchTableViewCell *cell = (PromotionBranchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if(cell == nil){
            UINib *nib = [UINib nibWithNibName:@"PromotionBranchTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Identifier];
            cell = (PromotionBranchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [cell addSubview:line];
        
        GroupVo *vo = self.dataArray[indexPath.row];
        
        cell.branchName.text = vo.branchName;
        cell.branchCount.text = [NSString stringWithFormat:@"%d家药房通用",[vo.branchCount intValue]];
        cell.label.text = vo.label;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 1){
        
        GroupVo *group = self.dataArray[indexPath.row];
        
        if(self.vo.proName && group.label){
        
           // if(self.vo.beginDate && ![self.vo.beginDate isEqualToString:@""] && self.vo.endDate && ![self.vo.endDate isEqualToString:@""]){
//            if(!StrIsEmpty(self.vo.beginDate) && !StrIsEmpty(self.vo.endDate)){
//                model.params = @{@"优惠商品分类":self.vo.proName,@"优惠商品内容":self.vo.label,@"有效期":[NSString stringWithFormat:@"%@-%@",self.vo.beginDate,self.vo.endDate]};
//            }else{
//                model.params = @{@"优惠商品分类":self.vo.proName,@"优惠商品内容":group.label};
//            }
        }
//
        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];

        [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = mapInfoModel;
            modelDrug.proDrugID = self.vo.proId;
            modelDrug.promotionID = group.pid;
//            modelDrug.showDrug = @"0";
            WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//            modelLocal.title = @"优惠商品";
            modelLocal.modelDrug = modelDrug;
            modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            [self.navigationController pushViewController:vcWebMedicine animated:YES];
            
        }];
        
    }else{
 
    }
}



@end
