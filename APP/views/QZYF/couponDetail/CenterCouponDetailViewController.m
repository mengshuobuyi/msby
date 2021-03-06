//
//  CenterCouponDetailViewController
//  APP
//  优惠券详情  领券中心
//  Created by caojing on 11/10/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "CenterCouponDetailViewController.h"
#import "VFourCouponQuanTableViewCell.h"
#import "SVProgressHUD.h"
#import "WebDirectViewController.h"
#import "SuitableDrugViewController.h"
#import "swiftModule-swift.h"
#import "PromotionCustomAlertView.h"
#import "CouponTicketDetailPlaceholderCell.h"
#import "CouponDetailCell.h"
#import "CouponConditionLabel.h"
#import "MallCouponSuccessViewController.h"
#import "CouponSuitableTableViewCell.h"
#import "PickAlertView.h"
#import "BranchCouponDetailView.h"
#import "AppDelegate.h"
#import "CouponUseViewController.h"
#import "CouponBranchChooseViewController.h"
#import "PharmacySotreViewController.h"
#import "MedicineSearchResultViewController.h"
#import "MedicineDetailViewController.h"
#import "ChangeProductAlertView.h"

static NSString * const CouponQuanTableViewCellIdentifier = @"VFourCouponQuanTableViewCell";
static NSString * const CouponTicketDetailPlaceholderCellIdentifier = @"CouponTicketDetailPlaceholderCell";
static NSString * const CouponDetailCellIdentifier = @"CouponDetailCell";
static NSString * const UITableViewIdentifier = @"UITableViewCell";
static CGFloat heightPlaceHolder = 54.0f;

@interface CenterCouponDetailViewController () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCoupon;//领取优惠的按钮
@property (weak, nonatomic) IBOutlet UILabel  *lblRemainCount;//还可领的次数
@property (weak, nonatomic) IBOutlet UIButton *btnGetPharmcy;//其他可用药房
@property (weak, nonatomic) IBOutlet UILabel  *lblDesc;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet UIView *viewFooter;


@property (nonatomic, strong) NSMutableArray *arrProducts;//适用商品
@property (nonatomic, strong) NSMutableArray *arrPharmcys;//适用药房
@property (nonatomic, strong) NSMutableArray *arrCouponDetails;//优惠细则
@property (nonatomic, assign) NSInteger curProductPage;//适用商品的分页
@property (nonatomic, strong) OnlineCouponDetailVo *couponDetail;



- (IBAction)pickTicket:(UIButton *)sender;
- (IBAction)otherPharmcy:(id)sender;

@end

@implementation CenterCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券详情";
    self.arrProducts = [@[] mutableCopy];
    self.arrCouponDetails = [@[] mutableCopy];
    self.arrPharmcys = [@[] mutableCopy];
    
    //设置底部的按钮
    self.viewFooter.backgroundColor = RGBHex(qwColor11);
    self.lblDesc.hidden=YES;
    self.lblRemainCount.hidden=YES;
    self.btnGetPharmcy.hidden=YES;
    self.btnGetCoupon.hidden=YES;
    self.btnGetPharmcy.layer.masksToBounds=YES;
    self.btnGetPharmcy.layer.cornerRadius=4.0f;
    self.btnGetCoupon.layer.masksToBounds=YES;
    self.btnGetCoupon.layer.cornerRadius=4.0f;
    
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"VFourCouponQuanTableViewCell" bundle:nil] forCellReuseIdentifier:CouponQuanTableViewCellIdentifier];
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"CouponTicketDetailPlaceholderCell" bundle:nil] forCellReuseIdentifier:CouponTicketDetailPlaceholderCellIdentifier];
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"CouponDetailCell" bundle:nil] forCellReuseIdentifier:CouponDetailCellIdentifier];
    [self.tbViewContent registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewIdentifier];
    [self.tbViewContent addStaticImageHeader];
    self.tbViewContent.backgroundColor = RGBHex(qwColor21);
    self.tbViewContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadBranchsData];
}


