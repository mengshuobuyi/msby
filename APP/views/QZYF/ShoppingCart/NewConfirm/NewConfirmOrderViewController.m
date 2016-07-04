//
//  NewConfirmOrderViewController.m
//  APP
//  确认订单
//  预览订单接口：MMallCartNewPreview
//  提交订单接口：MMallCartNewSubmit
//  Created by qw_imac on 16/3/26.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewConfirmOrderViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "ChooseCouponViewController.h"
#import "ProTableViewCell.h"
#import "ConfirmDeliverTableViewCell.h"
#import "ConfrimOrderAddressTableViewCell.h"
#import "ConfirmDeliverTableViewCell.h"
#import "ConfirmOrderPayTableViewCell.h"
#import "NewChoosePostTableViewCell.h"
#import "ChooseCouponView.h"
#import "ReceiverAddressTableViewController.h"
#import "SVProgressHUD.h"
#import "IndentDetailListViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "PayWayTableViewCell.h"
#import "ProTableViewCell.h"
#import "BuyerMessageViewController.h"
#import "SubmitOrderSuccessViewController.h"
#import "PayInfoModel.h"
#import "Address.h"
typedef NS_ENUM(NSInteger,ChooseUserAddressStatus) {
    ChooseUserAddressStatusDefault,//默认地址状态
    ChooseUserAddressStatusCustom,//用户选择地址
};

@interface NewConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray      *btnArray;
    BuyerMessageModel   *buyerMessage;
    NSString            *infomation;
    NSInteger           choosedPromotionIndex;
    BOOL                havePromotion;
    BOOL                contantQuhuo;
    NSString            *branchCity;
    NSInteger           specialIdx;
}
@property (strong, nonatomic) MicroMallCartPreviewVoModel       *voModel;
@property (nonatomic, strong) DeliveryTypeVoModel               *devliverTypeModel;
@property (nonatomic, strong) PayTypeVoModel                    *payVoModel;
@property (nonatomic, strong) CartOnlineCouponVoModel           *promotionVoModel;
@property (nonatomic, strong) NSString                          *remarkString;
@property (weak, nonatomic) IBOutlet                            UITableView *tableView;
@property (weak, nonatomic) IBOutlet                            UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) AddressVo                      *chooseMapInfoModel;
@property (nonatomic,assign) BOOL                               canAddressEnable;
@property (nonatomic,assign) BOOL                               choosePost;
@property (nonatomic,assign) BOOL                               chooseSonghuo;
@property (nonatomic,assign) BOOL                               chooseQuhuo;
@property (nonatomic, strong) MicroMallCartCompleteVoModel      *responseModel;
@property (nonatomic, strong) CartOnlineCouponVoModel              *selectedPromotion;
@property (nonatomic,assign) ChooseUserAddressStatus            status;
@end

@implementation NewConfirmOrderViewController
static NSString  *const AddressCellIdentifier = @"ConfrimOrderAddressTableViewCellIdentifier";
static NSString  *const DeliverCellIdentifier = @"NewChoosePostTableViewCell";
static NSString  *const PayCellIdentifier = @"PayWayTableViewCell";
static NSString  *const PromotionCellIdentifier = @"ConfirmOrderPayTableViewCellIdentifier";
static NSString  *const ConfirmOrderIdentifier = @"ConfirmOrderTableViewCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提交预定";
    [self initializeUI];
    btnArray = [@[] mutableCopy];
    infomation = [[NSString alloc]init];
    self.canAddressEnable = YES;
    _chooseSonghuo= NO;
    _choosePost = NO;
    _chooseQuhuo = NO;
    havePromotion = NO;
    contantQuhuo = NO;
    choosedPromotionIndex = 0;
    specialIdx = 1;
    self.devliverTypeModel = [DeliveryTypeVoModel new];
    self.status = ChooseUserAddressStatusDefault;
    [self queryPreviewOrder];
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_cx" withLable:@"确认订单-出现" withParams:@{@"上级页面":@"购物车"}];
    [QWGLOBALMANAGER statisticsEventId:@"提交预定出现" withLable:nil withParams:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _submitBtn.userInteractionEnabled = YES;
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"上级页面"] = @"购物车";
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_cg_cx" withLable:@"确认订单-成功页面_出现" withParams:setting];
}

