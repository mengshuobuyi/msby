//
//  ScanDrugViewController.m
//  quanzhi
//
//  Created by xiezhenghong on 14-6-17.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "ScanDrugViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "ScanDrugTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "css.h"
#import "QWGlobalManager.h"
#import "WebDirectViewController.h"
#import "PromotionActivityDetailViewController.h"

@interface ScanDrugViewController ()

@end

@implementation ScanDrugViewController
@synthesize tableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品列表";
    if(self.drugList.count == 0){
        [self showInfoView:@"抱歉，没有为您找到相关商品" image:@"ic_img_fail"];
        return;
    }
    
    [self setupTableView];
    
    
    if (!QWGLOBALMANAGER.loginStatus) {
        if (self.userType == 2) {
            [SVProgressHUD showErrorWithStatus:kWarning2 duration:0.8];
        }
    }
    
    
}

- (void)popVCAction:(id)sender
{
    if (self.userType == Enum_Scan_Items_Normal) {
        if (self.delegatePopVC) {
//            DebugLog(@"kao %@ %@",self.navigationController.viewControllers,self.delegatePopVC);
            [self.navigationController popToViewController:self.delegatePopVC animated:YES];
//            DebugLog(@"OK");
            return;
        }
    }
    [super popVCAction:sender];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.separatorColor = RGBHex(qwColor9);
    [self.tableView setBackgroundColor:RGBHex(qwColor11)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
}

#pragma mark -
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [self.drugList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ScanDrugIdentifier = @"ScanDrugCellIdentifier";
    ScanDrugTableViewCell *cell = (ScanDrugTableViewCell *)[atableView dequeueReusableCellWithIdentifier:ScanDrugIdentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"ScanDrugTableViewCell" bundle:nil];
        [atableView registerNib:nib forCellReuseIdentifier:ScanDrugIdentifier];
        cell = (ScanDrugTableViewCell *)[atableView dequeueReusableCellWithIdentifier:ScanDrugIdentifier];
    }
    ProductModel* product = self.drugList[indexPath.row];
    [cell setCell:product];
    if(self.userType == Enum_Scan_Froms_Normal){
        cell.addLabel.hidden = YES;
    }
    if(!product.gift) {
        [cell.giftLabel removeFromSuperview];
    }
    if(!product.discount) {
        [cell.foldLabel removeFromSuperview];
    }
    if(!product.voucher) {
        [cell.pledgeLabel removeFromSuperview];
    }
    if(!product.special) {
        [cell.specialLabel removeFromSuperview];
    }
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductModel* product = self.drugList[indexPath.row];
    if(self.userType == Enum_Scan_Froms_Preferential){
        if(self.completionBolck)
            self.completionBolck(product);
        NSUInteger count = self.navigationController.viewControllers.count - 1;
        UIViewController *viewController = self.navigationController.viewControllers[count - 2];
        [self.navigationController popToViewController:viewController animated:YES];
    }else{
        if(!product.proId){
            [SVProgressHUD showErrorWithStatus:kWarning3 duration:0.8f];
        }
        [self pushToDrugDetailWithDrug:product];
    }
}

- (void)pushToDrugDetailWithDrug:(ProductModel *)product{
    
    
            if([product.multiPromotion intValue] == 1){
                
                //跳转到新的活动列表
                PromotionActivityDetailViewController *drugDetail = [[PromotionActivityDetailViewController alloc]init];
                drugDetail.vo = product;
                [self.navigationController pushViewController:drugDetail animated:YES];
            }else{
                [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) { //add by jxb
                    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
                    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
                    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
                    modelDrug.modelMap = modelMap;
                    modelDrug.proDrugID = product.proId;
                    modelDrug.promotionID = product.promotionId;
                    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
                    modelLocal.modelDrug = modelDrug;
                    [vcWebMedicine setWVWithLocalModel:modelLocal];
                    [self.navigationController pushViewController:vcWebMedicine animated:YES];
                }];
            }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end