//为弹框获取适用药房
- (void)loadBranchsData{
    
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        CouponNewBranchSuitableModelR *modelR = [CouponNewBranchSuitableModelR new];
        modelR.couponId = self.couponId;
        modelR.page = @"1";
        modelR.pageSize = @"10";
        if(mapInfoModel == nil){
            modelR.lng = @"120.730435";
            modelR.lat = @"31.273391";
        }else{
            modelR.lng = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.longitude];
            modelR.lat = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.latitude];
        }
        modelR.city=[QWGLOBALMANAGER getMapInfoModel].branchCityName;
        modelR.branchId=[QWGLOBALMANAGER getMapBranchId];
        
        [Coupon getNewCouponPharmacy:modelR success:^(id obj) {
            
            CouponBranchVoListModel *couponPharModel = (CouponBranchVoListModel *)obj;
            
            [self.arrPharmcys addObjectsFromArray:couponPharModel.suitableBranchs];
            
        } failure:^(HttpException *e) {
            
        }];
    }];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //无网判断
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showMyInfoView:kWarning12 image:@"网络信号icon" tag:0];
    }else{
        self.curProductPage = 1;
        [self getOnlineCoupon:YES];
    }
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 分享
- (void)sharClick{
    [QWGLOBALMANAGER statisticsEventId:@"优惠券详情_分享" withLable:@"领券中心优惠券详情" withParams:nil];
    
    if([self.couponDetail.status intValue] == 0 || [self.couponDetail.status intValue] == 1 || [self.couponDetail.status intValue] == 2|| [self.couponDetail.status intValue] == 4){//使用前
        
        ShareContentModel *modelShare = [[ShareContentModel alloc] init];
        modelShare.typeShare    = ShareTypeMyCoupon;
        NSArray *arrParams      = @[self.couponDetail.couponId,self.couponDetail.groupId];
        if([self.couponDetail.scope intValue] == 4){
            modelShare.imgURL   = self.couponDetail.giftImgUrl;
        }
        modelShare.shareID      = modelShare.shareID = [arrParams componentsJoinedByString:SeparateStr];
        modelShare.title        = self.couponDetail.couponTitle;
        modelShare.content      = self.couponDetail.desc;
        
        ShareSaveLogModel *modelR = [ShareSaveLogModel new];
        modelR.province=[QWGLOBALMANAGER getMapInfoModel].province;
        modelR.city=[QWGLOBALMANAGER getMapInfoModel].branchCityName;
        modelR.shareObj = @"1";
        modelR.shareObjId = self.couponDetail.couponId;
        modelShare.modelSavelog = modelR;
        [self popUpShareView:modelShare];
    }
}


#pragma mark - 获取数据
// 获取优惠券信息
- (void)getOnlineCoupon:(BOOL)isProduct{
    
    GetCenterCouponDetailModelR *modelR = [GetCenterCouponDetailModelR new];
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        if(mapInfoModel == nil){
            modelR.longitude = @(120.730435);
            modelR.latitude = @(31.273391);
        }else{
            modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
            modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
        }
    }];
    modelR.city=[QWGLOBALMANAGER getMapInfoModel].branchCityName;
    if(QWGLOBALMANAGER.loginStatus){
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    modelR.couponId = self.couponId;
    modelR.branchId=[QWGLOBALMANAGER getMapBranchId];
    //#define GetCouponCenterDetail        @"h5/coupon/getOnlineCoupon"//领券中心的优惠券的详情

    [Coupon getCenterCouponDetail:modelR success:^(OnlineCouponDetailVo *obj) {
        if([obj.apiStatus intValue]==0){
            self.couponDetail = obj;
            [self.arrCouponDetails removeAllObjects];
            if (obj.condition.title.length > 0) {
                [self.arrCouponDetails addObject:obj.condition.title];
            }
            [self.arrCouponDetails addObjectsFromArray:obj.condition.conditions];
            //设置整个页面
            [self setupView];
            //获取优惠商品
            if(isProduct){
                [self loadProductData];
            }
        }else{
            self.couponDetail = obj;
            [self setUnStatusView];
            [self.tbViewContent reloadData];
        }
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showMyInfoView:kWarning215N26 image:@"ic_img_fail" tag:0];
            }else{
                [self showMyInfoView:kWarning39 image:@"ic_img_fail" tag:0];
            }
        }
        [self.tbViewContent reloadData];
        
    }];
}
#pragma mark - 分页加载
- (void)refreshData{
    HttpClientMgr.progressEnabled = NO;
    [self loadProductData];
}