-(BOOL)canAddressEnable {
    _canAddressEnable = !_chooseQuhuo;
    return _canAddressEnable;
}

- (void)popVCAction:(id)sender
{
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_fh" withLable:@"确认订单-返回" withParams:nil];
    [super popVCAction:sender];
}

- (void)initializeUI
{
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConfrimOrderAddressTableViewCell" bundle:nil] forCellReuseIdentifier:AddressCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewChoosePostTableViewCell" bundle:nil] forCellReuseIdentifier:DeliverCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"PayWayTableViewCell" bundle:nil] forCellReuseIdentifier:PayCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConfirmOrderPayTableViewCell" bundle:nil] forCellReuseIdentifier:PromotionCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConfirmOrderTableViewCell" bundle:nil] forCellReuseIdentifier:ConfirmOrderIdentifier];
}
//预览订单接口
- (void)queryPreviewOrder
{
    MMallCartPreviewModelR *modelR = [MMallCartPreviewModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.productsJson = self.productsJson;
    modelR.deliveryType = 1;
    modelR.channel = 1;
    modelR.payType = 1;
    if(self.devliverTypeModel) {
        modelR.deliveryType = self.devliverTypeModel.chooseType;
    }
    if(self.promotionVoModel.couponId) {
        modelR.couponId = self.promotionVoModel.couponId;
    }
    CartBranchVoModel *branchModel = nil;
    if(self.payVoModel) {
        modelR.payType = self.payVoModel.type;
    }else{
        branchModel = self.branchModel;
        if(branchModel.supportOnlineTrading) {
            modelR.payType = 2;
        }
    }
    modelR.postAddressId = self.chooseMapInfoModel.id;
    modelR.deviceCode = QWGLOBALMANAGER.deviceToken;
    [MallCart queryMallCartNewPreView:modelR success:^(MicroMallCartPreviewVoModel *responseModel) {
        if([responseModel.apiStatus integerValue] == 0) {
            self.voModel = responseModel;
            branchCity = responseModel.cityName;
            //有默认地址与药房城市比较，城市一致才能带入 4.0
            self.chooseMapInfoModel = responseModel.address;
            
            self.totalPrice.text = [NSString stringWithFormat:@"￥%.2f",self.voModel.payableAccounts];
            _chooseList = [NSMutableArray arrayWithCapacity:10];
            if(self.voModel.branchs.count > 0) {
                CartBranchVoModel *branchModel = self.voModel.branchs[0];
                for(CartComboVoModel *comboVoModel in branchModel.combos) {
                    [_chooseList addObjectsFromArray:comboVoModel.druglist];
                }
                if(branchModel.products.count > 0) {
                    [_chooseList addObjectsFromArray:[branchModel products]];
                }
                if(branchModel.redemptions.count > 0) {
                    [_chooseList addObjectsFromArray:branchModel.redemptions];
                }
            }
            if(choosedPromotionIndex != -1) {
                if(self.voModel.couponList.count > 0) {
                    if(self.promotionVoModel == nil) {
                        NSArray *array = self.voModel.couponList;
                        for (NSInteger index = 0; index < array.count; index++) {
                            CartOnlineCouponVoModel *promotionVoModel = array[index];
                            if (promotionVoModel.onlySupportOnlineTrading && self.voModel.selectedPayType.type == 1 ) {
                                //当面付款且只支持网上支付
                                
                            }else {
                                self.promotionVoModel = array[index];
                                [self queryPreviewOrder];
                                break;
                            }
                        }
                    }else {
                        if (self.promotionVoModel.onlySupportOnlineTrading && self.voModel.selectedPayType.type == 1 ) {
                            //当面付款且只支持网上支付
                            NSArray *array = self.voModel.couponList;
                            for (NSInteger index = 0; index < array.count; index++) {
                                CartOnlineCouponVoModel *promotionVoModel = array[index];
                                if (!promotionVoModel.onlySupportOnlineTrading) {
                                    //当面付款且只支持网上支付
                                    if(![self.promotionVoModel.couponId isEqualToString:((CartOnlineCouponVoModel *)array[index]).couponId]) {
                                        self.promotionVoModel = array[index];
                                        [SVProgressHUD showSuccessWithStatus:@"已为您重新配置了优惠" duration:1.0];
                                        [self queryPreviewOrder];
                                        break;
                                    }
                                }
                            }
                        }else{
                            if(![self.promotionVoModel.couponId isEqualToString:self.selectedPromotion.couponId]) {
                                [self queryPreviewOrder];
                            }
                        }
                    }
                    self.selectedPromotion = self.promotionVoModel;
                }else{
                    self.promotionVoModel = nil;
                    self.selectedPromotion = nil;
                }
            }
            for(PayTypeVoModel *payModel in self.voModel.payTypes)
            {
                if([payModel.title isEqualToString:self.voModel.selectedPayType.title] || payModel.type == self.voModel.selectedPayType.type) {
                    self.voModel.selectedPayType = payModel;
                }
            }
            for(DeliveryTypeVoModel *deliveryModel in self.voModel.deliveryTypes) {
                if (deliveryModel.type == 1) {
                    contantQuhuo = YES;
                    break;
                }
            }
            if (!contantQuhuo) {
                _chooseQuhuo = NO;
            }
            for(DeliveryTypeVoModel *deliveryModel in self.voModel.deliveryTypes) {
                if(deliveryModel.type == self.voModel.selectedDeliveryType.type) {
                    self.voModel.selectedDeliveryType = deliveryModel;
                }
            }
            self.payVoModel = self.voModel.selectedPayType;
            self.devliverTypeModel = self.voModel.selectedDeliveryType;
            self.devliverTypeModel.chooseType = self.voModel.selectedDeliveryType.type;
            [self.tableView reloadData];
        }else {
            [SVProgressHUD showErrorWithStatus:responseModel.apiMessage duration:0.8];
            [self.tableView reloadData];
        }
    } failure:NULL];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return [ConfrimOrderAddressTableViewCell getCellHeight:nil];
    }else if (indexPath.section == 1) {
        DeliveryTypeVoModel *deliveryModel = self.voModel.deliveryTypes[indexPath.row];
        if (deliveryModel.type == 2) {
            BOOL haveAddress = NO;
            if (_chooseMapInfoModel.id) {
                haveAddress = YES;
            }
            if (haveAddress && !deliveryModel.available && _chooseSonghuo) {//没有输入收货地址的情况下（特殊处理）
                return 70.0;
            }else {
                return 50.0;
            }
        }else {
            return 50.0;
        }
    }else if (indexPath.section == 2) {
        return 152;
    }else if (indexPath.section == 3){
        return [ConfirmOrderPayTableViewCell getCellHeight:nil];
    }else{
        id unKnownModel = _chooseList[indexPath.row];
        if([unKnownModel isKindOfClass:[CartProductVoModel class]]) {
            CartProductVoModel *model = (CartProductVoModel *)unKnownModel;
            return [ConfirmOrderTableViewCell getCellHeight:model];
        }else if([unKnownModel isKindOfClass:[ComboProductVoModel class]]){
            CartBranchVoModel *branchModel = (CartBranchVoModel *)self.voModel.branchs[0];
            NSMutableArray *combosArrays = [self sortCombosProdcut:branchModel.combos];
            ComboProductVoModel *comboProduct = combosArrays[indexPath.row];
            if(comboProduct.showType == 3 || comboProduct.showType == 4) {
                return 85.0f + 29;
            }else{
                return 85.0f;
            }
        }else{
            return 85.0f + 29;
        }
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = nil;
    if(section == 4) {
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 40)];
        [header setBackgroundColor:[UIColor whiteColor]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APP_W - 30, 40)];
        label.font = fontSystem(kFontS4);
        label.textColor = RGBHex(qwColor6);
        label.text = _branchModel.branchName;
        UIView *topSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
        UIView *bottomSeparator = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, APP_W, 0.5)];
        [topSeparator setBackgroundColor:RGBHex(qwColor10)];
        [bottomSeparator setBackgroundColor:RGBHex(qwColor10)];
        [header addSubview:topSeparator];
        [header addSubview:bottomSeparator];
        [header addSubview:label];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 4) {
        return 40;
    }else{
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 8)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:{
            return self.voModel.deliveryTypes.count;
        }
        case 4: {
            CartBranchVoModel *branchModel = (CartBranchVoModel *)self.voModel.branchs[0];
            NSInteger combosCount = 0;
            for(CartComboVoModel *comboVoModel in branchModel.combos) {
                combosCount += comboVoModel.druglist.count;
            }
            return branchModel.products.count + combosCount + branchModel.redemptions.count;
        }
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:{
            ConfrimOrderAddressTableViewCell *addressCell = [atableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
          
            cell = addressCell;
            [addressCell setCell:_chooseMapInfoModel with:self.canAddressEnable];
            break;
        }
        case 1:{
            NewChoosePostTableViewCell *chooseCell = [atableView dequeueReusableCellWithIdentifier:DeliverCellIdentifier];
            DeliveryTypeVoModel *deliveryModel = self.voModel.deliveryTypes[indexPath.row];
            BOOL haveAddress = NO;
            if (_chooseMapInfoModel.id) {
                haveAddress = YES;
            }
            [chooseCell setCell:deliveryModel with:haveAddress and:_chooseSonghuo];
            switch (deliveryModel.type) {
                case 1://自提
                    chooseCell.quhuoBtn.selected = _chooseQuhuo;
                    [chooseCell.quhuoBtn addTarget:self action:@selector(chooseQuhuo:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 2://送货
                    chooseCell.songhuoBtn.selected = _chooseSonghuo;
                    chooseCell.songhuoBtn.tag = indexPath.row;
                    [chooseCell.songhuoBtn addTarget:self action:@selector(chooseSonghuo:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 3://快递
                    chooseCell.postBtn.selected = _choosePost;
                    [chooseCell.postBtn addTarget:self action:@selector(choosePost:) forControlEvents:UIControlEventTouchUpInside];
                    break;
            }
            cell = chooseCell;
            break;
        }
        case 2:{
            PayWayTableViewCell *payCell = [atableView dequeueReusableCellWithIdentifier:PayCellIdentifier];
            if(self.voModel.payTypes.count > 1) {
                payCell.segment.hidden = NO;
                payCell.faceLabel.hidden = YES;
                [payCell.segment removeTarget:NULL action:NULL forControlEvents:UIControlEventValueChanged];
                payCell.segment.selectedSegmentIndex = self.voModel.selectedPayType.type - 1;
                [payCell.segment addTarget:self action:@selector(choosePayWay:) forControlEvents:UIControlEventValueChanged];
            }else {
                payCell.segment.hidden = YES;
                payCell.faceLabel.hidden = NO;
                payCell.faceLabel.layer.cornerRadius = 3.0;
                payCell.faceLabel.layer.masksToBounds = YES;
            }
            if(self.promotionVoModel) {
                payCell.promotionInfo.text = self.promotionVoModel.intro;
            }
            if(self.voModel.couponList.count == 0 || self.promotionVoModel == nil) {
                payCell.promotionInfo.text = @"暂无优惠券可用";
                payCell.arrRight.hidden = YES;
            }else {
                payCell.arrRight.hidden = NO;
            }
            if(choosedPromotionIndex == -1) {
                payCell.promotionInfo.text = @"不使用优惠";
                payCell.arrRight.hidden = NO;
            }
            [payCell.choosePromotion addTarget:self action:@selector(choosePromo) forControlEvents:UIControlEventTouchUpInside];
            [payCell.message addTarget:self action:@selector(leaveMessage) forControlEvents:UIControlEventTouchUpInside];
            if(StrIsEmpty(infomation)){
                payCell.placeholder.hidden = NO;
                payCell.messageInfo.hidden = YES;
            }else {
                payCell.placeholder.hidden = YES;
                payCell.messageInfo.hidden = NO;
                payCell.messageInfo.text = infomation;
            }
            cell = payCell;
        }
            break;
        case 3: {
            ConfirmOrderPayTableViewCell *payCell = [atableView dequeueReusableCellWithIdentifier:PromotionCellIdentifier];

            payCell.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.voModel.accounts];
            payCell.minusLabel.text = [NSString stringWithFormat:@"%@",self.voModel.orderPmt];
            payCell.deliverPayPrice.text = [NSString stringWithFormat:@"￥%.2f",self.voModel.deliveryFee];
            cell = payCell;
            break;
        }
        case 4:{
            CartBranchVoModel *branchModel = (CartBranchVoModel *)self.voModel.branchs[0];
            [self sortCombosProdcut:branchModel.combos];
            ConfirmOrderTableViewCell *orderCell = [atableView dequeueReusableCellWithIdentifier:ConfirmOrderIdentifier];
            cell = orderCell;
            [orderCell setCell:_chooseList[indexPath.row]];
    
        }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)chooseQuhuo:(UIButton *)sender {
    NSMutableDictionary *set = [NSMutableDictionary dictionary];
    set[@"配送方式选择"] = @"到店取货";
    [QWGLOBALMANAGER statisticsEventId:@"x_psfsxz" withLable:@"确认订单-配送方式" withParams:set];
    [QWGLOBALMANAGER statisticsEventId:@"提交预定_到店取货" withLable:nil withParams:nil];
    choosedPromotionIndex = 0;
    _chooseQuhuo = !_chooseQuhuo;
    self.canAddressEnable = !_chooseQuhuo;
    _choosePost = _chooseSonghuo = NO;
    if (_chooseQuhuo) {
        if (!self.devliverTypeModel) {
            self.devliverTypeModel = [DeliveryTypeVoModel new];
        }
        self.devliverTypeModel.chooseType = 1;
    }
    [self queryPreviewOrder];
}
-(void)chooseSonghuo:(UIButton *)sender {
    NSMutableDictionary *set = [NSMutableDictionary dictionary];
    set[@"配送方式选择"] = @"送货上门";
    [QWGLOBALMANAGER statisticsEventId:@"x_psfsxz" withLable:@"确认订单-配送方式" withParams:set];
    [QWGLOBALMANAGER statisticsEventId:@"提交预定_送货上门" withLable:nil withParams:nil];
    choosedPromotionIndex = 0;
    _chooseSonghuo = !_chooseSonghuo;
    _chooseQuhuo = _choosePost = NO;
    self.canAddressEnable = YES;
    if (!self.devliverTypeModel) {
        self.devliverTypeModel = [DeliveryTypeVoModel new];
    }
    if (_chooseSonghuo) {
        self.devliverTypeModel.chooseType = 2;
    }else {
        self.devliverTypeModel.chooseType = 1;
    }
    [self queryPreviewOrder];
}

-(void)choosePost:(UIButton *)sender {
    NSMutableDictionary *set = [NSMutableDictionary dictionary];
    set[@"配送方式选择"] = @"同城快递";
    [QWGLOBALMANAGER statisticsEventId:@"x_psfsxz" withLable:@"确认订单-配送方式" withParams:set];
    [QWGLOBALMANAGER statisticsEventId:@"提交预定_同城快递" withLable:nil withParams:nil];
    choosedPromotionIndex = 0;
    _choosePost = !_choosePost;
    _chooseSonghuo = _chooseQuhuo = NO;
    self.canAddressEnable = YES;
    if (!self.devliverTypeModel) {
        self.devliverTypeModel = [DeliveryTypeVoModel new];
    }
    if (_choosePost) {
        self.devliverTypeModel.chooseType = 3;
    }else {
        self.devliverTypeModel.chooseType = 1;
    }
    [self queryPreviewOrder];
}
//留言
-(void)leaveMessage {
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_mjly" withLable:@"确认订单-买家留言" withParams:nil];
   
    BuyerMessageViewController *vc = [[BuyerMessageViewController alloc]initWithNibName:@"BuyerMessageViewController" bundle:nil];
    vc.buyerMessage = buyerMessage;
    vc.message = ^(NSString *message,BuyerMessageModel *model) {
        buyerMessage = model;
        infomation = message;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//选择付款方式
-(void)choosePayWay:(UISegmentedControl *)sender {
    NSMutableDictionary *set = [NSMutableDictionary dictionary];
    set[@"优惠名"] = self.payVoModel.title;
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_zffs" withLable:@"确认订单-支付方式" withParams:set];
    
     havePromotion = YES;
    choosedPromotionIndex = 0;
    self.payVoModel.type = sender.selectedSegmentIndex + 1;
    
    
    NSArray *array = self.voModel.couponList;
    if(self.payVoModel.type == 1 && self.promotionVoModel.onlySupportOnlineTrading) {
        self.promotionVoModel = nil;
        self.selectedPromotion = nil;
        for (NSInteger index = 0; index < array.count; index++) {
            CartOnlineCouponVoModel *promotionVoModel = array[index];
            if (!promotionVoModel.onlySupportOnlineTrading) {
                self.promotionVoModel = array[index];
                self.selectedPromotion = array[index];
                [SVProgressHUD showSuccessWithStatus:@"已为您重新配置了优惠" duration:1.0];
                break;
            }
        }
    }
    
    [self queryPreviewOrder];
}

//商品排序
- (NSMutableArray *)sortCombosProdcut:(NSArray *)combos
{
    NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:10];
    for(NSInteger index = 0; index < combos.count; ++index) {
        CartComboVoModel *comboVoModel = combos[index];
        if(comboVoModel.druglist.count == 1) {
            ComboProductVoModel *subModel = comboVoModel.druglist[0];
            subModel.showType = 4;
            subModel.reduce = comboVoModel.reduce;
            subModel.combosPrice = comboVoModel.price;
            subModel.packageId = comboVoModel.packageId;
            subModel.desc = comboVoModel.desc;
            subModel.quantity = comboVoModel.quantity;
            subModel.choose = comboVoModel.choose;
            [retArray addObject:subModel];
        }else{
            for(ComboProductVoModel *subModel in comboVoModel.druglist) {
                if(subModel == comboVoModel.druglist[0]) {
                    subModel.desc = comboVoModel.desc;
                    subModel.showType = 1;
                    subModel.reduce = comboVoModel.reduce;
                    subModel.combosPrice = comboVoModel.price;
                    subModel.packageId = comboVoModel.packageId;
                    subModel.quantity = comboVoModel.quantity;
                }else if (subModel == [comboVoModel.druglist lastObject]) {
                    subModel.packageId = comboVoModel.packageId;
                    subModel.quantity = comboVoModel.quantity;
                    subModel.combosPrice = comboVoModel.price;
                    subModel.choose = comboVoModel.choose;
                    subModel.showType = 3;
                }else{
                    subModel.showType = 2;
                    subModel.quantity = comboVoModel.quantity;
                }
                [retArray addObject:subModel];
            }
        }
    }
    return retArray;
}

-(void)choosePromo {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.voModel.couponList];
    if(array.count == 0) {
        return;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_yhq" withLable:@"确认订单-优惠券" withParams:nil];
    ChooseCouponViewController *chooseCouponViewController = [[ChooseCouponViewController alloc] initWithNibName:@"ChooseCouponViewController" bundle:nil];
    chooseCouponViewController.chooseModel = self.promotionVoModel;
    chooseCouponViewController.supportOnlineTrading = self.voModel.selectedPayType.type == 2;
    chooseCouponViewController.couponList = array;
    chooseCouponViewController.callBack = ^(NSInteger obj) {
        havePromotion = YES;
        choosedPromotionIndex = obj;
        if(obj != -1){
            CartOnlineCouponVoModel *model = array[obj];
            self.promotionVoModel = model;
            NSMutableDictionary *setting = [NSMutableDictionary dictionary];
            if(model.couponRemark != nil) {
                setting[@"优惠名称"] = model.couponRemark;
            }
            [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_yh_qd" withLable:@"确认订单-选择优惠-确定" withParams:setting];
        }else {
            self.promotionVoModel = nil;
        }
            
        [self queryPreviewOrder];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:chooseCouponViewController animated:YES];
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_yh" withLable:@"确认订单-选择优惠" withParams:nil];
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            //address地址切换
            [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_dz" withLable:@"确认订单-地址" withParams:nil];
            ReceiverAddressTableViewController *receiverAddressTableViewController = [[ReceiverAddressTableViewController alloc] init];
            receiverAddressTableViewController.pageType = PageComeFromMall;
            receiverAddressTableViewController.branchCity = branchCity;
            receiverAddressTableViewController.chooseAddress = ^(AddressVo *addressInfo) {
                //地址在地址列表页做了校验
                self.status = ChooseUserAddressStatusCustom;
                if(addressInfo.village == nil) {
                    addressInfo.village = @"";
                }
                if(addressInfo.address == nil) {
                    addressInfo.address = @"";
                }
                self.chooseMapInfoModel = addressInfo;
                //                self.canAddressEnable = YES;
                [self.tableView reloadData];
                
                [self queryPreviewOrder];
                [SVProgressHUD showSuccessWithStatus:@"选择改地址后，配送费有可能发生变化" duration:1.8f];
            };
            [self.navigationController pushViewController:receiverAddressTableViewController animated:YES];
            break;
        }
        case 1:{
            DeliveryTypeVoModel *deliveryModel = self.voModel.deliveryTypes[indexPath.row];
            switch (deliveryModel.type) {
                case 1:
                    [self chooseQuhuo:nil];
                    break;
                case 2:
                    [self chooseSonghuo:nil];
                    break;
                case 3:
                    [self choosePost:nil];
                    break;
            }
            break;
        }
    }
}
- (IBAction)submitOrder:(UIButton *)sender {
    if (!_chooseQuhuo && !_choosePost &&!_chooseSonghuo) {//未选择配送方式
        [SVProgressHUD showErrorWithStatus:@"请选择配送方式" duration:0.8f];
        return;
    }
    if(!_chooseQuhuo && _chooseMapInfoModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择收货地址" duration:0.8f];
        return;
    }
    if (_chooseQuhuo) {
        self.devliverTypeModel.chooseType = 1;
    }
    if (_chooseSonghuo) {
        self.devliverTypeModel.chooseType = 2;
    }
    if (_choosePost) {
        self.devliverTypeModel.chooseType = 3;
    }
    if(self.devliverTypeModel.chooseType == 2) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        if([currentDateStr compare:self.voModel.deliveryBegin] == NSOrderedAscending || [currentDateStr compare:self.voModel.deliveryEnd] == NSOrderedDescending) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"当前时间不在药房配送时间内是否确认提交" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认提交", nil];
            alert.tag = 888;
            [alert show];
            return;
        }
    }
    [self __submitOrder];
}

- (void)__submitOrder
{
    [QWGLOBALMANAGER checkEventId:@"提交预定_提交预定" withLable:nil withParams:nil];
    MMallCartPreviewModelR *modelR = [MMallCartPreviewModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.productsJson = self.productsJson;
    modelR.deliveryType = self.devliverTypeModel.chooseType;
    modelR.payType = self.payVoModel.type;
 
    modelR.postAddressId = self.chooseMapInfoModel.id;
    if(_chooseQuhuo) {
        modelR.postAddressId = @"";
    }
    modelR.payableAccounts = self.voModel.payableAccounts;
    modelR.deviceCode = QWGLOBALMANAGER.deviceToken;
    modelR.channel = 1;
    modelR.deviceType = 2;
    if(self.promotionVoModel) {
        modelR.couponId = self.promotionVoModel.couponId;
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"优惠名"] = self.promotionVoModel.couponRemark;
        [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_dpyj" withLable:@"确认订单-店铺优惠" withParams:setting];
    }
    modelR.remark = infomation;
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"上级页面"] = @"购物车";
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_tjdd" withLable:@"确认订单-提交订单" withParams:setting];
    setting = [NSMutableDictionary dictionary];
    if(self.devliverTypeModel && self.devliverTypeModel.content) {
        setting[@"配送方式"] = self.devliverTypeModel.content;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_psfs" withLable:@"确认订单-配送方式" withParams:setting];
    _submitBtn.userInteractionEnabled = NO;
    [MallCart queryMallCartNewSubmit:modelR success:^(MicroMallCartCompleteVoModel *responseModel) {
        _responseModel = responseModel;
        
        if([responseModel.apiStatus integerValue] == 0) {
            APPDelegate.mainVC.selectedTab = -1;
            [QWGLOBALMANAGER postNotif:NotifShoppingCartShouldClear data:_invariableList object:self.branchModel];
            if(modelR.payType == 2) {
                //在线支付
                QWGLOBALMANAGER.completeVoModel = responseModel;
                WebOrderDetailModel *model=[WebOrderDetailModel new];
                model.orderCode=_responseModel.orderCode;
                model.orderId=_responseModel.orderId;
                model.orderIdName=_responseModel.branchName;
                [QWGLOBALMANAGER jumpH5PayOrderWithOrderId:responseModel.orderId totalPrice:[NSString stringWithFormat:@"%.2f",modelR.payableAccounts]  isComeFrom:@"3" orderModel:model navigationController:self.navigationController];
            }else{
                //当面支付
                SubmitOrderSuccessViewController *submitOrderVC = [[SubmitOrderSuccessViewController alloc] initWithNibName:@"SubmitOrderSuccessViewController" bundle:nil];
                submitOrderVC.orderId = responseModel.orderId;
                submitOrderVC.payType = 1;
                [self.navigationController pushViewController:submitOrderVC animated:YES];
//                IndentDetailListViewController *indentDetailListViewController = [IndentDetailListViewController new];
//                indentDetailListViewController.orderId = responseModel.orderId;
//                indentDetailListViewController.payType = 1;
//                indentDetailListViewController.isComeFromCode = YES;
//                [self.navigationController pushViewController:indentDetailListViewController animated:YES];
            }
        }else if ([responseModel.apiStatus integerValue] == 2019010) {
            //库存不足
            [SVProgressHUD showErrorWithStatus:responseModel.apiMessage duration:0.8];
        }else if ([responseModel.apiStatus integerValue] == 2019008) {
            //价格有变动
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:responseModel.apiMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"继续提交", nil];
            [alertView show];
            alertView.tag = 999;
        }else{
            [SVProgressHUD showErrorWithStatus:responseModel.apiMessage duration:0.8];
        }
        _submitBtn.userInteractionEnabled = YES;
    } failure:^(HttpException *e){
        _submitBtn.userInteractionEnabled = YES;
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 888) {
        if(buttonIndex == 1) {
            [self __submitOrder];
        }
    }else if(alertView.tag == 999){
        if(buttonIndex == 1) {
            [QWGLOBALMANAGER postNotif:NotifShoppingCartShouldClear data:_invariableList object:self.branchModel];
            if(self.payVoModel.type == 2) {
                WebOrderDetailModel *model=[WebOrderDetailModel new];
                model.orderCode=_responseModel.orderCode;
                model.orderId=_responseModel.orderId;
                model.orderIdName=_responseModel.branchName;
                [QWGLOBALMANAGER jumpH5PayOrderWithOrderId:_responseModel.orderId totalPrice:[NSString stringWithFormat:@"%.2f",self.voModel.payableAccounts] isComeFrom:@"3" orderModel:model navigationController:self.navigationController];
            }else{
                IndentDetailListViewController *indentDetailListViewController = [IndentDetailListViewController new];
                indentDetailListViewController.orderId = _responseModel.orderId;
                indentDetailListViewController.payType = self.payVoModel.type;
                [self.navigationController pushViewController:indentDetailListViewController animated:YES];
            }
        }
    }
}

//选中地址被删除,兼容跨市
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if(type == NotifAddressRefreshTwo) {
        _chooseMapInfoModel = nil;
        self.devliverTypeModel = nil;
        [self.tableView reloadData];
    }else if (type == NotifMallAddressAddOrEdit) {
        AddressVo *model = (AddressVo *)data;
        self.chooseMapInfoModel = model;
        [self queryPreviewOrder];
    }
}
@end