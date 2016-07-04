//
//  ConfirmOrderViewController.m
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "ConfirmOrderPayTableViewCell.h"
#import "ConfirmDeliverTableViewCell.h"
#import "ConfrimOrderAddressTableViewCell.h"
#import "ConfirmDeliverTableViewCell.h"
#import "ConfirmOrderPayTableViewCell.h"
#import "MallCart.h"
#import "ChooseCouponView.h"
#import "ReceiverAddressTableViewController.h"
#import "SVProgressHUD.h"
#import "IndentDetailListViewController.h"
#import "AppDelegate.h"


static NSString  *const AddressCellIdentifier = @"ConfrimOrderAddressTableViewCellIdentifier";
static NSString  *const DeliverCellIdentifier = @"ConfirmDeliverTableViewCellIdentifier";
static NSString  *const PayCellIdentifier = @"ConfirmOrderPayTableViewCellIdentifier";
static NSString  *const ConfirmOrderIdentifier = @"ConfirmOrderTableViewCellIdentifier";

@interface ConfirmOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MicroMallCartPreviewVoModel       *voModel;
@property (nonatomic, strong) DeliveryTypeVoModel               *devliverTypeModel;
@property (nonatomic, strong) PayTypeVoModel                    *payVoModel;
@property (nonatomic, strong) CartPromotionVoModel              *promotionVoModel;
@property (nonatomic, strong) NSString                          *remarkString;
@property (nonatomic, strong) MapInfoModel                      *chooseMapInfoModel;
@property (weak, nonatomic) IBOutlet UILabel                    *totalPriceLabel;
@property (nonatomic, strong) MicroMallCartCompleteVoModel      *responseModel;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self initializeUI];
    MapInfoModel *mapInfoModel = [QWUserDefault getModelBy:kModifiedCityModel];
    if(mapInfoModel.id) {
        _chooseMapInfoModel = mapInfoModel;
    }
    else
    {
        _chooseMapInfoModel = nil;
        self.devliverTypeModel = nil;
        [self.tableView reloadData];
    }
    //预览订单接口,刷新本界面数据
    [self queryPreviewOrder];
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_cx" withLable:@"确认订单-出现" withParams:@{@"上级页面":@"购物车"}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"上级页面"] = @"购物车";
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_cg_cx" withLable:@"确认订单-成功页面_出现" withParams:setting];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"ConfirmDeliverTableViewCell" bundle:nil] forCellReuseIdentifier:DeliverCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConfirmOrderPayTableViewCell" bundle:nil] forCellReuseIdentifier:PayCellIdentifier];
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
    if(self.devliverTypeModel) {
        modelR.deliveryType = self.devliverTypeModel.type;
    }
    if(self.promotionVoModel) {
        modelR.couponId = self.promotionVoModel.id;
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
            self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.voModel.payableAccounts];
            _chooseList = [NSMutableArray arrayWithCapacity:10];
            if(self.voModel.branchs.count > 0) {
                CartBranchVoModel *branchModel = self.voModel.branchs[0];
                if(branchModel.products.count > 0) {
                    [_chooseList addObjectsFromArray:[branchModel products]];
                }
                for(CartComboVoModel *comboVoModel in branchModel.combos) {
                    [_chooseList addObjectsFromArray:comboVoModel.druglist];
                }
                if(branchModel.redemptions.count > 0) {
                    [_chooseList addObjectsFromArray:branchModel.redemptions];
                }
            }
            if(self.voModel.coupons.count > 0) {
                if(self.promotionVoModel == nil) {
                    self.promotionVoModel = self.voModel.coupons[0];
                    [self queryPreviewOrder];
                }
            }
            CartBranchVoModel *branchModel = self.voModel.branchs[0];

            for(CartPromotionVoModel *promotionVoModel in self.voModel.coupons) {
                if([promotionVoModel.id isEqualToString:self.promotionVoModel.id]) {
                    self.promotionVoModel = promotionVoModel;
                    break;
                }
            }
            for(PayTypeVoModel *payModel in self.voModel.payTypes)
            {
                if([payModel.title isEqualToString:self.voModel.selectedPayType.title]) {
                    self.voModel.selectedPayType = payModel;
                }
            }
            for(DeliveryTypeVoModel *deliveryModel in self.voModel.deliveryTypes) {
                if(deliveryModel.type == self.voModel.selectedDeliveryType.type) {
                    self.voModel.selectedDeliveryType = deliveryModel;
                }
            }
            
            self.payVoModel = self.voModel.selectedPayType;
            self.devliverTypeModel = self.voModel.selectedDeliveryType;
            
            [self.tableView reloadData];
        }
    } failure:NULL];
}