#pragma mark - 获取券适用商品
- (void)loadProductData{
    GetCouponDetailProductModelR *modelR = [GetCouponDetailProductModelR new];
    modelR.couponId = self.couponDetail.couponId;
    if(self.couponDetail.suitable){
        modelR.branchId = [QWGLOBALMANAGER getMapBranchId];
    }
    modelR.page = [NSString stringWithFormat:@"%ld",(long)self.curProductPage];
    modelR.pageSize=@"10";
    
    
    [Coupon couponSuitableDrug:modelR success:^(id obj) {
        CouponProductVoListModel *couponList = (CouponProductVoListModel *)obj;
        if([couponList.apiStatus intValue]==0){
            if(couponList.suitableProducts.count>0){
                //willAppear有重新获取商品的情况
                if(self.curProductPage==1){
                    [self.tbViewContent addFooterWithTarget:self action:@selector(refreshData)];
                     self.tbViewContent.footer.canLoadMore=YES;
                    [self.arrProducts removeAllObjects];
                }
                [self.arrProducts addObjectsFromArray:couponList.suitableProducts];
                self.curProductPage++;
            }else{
                self.tbViewContent.footer.canLoadMore=NO;
            }
        }else{
            [self setUnStatusView];
        }
      [self.tbViewContent footerEndRefreshing];
      [self.tbViewContent reloadData];
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showMyInfoView:kWarning215N26 image:@"ic_img_fail" tag:0];
            }else{
                [self showMyInfoView:kWarning39 image:@"ic_img_fail" tag:0];
            }
        }
     [self.tbViewContent footerEndRefreshing];
     [self.tbViewContent reloadData];
    }];
}
#pragma mark------设置优惠券详情的布局
#pragma mark - UITableView methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //请求接口失败就不要有section
    if (self.couponDetail == nil) {
        return 0;
    }
    return 3;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //优惠券
    if (section == 0) {
        return 1;
    } else if (section == 1) {//优惠细则
            //显示优惠细则
            if(self.arrCouponDetails.count > 0){
                return 1 + self.arrCouponDetails.count;
            }else{
                return 0;
            }
    }
    else if (section == 2) {
        if([self.couponDetail.suitableProductCount intValue]>0){
            //显示券适用商品
                return self.arrProducts.count+1;
        }else{
            return 0;
        }
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //显示优惠券的cell
    if (indexPath.section == 0) {
        return [VFourCouponQuanTableViewCell getCellHeight:nil] ;
    } else if (indexPath.section == 1) {//显示优惠细则
        return [self getCouponDetailHeight:indexPath.row];
    }
    else if (indexPath.section == 2) {//显示券适用商品
        if([self.couponDetail.suitableProductCount intValue]>0){
            if(indexPath.row==0){
                return heightPlaceHolder;
            }else{
                return [CouponSuitableTableViewCell getCellHeight:nil];
            }
        }else{
            return 0;
        }
    }
    return 120.0f;
}

//优惠细则的高度
- (CGFloat)getCouponDetailHeight:(NSInteger)row
{
    if (row == 0) {
        return heightPlaceHolder;
    } else if (row >= 1) {
        static CouponDetailCell *sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [self.tbViewContent dequeueReusableCellWithIdentifier:@"CouponDetailCell"];
        });
        sizingCell.lblContent.font = fontSystem(kFontS4);
        NSString *strContent = [self.arrCouponDetails objectAtIndex:row-1];
        sizingCell.lblContent.text = strContent;
        if (row == self.arrCouponDetails.count) {
            sizingCell.constraintTop.constant=14.0f;
            sizingCell.constraintBottom.constant = 14.0f;
        }else{
            sizingCell.constraintTop.constant=14.0f;
            sizingCell.constraintBottom.constant = 0.0f;
        }
        sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tbViewContent.bounds), CGRectGetHeight(sizingCell.bounds));
        
        [sizingCell setNeedsLayout];
        [sizingCell layoutIfNeeded];
        CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return sizeFinal.height;
    } else {
        return 0;
    }
}



