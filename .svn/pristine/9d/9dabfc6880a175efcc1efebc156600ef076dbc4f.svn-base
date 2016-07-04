//
//  PromotionActivityDetailViewController.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "PromotionActivityDetailViewController.h"
#import "CouponModel.h"
#import "CouponPromotionTableViewCell.h"
#import "PromotionActivityTableViewCell.h"
#import "WebDirectViewController.h"
#import "PickPromotionSuccessViewController.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"

@interface PromotionActivityDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation PromotionActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动列表";
    
    self.dataArray = [NSMutableArray array];
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = footView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView addStaticImageHeader];
    [self.view addSubview:self.mainTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //有数据就不请求了
    if(self.dataArray.count>0){
        return;
    }
    [self newLoad];
    
}

- (void)newLoad{
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        ActivityPurchListR *modelR = [ActivityPurchListR new];
        if (mapInfoModel) {
            modelR.city = mapInfoModel.city;
        }else {
            modelR.city = @"苏州市";
        }
        modelR.proId = self.vo.proId;
        if(self.branchId){
            modelR.branchId=self.branchId;
        }
        [Activity getActivityPurchList:modelR success:^(ChannelProductVo *responModel) {
            [self.dataArray removeAllObjects];
            ChannelProductVo *channelProduct = responModel;
            self.vo=channelProduct;
            [self.dataArray addObjectsFromArray:channelProduct.promotionList];
            
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
        return 47.0;
    }else{
        return 0.1f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        
        UIView *AllView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 47.0)];
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 7.0)];
        view1.backgroundColor = RGBHex(qwColor11);
        
        CGFloat height = 0;
        NSString *title;
        
        height = 40 ;
        
        title = [NSString stringWithFormat:@"%lu个活动",(unsigned long)self.vo.promotionList.count];
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 7, APP_W, height)];
        view2.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 46.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(12, 9 + (height - 9 - 21)/2, APP_W-24, 21)];
        label.text =  title;
        label.textColor = RGBHex(qwColor8);
        label.frame = CGRectMake(12, (height - 15)/2, APP_W-24, 21);
        label.font = fontSystem(15);
        [view2 addSubview:label];
        [view2 addSubview:line];
        
        [AllView addSubview:view1];
        [AllView addSubview:view2]; 
        return AllView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return [CouponPromotionTableViewCell getCellHeight:nil];
    }else{
        return 44.0f;
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
        ChannelProductVo *vo = self.vo;
    
        [cell.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        cell.proName.text = vo.proName;
        cell.spec.text = vo.spec;
        cell.factoryName.text = vo.factoryName;
        
        [cell.label removeFromSuperview];
        [cell.gift removeFromSuperview];
        [cell.discount removeFromSuperview];
        [cell.voucher removeFromSuperview];
        [cell.special removeFromSuperview];
       
    
        return cell;
    }else{
        static NSString *Identifier = @"PromotionActivityCell";
        PromotionActivityTableViewCell *cell = (PromotionActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if(cell == nil){
            UINib *nib = [UINib nibWithNibName:@"PromotionActivityTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Identifier];
            cell = (PromotionActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [cell addSubview:line];
        
        ActivityCategoryVo *vo = self.dataArray[indexPath.row];
        
        cell.contentName.text = vo.actvityName;
        switch ([vo.activityType intValue]) {
            case 1:
            {
                [cell.imageName setImage:[UIImage imageNamed:@"img_label_gift"]];
                break;
            }
            case 2:
            {
                [cell.imageName setImage:[UIImage imageNamed:@"img_label_fold"]];
                break;
            }
            case 3:
            {
                [cell.imageName setImage:[UIImage imageNamed:@"img_label_forNow"]];
                break;
            }
            case 4:
            {
                [cell.imageName setImage:[UIImage imageNamed:@"img_label_specialOffer"]];
                break;
            }
                break; 
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 1){
        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        
        [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            
            ActivityCategoryVo *ov = self.dataArray[indexPath.row];

            if([self.sourceType isEqual:@"1"]){//优惠商品进入
                //渠道统计
                ChannerTypeModel *model=[ChannerTypeModel new];
                model.objRemark=self.vo.proName;
                model.objId=self.vo.proId;
                model.cKey=@"e_yhsp_click";
                [QWGLOBALMANAGER qwChannel:model];
            }else if ([self.sourceType isEqual:@"2"]){//自查搜索进入
                //渠道统计
                ChannerTypeModel *model=[ChannerTypeModel new];
                model.objRemark=self.vo.proName;
                model.objId=self.vo.proId;
                model.cKey=@"e_yp_css";
                [QWGLOBALMANAGER qwChannel:model];
            }
            
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = mapInfoModel;
            modelDrug.proDrugID = self.vo.proId;
            modelDrug.promotionID = [NSString stringWithFormat:@"%@",ov.pid];
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