- (void)fillUpTableView:(MicroMallCartPreviewVoModel *)model
{
    
    
    
}

#pragma mark -
#pragma mark UITableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = nil;
    if(section == 3) {
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
    if(section == 3) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return [ConfrimOrderAddressTableViewCell getCellHeight:nil];
    }else if (indexPath.section == 1) {
        return [ConfirmDeliverTableViewCell getCellHeight:nil];
    }else if (indexPath.section == 2) {
        return [ConfirmOrderPayTableViewCell getCellHeight:nil];
    }else{
        id unKnownModel = _chooseList[indexPath.row];
        if([unKnownModel isKindOfClass:[CartProductVoModel class]]) {
            CartProductVoModel *model = (CartProductVoModel *)unKnownModel;
            return [ConfirmOrderTableViewCell getCellHeight:model];
        }else if([unKnownModel isKindOfClass:[CartComboVoModel class]]){
            CartBranchVoModel *branchModel = (CartBranchVoModel *)self.voModel.branchs[0];
            NSMutableArray *combosArrays = [self sortCombosProdcut:branchModel.combos];
            ComboProductVoModel *comboProduct = combosArrays[indexPath.row - self.branchModel.products.count];
            if(comboProduct.showType == 3 || comboProduct.showType == 4) {
                return 85.0f + 29;
            }else{
                return 85.0f;
            }
        }else{
            return 85.0f;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:{
            return 1;
        }
        case 1: {
            return 4;
        }
        case 2: {
            return 1;
        }
        case 3: {
            CartBranchVoModel *branchModel = (CartBranchVoModel *)self.voModel.branchs[0];
            NSInteger combosCount = 0;
            for(CartComboVoModel *comboVoModel in branchModel.combos) {
                combosCount += comboVoModel.druglist.count;
            }
            return branchModel.products.count + combosCount + branchModel.redemptions.count;
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:{
            ConfrimOrderAddressTableViewCell *addressCell = [atableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
            cell = addressCell;
            [addressCell setCell:_chooseMapInfoModel];
            break;
        }
        case 1: {
            ConfirmDeliverTableViewCell *deliverCell = [atableView dequeueReusableCellWithIdentifier:DeliverCellIdentifier];
            switch (indexPath.row) {
                case 0: {
                    deliverCell.itemLabel.text = @"店铺优惠";
                    deliverCell.itemDetail.text = self.promotionVoModel.title;
                    if(self.voModel.coupons.count == 0) {
                        deliverCell.itemDetail.text = @"暂无优惠";
                    }
                    deliverCell.accessoryImage.hidden = NO;
                    deliverCell.textField.hidden = YES;
                    deliverCell.line.hidden = NO;
                    break;
                }
                case 1: {
                    deliverCell.itemLabel.text = @"配送方式";
                    deliverCell.accessoryImage.hidden = NO;
                    deliverCell.itemDetail.text = self.devliverTypeModel.content;
                    if(deliverCell.itemDetail.text.length == 0) {
                        deliverCell.itemDetail.text = @"请选择一种配送方式";
                    }
                    deliverCell.textField.hidden = YES;
                    deliverCell.line.hidden = NO;
                    break;
                }
                case 2: {
                    deliverCell.itemLabel.text = @"支付方式";
                    if(self.voModel.payTypes.count > 1) {
                        deliverCell.accessoryImage.hidden = NO;
                    }else{
                        deliverCell.accessoryImage.hidden = YES;
                    }
                    CartBranchVoModel *branchModel = nil;
                    if(self.voModel) {
                        branchModel = self.voModel.branchs[0];
                    }else{
                        branchModel = self.branchModel;
                    }
                    if(branchModel.supportOnlineTrading) {
                        deliverCell.itemDetail.text = @"在线支付";
                    }else{
                        deliverCell.itemDetail.text = @"当面付款";
                    }
                    if(self.payVoModel) {
                        deliverCell.itemDetail.text = self.payVoModel.title;
                    }
                    deliverCell.textField.hidden = YES;
                    deliverCell.line.hidden = NO;
                    break;
                }
                case 3: {
                    deliverCell.itemLabel.text = @"买家留言";
                    deliverCell.accessoryImage.hidden = NO;
                    deliverCell.textField.hidden = NO;
                    deliverCell.textField.delegate = self;
                    deliverCell.line.hidden = YES;
                    break;
                }
                default:
                    break;
            }
            cell = deliverCell;
            break;
        }
        case 2: {
            ConfirmOrderPayTableViewCell *payCell = [atableView dequeueReusableCellWithIdentifier:PayCellIdentifier];
            payCell.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.voModel.accounts];

            payCell.minusLabel.text = [NSString stringWithFormat:@"-￥%.2f",self.voModel.discountAccounts];

            if(self.voModel.couponDiscountAccounts == nil) {
                payCell.couponLabel.text = @"";
            }else{
                payCell.couponLabel.text = [NSString stringWithFormat:@"%@",self.voModel.couponDiscountAccounts];
            }

            payCell.deliverPayPrice.text = [NSString stringWithFormat:@"+￥%.2f",self.voModel.deliveryFee];
            cell = payCell;
            break;
        }
        case 3: {
            CartBranchVoModel *branchModel = (CartBranchVoModel *)self.voModel.branchs[0];
            NSMutableArray *combosArrays = [self sortCombosProdcut:branchModel.combos];
            ConfirmOrderTableViewCell *orderCell = [atableView dequeueReusableCellWithIdentifier:ConfirmOrderIdentifier];
            cell = orderCell;
            [orderCell setCell:_chooseList[indexPath.row]];

            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    ConfirmDeliverTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    if(cell) {
        [cell.textField resignFirstResponder];
    }
    //每次选中优惠,都必须重新请求预览接口刷新数据
    switch (indexPath.section) {
        case 0:{
            //address地址切换
            [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_dz" withLable:@"确认订单-地址" withParams:nil];
            ReceiverAddressTableViewController *receiverAddressTableViewController = [[ReceiverAddressTableViewController alloc] init];
            receiverAddressTableViewController.pageType = PageComeFromMall;
            receiverAddressTableViewController.chooseAddress = ^(AddressVo *addressInfo) {
                self.chooseMapInfoModel = [MapInfoModel new];
                if(addressInfo.village == nil) {
                    addressInfo.village = @"";
                }
                if(addressInfo.address == nil) {
                    addressInfo.address = @"";
                }
                self.devliverTypeModel = nil;
                self.chooseMapInfoModel.formattedAddress = [NSString stringWithFormat:@"%@%@",addressInfo.village,addressInfo.address];
                self.chooseMapInfoModel.tel = addressInfo.mobile;
                self.chooseMapInfoModel.name = addressInfo.nick;
                self.chooseMapInfoModel.id = addressInfo.id;
                [self.tableView reloadData];
                [self queryPreviewOrder];
                [SVProgressHUD showSuccessWithStatus:@"选择改地址后，配送费有可能发生变化" duration:1.8f];
            };
            [self.navigationController pushViewController:receiverAddressTableViewController animated:YES];
            break;
        }
        case 1: {
            if(indexPath.row == 0) {
                //店铺优惠点击
                [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_yh_qd" withLable:@"确认订单-选择优惠-确定" withParams:nil];
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.voModel.coupons];
                if(array.count == 0) {
                    return;
                }
                CartPromotionVoModel *defaultModel = [CartPromotionVoModel new];
                defaultModel.title = @"不使用优惠";
                [array addObject:defaultModel];
                NSInteger selectIndex = -1;
                if(self.promotionVoModel && self.promotionVoModel.id) {
                    selectIndex = [array indexOfObject:self.promotionVoModel];
                }else{
                    selectIndex = array.count - 1;
                }

                [ChooseCouponView showInView:self.view withList:array withSelectedIndex:selectIndex withPayType:nil andSelectCallback:^(NSInteger obj) {
                    CartPromotionVoModel *model = array[obj];
                    
                    self.promotionVoModel = model;
                    
                    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
                    if(model.title != nil) {
                        setting[@"优惠名称"] = model.title;
                    }
                    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_yh" withLable:@"确认订单-选择优惠" withParams:setting];
                    [self queryPreviewOrder];
                    [self.tableView reloadData];
                }];

            }else if(indexPath.row == 1){
                //点击配送方式
                
                [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_ps_qd" withLable:@"确认订单-选择配送方式-确定" withParams:nil];
                NSArray *array = self.voModel.deliveryTypes;
                NSInteger selectIndex = -1;
                if(self.devliverTypeModel) {
                    selectIndex = [array indexOfObject:self.devliverTypeModel];
                }
                [ChooseCouponView showInView:self.view withList:array withSelectedIndex:selectIndex withPayType:nil andSelectCallback:^(NSInteger obj) {
                    DeliveryTypeVoModel *model = array[obj];
                    self.devliverTypeModel = model;
                    [self queryPreviewOrder];
                    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
                    if(model.content != nil) {
                        setting[@"配送方式"] = model.content;
                    }
                    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_ps" withLable:@"确认订单-选择配送方式" withParams:setting];
                    [self.tableView reloadData];
                }];
            }else if (indexPath.row == 2) {
                NSArray *array = self.voModel.payTypes;
                NSInteger selectIndex = -1;
                if(self.payVoModel) {
                    selectIndex = [array indexOfObject:self.payVoModel];
                }
                NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:2];
                for(PayTypeVoModel *payTypeModel in self.voModel.payTypes) {
                    [titleArray addObject:payTypeModel.title];
                }
                
                [ChooseCouponView showInView:self.view withList:titleArray withSelectedIndex:selectIndex withPayType:nil andSelectCallback:^(NSInteger obj) {
                    PayTypeVoModel *model = array[obj];
                    self.payVoModel = model;
                    [self queryPreviewOrder];
                    [self.tableView reloadData];
                }];
            }
            break;
        }
        case 2: {
            
            
            break;
        }
        case 3: {

            
            break;
        }
        default:
            break;
    }
}

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
                    subModel.choose = comboVoModel.choose;
                    subModel.showType = 3;
                    subModel.quantity = comboVoModel.quantity;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *replaceText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(replaceText.length <= 50) {
        _remarkString = replaceText;
        return YES;
    }else{
        return NO;
    }
}

//提交订单 生成订单二维码
- (IBAction)submitOrderAction:(id)sender
{
    if(self.devliverTypeModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择配送方式" duration:0.8f];
        return;
    }
    if(_chooseMapInfoModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择收货地址" duration:0.8f];
        return;
    }
    if(self.devliverTypeModel.type == 2) {
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
    MMallCartPreviewModelR *modelR = [MMallCartPreviewModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.productsJson = self.productsJson;
    modelR.deliveryType = self.devliverTypeModel.type;
    modelR.payType = self.payVoModel.type;
    modelR.postAddressId = self.chooseMapInfoModel.id;
    modelR.payableAccounts = self.voModel.payableAccounts;
    modelR.deviceCode = QWGLOBALMANAGER.deviceToken;
    modelR.channel = 1;
    modelR.deviceType = 2;
    if(self.promotionVoModel) {
        modelR.couponId = self.promotionVoModel.id;
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"优惠名"] = self.promotionVoModel.title;
        [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_dpyj" withLable:@"确认订单-店铺优惠" withParams:setting];
    }
    ConfirmDeliverTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    modelR.remark = cell.textField.text;
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"上级页面"] = @"购物车";
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_tjdd" withLable:@"确认订单-提交订单" withParams:setting];
    setting = [NSMutableDictionary dictionary];
    if(self.devliverTypeModel && self.devliverTypeModel.content) {
        setting[@"配送方式"] = self.devliverTypeModel.content;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_qrdd_psfs" withLable:@"确认订单-配送方式" withParams:setting];
    [MallCart queryMallCartNewSubmit:modelR success:^(MicroMallCartCompleteVoModel *responseModel) {
        _responseModel = responseModel;
        if([responseModel.apiStatus integerValue] == 0) {
            [QWGLOBALMANAGER postNotif:NotifShoppingCartShouldClear data:_invariableList object:self.branchModel];
            if(modelR.payType == 2) {
                WebOrderDetailModel *model=[WebOrderDetailModel new];
                model.orderCode=_responseModel.confirmCode;
                model.orderId=_responseModel.orderId;
                model.orderIdName=_responseModel.branchName;
                [QWGLOBALMANAGER jumpH5PayOrderWithOrderId:responseModel.orderId totalPrice:[NSString stringWithFormat:@"%.2f",modelR.payableAccounts] isComeFrom:@"3" orderModel:model navigationController:self.navigationController];
            }else{
                IndentDetailListViewController *indentDetailListViewController = [IndentDetailListViewController new];
                indentDetailListViewController.orderId = responseModel.orderId;
                indentDetailListViewController.isComeFromCode = YES;
                [self.navigationController pushViewController:indentDetailListViewController animated:YES];
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
    } failure:NULL];
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
                model.orderCode=_responseModel.confirmCode;
                model.orderId=_responseModel.orderId;
                model.orderIdName=_responseModel.branchName;
                [QWGLOBALMANAGER jumpH5PayOrderWithOrderId:_responseModel.orderId totalPrice:[NSString stringWithFormat:@"%.2f",self.voModel.payableAccounts] isComeFrom:@"3" orderModel:model navigationController:self.navigationController];
            }else{
                IndentDetailListViewController *indentDetailListViewController = [IndentDetailListViewController new];
                indentDetailListViewController.orderId = _responseModel.orderId;
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
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