//cell中优惠细则的标题
- (CouponTicketDetailPlaceholderCell *)getPlaceHolderCellWithText:(NSString *)str isShowImg:(BOOL)isShow
{
    CouponTicketDetailPlaceholderCell *cell = (CouponTicketDetailPlaceholderCell *)[self.tbViewContent dequeueReusableCellWithIdentifier:CouponTicketDetailPlaceholderCellIdentifier];
    cell.lblContent.text = str;
    cell.imgArrow.hidden = !isShow;
    cell.lblContent.font = fontSystem(kFontS3);
    cell.lblContent.textColor = RGBHex(qwColor6);
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //优惠券的cell
    if (indexPath.section == 0) {
        VFourCouponQuanTableViewCell *cell = (VFourCouponQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CouponQuanTableViewCellIdentifier];
        
        [cell setTicketCouponQuan:self.couponDetail];
        //优惠券的盖章(要是产品又要改成不刷的就直接更改成couponVoModel)
        if(self.couponDetail.empty){
            cell.statusImage.image = PickOver;
        }else{
            if(self.couponDetail.pick){
                //领取过加领取次数为0
                if([self.couponDetail.couponNumLimit intValue]==0){
                    cell.statusImage.image = Picked;
                }else{
                    cell.statusImage.image = nil;
                }
            }else{
                cell.statusImage.image = nil;
            }
        }
        return cell;
    }
    else if (indexPath.section == 1) {//显示优惠细则
            //显示优惠细则
            if (indexPath.row == 0) {
                NSString *strSuitablePhar = @"优惠细则";
                return [self getPlaceHolderCellWithText:strSuitablePhar isShowImg:NO];
            } else {
                CouponDetailCell *cell = (CouponDetailCell *)[tableView dequeueReusableCellWithIdentifier:CouponDetailCellIdentifier];
                NSString *strCondition = self.arrCouponDetails[indexPath.row - 1];
                cell.lblContent.text = strCondition;
                cell.lblContent.font = fontSystem(kFontS4);
                cell.lblContent.textColor = RGBHex(qwColor7);
                return cell;
            }
    }
    else if (indexPath.section == 2) {//显示券的适用商品
        if([self.couponDetail.suitableProductCount intValue]>0){
        
                if (indexPath.row == 0) {
                    NSString *strSuitablePhar = @"券适用商品";
                    return [self getPlaceHolderCellWithText:strSuitablePhar isShowImg:NO];
                } else {
                    NSString *ConsultSuitableIdentifier = @"CouponSuitableTableViewCell";
                    CouponSuitableTableViewCell *cell = (CouponSuitableTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ConsultSuitableIdentifier];
                    if(cell == nil){
                        UINib *nib = [UINib nibWithNibName:@"CouponSuitableTableViewCell" bundle:nil];
                        [tableView registerNib:nib forCellReuseIdentifier:ConsultSuitableIdentifier];
                        cell = (CouponSuitableTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ConsultSuitableIdentifier];
                        cell.selectedBackgroundView = [[UIView alloc]init];
                        cell.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
                    }
                    CouponProductVoModel *drug = self.arrProducts[indexPath.row-1];
                    [cell setCell:drug];
                    return cell;
                }
        }else{
            return [tableView dequeueReusableCellWithIdentifier:UITableViewIdentifier];
        }

    }
    return [tableView dequeueReusableCellWithIdentifier:UITableViewIdentifier];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {//显示券的适用商品
     if([self.couponDetail.suitableProductCount intValue]>0){
         if(indexPath.row!=0){
             CouponProductVoModel *drug = self.arrProducts[indexPath.row-1];
             if(self.couponDetail.suitable){
                 MedicineDetailViewController *medicintDetail = [[MedicineDetailViewController alloc]initWithNibName:@"MedicineDetailViewController" bundle:nil];
                 medicintDetail.lastPageName = @"优惠券适用商品";
                 medicintDetail.proId = drug.branchProId;
                 medicintDetail.hidesBottomBarWhenPushed = YES;
                 [self.navigationController pushViewController:medicintDetail animated:YES];
             }else{
                 //弹框alert
                 ChangeProductAlertView *alert=[ChangeProductAlertView instance];
                 alert.blockDirect = ^(BOOL success) {
                     MedicineSearchResultViewController *VC = [[MedicineSearchResultViewController alloc]initWithNibName:@"MedicineSearchResultViewController" bundle:nil];
                     VC.productCode = drug.productId;
                     VC.lastPageName = @"优惠券适用商品";
                     VC.couponId =self.couponDetail.couponId;
                     [self.navigationController pushViewController:VC animated:YES];
                 };
                 alert.blockCancel = ^(BOOL cancel) {
                 };
                 [alert show];
             }
         }
     }
    }

    
}


