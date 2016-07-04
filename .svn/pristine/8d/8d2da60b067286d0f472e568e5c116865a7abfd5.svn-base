//
//  MoreConsultViewController.m
//  APP
//
//  Created by 李坚 on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MoreConsultViewController.h"
#import "myConsultTableViewCell.h"
#import "ChatViewController.h"
#import "PharmacySotreViewController.h"
#import "LoginViewController.h"

@interface MoreConsultViewController ()<UITableViewDataSource,UITableViewDelegate,myConsultTableViewCellDelegate>{
    
    NSString *telephoneNumber;
    NSInteger currentPage;
}

@property (strong, nonatomic) UITableView *mainTableView;

@end

@implementation MoreConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"适用药房";
    currentPage = 1;
    if(self.dataArray == nil){
        self.dataArray = [NSMutableArray new];
    }
    
    CGRect rect = self.view.frame;
    rect.size.height -= (NAV_H + STATUS_H);
    
    self.mainTableView = [[UITableView alloc]initWithFrame:rect];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.mainTableView];
    
//    [self.mainTableView addFooterWithTarget:self action:@selector(reFreshNewData)];
    
    
    if(self.consultType == Enum_Consult_ComeFromUserCenterQuan){
        [self loadQuanConsultData];
    }

    if(self.consultType == Enum_Consult_ComeFromUserCenterPromotion){
        [self loadDrugConsultData];
    }
}

- (void)reFreshNewData{
    
    if(self.consultType == Enum_Consult_ComeFromUserCenterQuan){
        
        currentPage += 1;
        [self loadQuanConsultData];
    }
    if(self.consultType == Enum_Consult_ComeFromUserCenterPromotion){
        
        currentPage += 1;
        [self loadDrugConsultData];
    }
}

#pragma mark - 我的优惠券详情进入HTTPRequest，需要couponId和groupId字段
- (void)loadQuanConsultData{
    
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        CouponBranchSuitableModelR *modelR = [CouponBranchSuitableModelR new];
        
        modelR.couponId = self.couponDetail.couponId;
        modelR.groupId = self.couponDetail.groupId;
        
        if(mapInfoModel == nil){
            modelR.longitude = @"120.730435";
            modelR.latitude = @"31.273391";
            modelR.city = @"苏州";
        }else{
            modelR.longitude = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.longitude];
            modelR.latitude = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.latitude];
            modelR.city = mapInfoModel.city;
        }
        modelR.view = @"0";
        
        [Coupon couponBranchSuitable:modelR success:^(CouponBranchVoListModel *obj) {
       
    
            [self.dataArray addObjectsFromArray:obj.suitableBranchs];
            
        
            [self.mainTableView reloadData];
            
        } failure:^(HttpException *e) {
            
        }];
    }];
}


#pragma mark - 我的优惠商品详情进入HTTPRequest，需要pid(promotionId)字段
- (void)loadDrugConsultData{
    
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        drugBranchModelR *modelR = [drugBranchModelR new];
        modelR.pid = self.pid;
        
        if(mapInfoModel == nil){
            modelR.longitude = @(120.730435);
            modelR.latitude = @(31.273391);
            modelR.city = @"苏州";
        }else{
            modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
            modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
            modelR.city = mapInfoModel.city;
        }
        
        [Coupon promotionDrugBranch:modelR success:^(id obj) {
            
            BranchListVo *couponList = obj;
            
            self.dataArray =[NSMutableArray arrayWithArray:couponList.branchVoList];
            [self.mainTableView reloadData];
            
        } failure:^(HttpException *e) {
            
            
        }];
        
        
    }];
}




#pragma mark - 打电话按钮点击事件
- (void)takePhone:(NSString *)telNumber{
    
    //if(telNumber == nil || [telNumber isEqualToString:@""]){
    if (StrIsEmpty(telNumber)) {
    
        return;
    }
    
    telephoneNumber = telNumber;
    //if(telNumber && ![telNumber isEqualToString:@""]){
    if(!StrIsEmpty(telNumber)){
        [[[UIAlertView alloc]initWithTitle:@"呼叫" message:telNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

#pragma mark - 聊天按钮点击事件
- (void)takeTalk:(NSString *)branchId name:(NSString *)branchName{
    
    if(!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        return;
    }
    
   // if(branchId == nil || [branchId isEqualToString:@""]){
    if(StrIsEmpty(branchId)){
        return;
    }
    
    ChatViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ChatViewController"];
    //        PTPWeChatMessageTableViewController *consultViewController=[[PTPWeChatMessageTableViewController alloc] init];
    consultViewController.sendConsultType = Enum_SendConsult_Common;
    consultViewController.branchId = branchId;
 
    for(BranchVo *model in self.dataArray){
        if(model.branchId == branchId){
            consultViewController.branchName = model.branchName
            ;
            break;
        }
    }
    
    [self.navigationController pushViewController:consultViewController animated:YES];
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telephoneNumber]]];
    }
}


#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [myConsultTableViewCell getCellHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Identifier = @"myConsultTableViewCell";
    myConsultTableViewCell *cell = (myConsultTableViewCell *)[self.tableMain dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"myConsultTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Identifier];
        cell = (myConsultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell addSubview:line];
    cell.cellDelegate = self;
    
    if(self.consultType == Enum_Consult_ComeFromUserCenterPromotion){
        BranchVo *model = self.dataArray[indexPath.row];
        
        cell.branchName.text = model.branchName;
        cell.address.text = model.address;
        cell.distance.text = model.distance;
        
        float star = [model.star floatValue] / 2.0;
        
        [cell.starView displayRating:star];
        
        if([model.online intValue] == 1){
            cell.branchId = model.branchId;
        }else{
            cell.branchId = @"";
        }
        cell.telNumber = model.tel;
        if ([model.online intValue] == 0) {
            cell.chatEnable = NO;
            cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisorygray"];
        }else{
            cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisory"];
            cell.chatEnable = YES;
        }
        
        
    }else{
        CouponBranchVoModel *model = self.dataArray[indexPath.row];
        cell.branchName.text = model.branchName;
        cell.address.text = model.address;
        cell.distance.text = model.distance;
        
        float star = [model.stars floatValue] / 2.0;
        
        [cell.starView displayRating:star];
        
        if([model.online intValue] == 1){
            cell.branchId = model.branchId;
        }else{
            cell.branchId = @"";
        }
        cell.telNumber = model.contact;
        if ([model.online intValue] == 0) {
            cell.chatEnable = NO;
            cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisorygray"];
        }else{
            cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisory"];
            cell.chatEnable = YES;
        }
    }
    
    //if(cell.telNumber == nil || [cell.telNumber isEqualToString:@""]){
    if(StrIsEmpty(cell.telNumber)){
        cell.phoneImage.image = [UIImage imageNamed:@"btn_img_phonegray.png"];
    }else{
        cell.phoneImage.image = [UIImage imageNamed:@"btn_img_phone.png"];
    }
   // if (cell.branchId == nil || [cell.branchId isEqualToString:@""]) {
    if(StrIsEmpty(cell.branchId)){
        cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisorygray"];
    }else{
        cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisory"];
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //进入药房详情
    if(self.consultType == Enum_Consult_ComeFromUserCenterPromotion){
        BranchVo *model = self.dataArray[indexPath.row];

        PharmacySotreViewController *VC = [[PharmacySotreViewController alloc]init];
        VC.branchId = model.branchId;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        CouponBranchVoModel *model = self.dataArray[indexPath.row];
        
        PharmacySotreViewController *VC = [[PharmacySotreViewController alloc]init];
        VC.branchId = model.branchId;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


@end