#pragma mark --回退的返回键的重写
- (void)popVCAction:(id)sender
{
    if (self.extCallback != nil) {
        self.extCallback(YES);
    }
    [super popVCAction:sender];
}


#pragma mark - 设置页面   右上角的分享
- (void)setupView{
    //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期,
    if([self.couponDetail.status intValue] == 0 || [self.couponDetail.status intValue] == 1 || [self.couponDetail.status intValue] == 2 || [self.couponDetail.status intValue] == 3){
        if(self.couponDetail.canUserShare){//是否可以分享
            UIView *ypDetailBarItems=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 55)];
            UIButton * zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [zoomButton setFrame:CGRectMake(23, 2, 55,55)];
            [zoomButton addTarget:self action:@selector(sharClick) forControlEvents:UIControlEventTouchUpInside];
            UIImage *image = [[UIImage imageNamed:@"icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [zoomButton setImage:image forState:UIControlStateNormal];
            [ypDetailBarItems addSubview:zoomButton];
            UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            fixed.width = -15;
            self.navigationItem.rightBarButtonItems=@[fixed,[[UIBarButtonItem alloc]initWithCustomView:ypDetailBarItems]];
        }
    }
    //设置底部的按钮  领取优惠
    self.viewFooter.backgroundColor = RGBHex(qwColor4);
    
    self.btnGetCoupon.layer.masksToBounds = YES;
    self.btnGetCoupon.layer.cornerRadius = 4.5f;
    
    
    self.btnGetPharmcy.layer.masksToBounds = YES;
    self.btnGetPharmcy.layer.cornerRadius = 4.5f;
    [self setupCouponRemainCount];
}

#pragma mark - 设置底部按钮
- (void)setupCouponRemainCount
{
    if(self.couponDetail.suitable){//此券适用此药房
        self.btnGetCoupon.enabled = YES;
        self.btnGetCoupon.hidden = NO;
        self.lblRemainCount.hidden=NO;
        self.btnGetPharmcy.enabled = NO;
        self.btnGetPharmcy.hidden = YES;
        self.lblDesc.hidden=YES;
        
        if (self.couponDetail.empty) {
            // 该券已抢光
            self.lblRemainCount.text = @"已抢完";
            [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
            self.btnGetCoupon.enabled=NO;
            self.btnGetCoupon.backgroundColor=RGBHex(qwColor10);
        } else {
            // 该券还有
            if ([self.couponDetail.pick intValue] == 0) {
                // 未领取过该券
                self.lblRemainCount.text = [NSString stringWithFormat:@"可领%@次",self.couponDetail.couponNumLimit];
                [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
                self.btnGetCoupon.enabled=YES;
                self.btnGetCoupon.backgroundColor=RGBHex(qwColor2);
            } else {
                // 已领取过该券
                if ([self.couponDetail.couponNumLimit intValue] == 0) {
                    // 已经领过优惠券，并且个数为0
                    self.lblRemainCount.text = @"已领完";
                    [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
                    self.btnGetCoupon.enabled=NO;
                    self.btnGetCoupon.backgroundColor=RGBHex(qwColor10);
                } else {
                    self.lblRemainCount.text = [NSString stringWithFormat:@"还可领%@次",self.couponDetail.couponNumLimit];
                    [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
                    self.btnGetCoupon.enabled=YES;
                    self.btnGetCoupon.backgroundColor=RGBHex(qwColor2);
                }
            }
        }
        self.lblRemainCount.textAlignment = NSTextAlignmentCenter;
        self.lblRemainCount.font = fontSystem(kFontS5);
    }else{
        self.btnGetCoupon.enabled = NO;
        self.btnGetCoupon.hidden = YES;
        self.lblRemainCount.hidden=YES;
        self.btnGetPharmcy.enabled = YES;
        self.btnGetPharmcy.hidden = NO;
        self.lblDesc.hidden=NO;
    }
}

#pragma mark ---底部按钮的不同跳转
- (IBAction)pickTicket:(UIButton *)sender {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"优惠券内容"]=self.couponDetail.couponRemark;
    tdParams[@"是否开通微商"] = QWGLOBALMANAGER.weChatBusiness ? @"是" : @"否";
    if (([self.couponDetail.couponNumLimit intValue] == 0)&&([self.couponDetail.pick intValue] == 1)) {
        tdParams[@"是否领完"] = @"是";
        //领完后不做任何操作，不能在领券中心领券
    } else {
        tdParams[@"是否领完"] = @"否";
        //还有机会领券
        [self pickQuan];
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_yhq_lq" withLable:@"优惠券详情" withParams:tdParams];
    [QWGLOBALMANAGER statisticsEventId:@"优惠券详情_领取优惠" withLable:@"领券中心优惠券详情" withParams:nil];
}

- (IBAction)otherPharmcy:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"优惠券详情_其它适用药房" withLable:@"领券中心优惠券详情" withParams:nil];
    if([self.couponDetail.suitableBranchCount intValue]>0){
    [BranchCouponDetailView showInView:APPDelegate.window withTitle:@"其他适用药房" model:self.couponDetail list:self.arrPharmcys withSelectedIndex:-1 withType:Enum_CouponCenter andCallBack:^(CouponBranchVoModel *obj,NSString *type) {
        if([type isEqualToString:@"0"]){//cell的点击
            //点击进入药房详情
            CouponBranchVoModel *VO = obj;
            PharmacySotreViewController *VC = [[PharmacySotreViewController alloc]init];
            VC.branchId = VO.branchId;
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else if([type isEqualToString:@"1"]){//底部的领取按钮
            if (([self.couponDetail.couponNumLimit intValue] == 0)&&([self.couponDetail.pick intValue] == 1)) {
                //领完后不做任何操作，不能在领券中心领券
            } else {
                //还有机会领券
                [self pickQuan];
            }
        } 
    }];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"暂无适用药房"];
    }
    
}


#pragma mark ---不同非正常状态下的背景提示
- (void)setUnStatusView
{
    //访问不正常
    if([self.couponDetail.apiStatus intValue] == 4)
    {
        [self showMyInfoView:@"对不起，该优惠已下架" image:@"ic_img_cry" tag:0];
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
    
    if([self.couponDetail.apiStatus intValue] != 0){
        [self showInfoView:self.couponDetail.apiMessage image:@"ic_img_cry"];
        self.navigationItem.rightBarButtonItem = nil;
        return;
    }
}

#pragma mark - 商品下架/冻结背景提示UI
//背景提示需要自定义增加控件,所有和父类方法混用(例外特殊)
-(void)showMyInfoView:(NSString *)text image:(NSString*)imageName tag:(NSInteger)tag
{
    UIView *vInfo = [super showInfoView:text image:imageName tag:tag];
    UIView *lblInfo = [vInfo viewWithTag:101];
    UIButton *checkButton = [[UIButton alloc]initWithFrame:CGRectMake(APP_W - 120, lblInfo.frame.origin.y + lblInfo.frame.size.height + 52, 100, 21) ];
    checkButton.titleLabel.font = fontSystem(kFontS4);
    [checkButton setTitle:@"查看我的优惠" forState:UIControlStateNormal];
    [checkButton setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(pushToMyQuan:) forControlEvents:UIControlEventTouchUpInside];
    [vInfo addSubview:checkButton];
    
}


#pragma mark - 进入我的优惠券，从药房详情/IM/推送进入领取成功后进入我的优惠券
- (void)pushToMyQuan:(id)sender{
    if(QWGLOBALMANAGER.loginStatus){
        for(UIViewController *view in self.navigationController.viewControllers){
            if([view isKindOfClass:[MyCouponQuanViewController class]]){
                [self.navigationController popToViewController:view animated:YES];
                return;
            }
        }
        MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
        myCouponQuan.popToRootView = NO;
        [self.navigationController pushViewController:myCouponQuan animated:YES];
        
    }else{
        LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginView animated:YES];
    }
}

#pragma mark - 领取HTTPRequest
- (void)pickQuan{
    if(!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        return;
    }
    ActCouponPickModelR *modelR = [ActCouponPickModelR new];
    modelR.city=[QWGLOBALMANAGER getMapInfoModel].branchCityName;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.couponId = self.couponDetail.couponId;
    modelR.platform = @"2";
    modelR.version = APP_VERSION;
    if (self.mktgId.length > 0) {
        modelR.marketingCaseId = self.mktgId;
    } else {
        modelR.marketingCaseId = @"";
    }
    
    [Coupon actCouponPick:modelR success:^(CouponPickVoModel *myCouponVoModel) {
        if([myCouponVoModel.apiStatus integerValue] == 0) {
            
            //用于领券中心的
            self.centerModel.pick = YES;
            self.centerModel.limitLeftCounts --;
            
            if (self.centerModel.limitLeftCounts <= 0) {
                self.centerModel.limitLeftCounts = 0;
            }
            
            
            [QWGLOBALMANAGER postNotif:NOtifCouponStatusChanged data:nil object:nil];
            //弹框alert
            PickAlertView *alert=[PickAlertView instance];
            alert.alertTitle.text = @"领取成功！";
            alert.blockDirect = ^(BOOL success) {
                //先判断是否是兑换券和优惠商品券
                //兑换券直接进入二维码页面
                if([self.couponDetail.scope integerValue] == 7||[self.couponDetail.scope integerValue] == 8){
                    [self GoUseQuanHTTP];
                }else{
                    //判断是否适用此药房
                    if(self.couponDetail.suitable){
                        QWGLOBALMANAGER.tabBar.selectedIndex = 0;
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        //不适用则进入选择药房的页面
                        CouponBranchChooseViewController *vc=[[CouponBranchChooseViewController alloc] init];
                        vc.couponId=self.couponId;
                        vc.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
 
            };
            alert.blockCancel = ^(BOOL cancel) {
                //点击取消重新请求接口
                [self getOnlineCoupon:NO];
            };
            [alert show];
            
        }else{
            [SVProgressHUD showErrorWithStatus:myCouponVoModel.apiMessage duration:0.8f];
        }
    } failure:^(HttpException *e) {
        
    }];
}


//到兑换码的页面
- (void)GoUseQuanHTTP{
    
    CouponShowModelR *modelR = [CouponShowModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.couponId = self.couponDetail.couponId;
    
    [Coupon couponCenterShow:modelR success:^(UseMyCouponVoModel *model) {
        if([model.apiStatus integerValue] == 0)
        {
            CouponUseViewController *couponUseViewController = [[CouponUseViewController alloc] initWithNibName:@"CouponUseViewController" bundle:nil];
            couponUseViewController.useModel = model;
            [self.navigationController pushViewController:couponUseViewController animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.8];
        }
    } failure:^(HttpException *e) {
        
    }];
}


@end
