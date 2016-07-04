//
//  IndentDetailViewController.m
//  APP
//  订单详情页面
//  订单详情接口：QueryUserOrderDetailInfo
//  操作订单接口：OperateOrders
//  订单取消理由接口：QueryUserCancelReasonInfo
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "IndentDetailListViewController.h"
#import "IndentDetailTopTableViewCell.h"
#import "ReceiverTableViewCell.h"
#import "ProTableViewCell.h"
#import "ProPromotionTableViewCell.h"
#import "InfoTableViewCell.h"
#import "StoreInfoTableViewCell.h"
#import "ReceiverAddressTableViewController.h"
#import "ReportConsultViewController.h"
#import "Orders.h"
#import "EvaluateProductViewController.h"
#import "OrderCodeViewController.h"
#import "CancelAlertView.h"
#import "SVProgressHUD.h"
#import "CheckPostViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "IndentSnapDownView.h"
#import "MyIndentViewController.h"
#import "MedicineDetailViewController.h"
#import "NewProInfoTableViewCell.h"
typedef NS_ENUM(NSInteger,PhoneCallType) {
    PhoneCallTypeService,//客服电话
    PhoneCallTypeStore,  //店员电话
};

@interface IndentDetailListViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>
{
    UIButton            *ensureBtn;
    UIButton            *cancelBtn;
    NSMutableArray      *array;
    BOOL                resume;
    NSString            *cancelReason;
    NSMutableArray      *telArray;
    UIView              *footView;
    dispatch_source_t   snapTimer;
    long long           time;
    NSMutableArray      *proArray;           //所有商品array
    NSMutableDictionary *typeDic;
    IndentSnapDownView *snapView;
    NSMutableDictionary *proInfoDic;
    NSMutableArray      *proInfoArr;
}
@property (nonatomic,strong) UserOrderDetialVO  *model;
@property (nonatomic,strong) CancelAlertView    *cancelView;
@property (nonatomic,assign) PhoneCallType      phoneCallType;
@end

@implementation IndentDetailListViewController

- (void)viewDidLoad {
    resume = YES;
    [super viewDidLoad];
    self.title = @"订单详情";
    if (_isComeFromCode && self.payType==1) {
        
    }
    array = [NSMutableArray array];
    cancelReason = [[NSString alloc]init];
    telArray = [NSMutableArray array];
    typeDic = [[NSMutableDictionary alloc]init];
    [self setupUI];
    if (!QWGLOBALMANAGER.loginStatus) {
        [self login];
    }
    [self.tableMain registerNib:[UINib nibWithNibName:@"StoreInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreInfoTableViewCell"];
    [self.tableMain registerNib:[UINib nibWithNibName:@"ReceiverTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReceiverTableViewCell"];
    [self.tableMain registerNib:[UINib nibWithNibName:@"NewProInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewProInfoTableViewCell"];
    [self queryCancelReason];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryOrderDetail];
    if(!self.isUp){
        if([self.typeAlert isEqualToString:@"1"]){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾，您付款失败了！" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }else if ([self.typeAlert isEqualToString:@"2"]){
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        }
    }
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 取消输入框
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
    self.isUp=NO;
    self.typeAlert=@"";
}




-(void)setupUI {
    UIButton *service = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [service setTitle:@"客服" forState:UIControlStateNormal];
    service.titleLabel.font = fontSystem(kFontS4);
    [service setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    [service addTarget:self action:@selector(complain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *complain = [[UIBarButtonItem alloc]initWithCustomView:service];
    self.navigationItem.rightBarButtonItem = complain;
    
    if ([_status integerValue] == 2) {
        self.tableMain =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height - 64) style:UITableViewStylePlain];
        footView.hidden = YES;
    }else {
        self.tableMain =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height - 106 ) style:UITableViewStylePlain];
        footView.hidden = NO;
    }
    self.tableMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableMain.delegate = self;
    self.tableMain.dataSource = self;
    self.tableMain.backgroundColor = [UIColor clearColor];
    
    float scale = APP_W / 320;
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableMain.frame.size.height, APP_W, 42)];
    footView.backgroundColor = [UIColor whiteColor];
    
    cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(APP_W/2 - 20 * scale, 7.5, 75*scale, 27)];
    
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = fontSystem(kFontS4);
    [cancelBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 3.0;
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.layer.borderColor = RGBHex(qwColor7).CGColor;
    cancelBtn.layer.masksToBounds = YES;
    
    
    ensureBtn = [[UIButton alloc]initWithFrame:CGRectMake(APP_W/2 - 20 * scale + 75*scale+ 12*scale , 7.5, 75*scale, 27)];
    [ensureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = fontSystem(kFontS4);
    
    ensureBtn.layer.cornerRadius = 3.0;
    ensureBtn.layer.borderWidth = 0.5;
    ensureBtn.layer.borderColor = RGBHex(qwColor2).CGColor;
    ensureBtn.layer.masksToBounds = YES;
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [footView addSubview:line];
    [footView addSubview:cancelBtn];
    [footView addSubview:ensureBtn];
    
    [self.view addSubview:footView];
    [self.view addSubview:self.tableMain];
    [self.view bringSubviewToFront:footView];
}
//客服
-(void)complain {
//    ReportConsultViewController *vc = [ReportConsultViewController new];
//    
//    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
//    tdParams[@"价格总计"]=[NSString stringWithFormat:@"%@",_model.finalAmount];
//    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_ts" withLable:@"订单详情" withParams:tdParams];
//    vc.objType = [_model.branchType integerValue];
//    vc.branchId = _model.branchId;
//    [self.navigationController pushViewController:vc animated:YES];
    self.phoneCallType = PhoneCallTypeService;
    [self chooseTelWithTels:@[_model.serviceTel]];
}

-(void)popVCAction:(id)sender {
    resume = NO;
    if (snapTimer) {
        dispatch_source_cancel(snapTimer);
        snapTimer = NULL;
    }
    if (_isComeFromCode) {
        MainViewController *rootVC = (MainViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [rootVC selectedViewControllerWithTag:4];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else if (_isComeFromList) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[MyIndentViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }else{
        [super popVCAction:sender];
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_fh" withLable:@"订单详情" withParams:nil];
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}

-(void)dealloc {
    DebugLog(@"dealloc");
}
#pragma mark - tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return proArray.count;
    }else if (section == 2) {
        return proInfoArr.count;
    }else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            IndentDetailTopTableViewCell *cell;
            cell = (IndentDetailTopTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"IndentDetailTopTableViewCell" owner:self options:nil][0];
            [cell.ensureBtn addTarget:self action:@selector(gotoCodeVC) forControlEvents:UIControlEventTouchUpInside];
            cell.ensureBtn.userInteractionEnabled = YES;
            cell.codeImg.hidden = NO;
            cell.refundImg.hidden = YES;
            switch ([_model.orderStatus intValue]) {
                case 1:
                    cell.stateLabel.text = @"已提交";
                    break;
                case 2:
                    cell.stateLabel.text = @"待配送";
                    break;
                case 3:
                    cell.stateLabel.text = @"配送中";
                    break;
                case 6:
                    cell.stateLabel.text = @"待取货";
                    break;
                case 8:
                    cell.stateLabel.text = @"已取消";
                    cell.codeImg.hidden = YES;
                    cell.ensureBtn.userInteractionEnabled = NO;
                    break;
                case 9:
                    cell.stateLabel.text = @"已收货";
                    cell.codeImg.hidden = YES;
                    cell.ensureBtn.userInteractionEnabled = NO;
                    break;
                case 10:
                    cell.stateLabel.text = @"待付款";
                    cell.codeImg.hidden = YES;
                    cell.ensureBtn.userInteractionEnabled = NO;
                    break;
                default://刚开始加载数据，没有任何展示
                    cell.stateLabel.text = @"";
                    cell.codeImg.hidden = YES;
                    cell.ensureBtn.userInteractionEnabled = NO;
                    break;
            }
            if ([_model.refundStatus integerValue] == 1) {
                cell.refundImg.hidden = NO;
                cell.refundImg.image = [UIImage imageNamed:@"lable_refund"];
            }else if ([_model.refundStatus integerValue] == 2){
                cell.refundImg.hidden = NO;
                cell.refundImg.image = [UIImage imageNamed:@"lable_refund_end"];
            }
            cell.messageLabel.text = _model.orderDesc;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;            
            return cell;
            break;
        }
        case 1:
        {
            StoreInfoTableViewCell *cell;
            cell = (StoreInfoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"StoreInfoTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.storeName.text = _model.branchName;
            switch ([_model.deliverType intValue]) {
                case 1:
                    cell.messageLabel.text = @"营业时间:";
                    cell.sellTime.text = [NSString stringWithFormat:@"%@-%@",_model.workStart?_model.workStart:@"",_model.workEnd?_model.workEnd:@""];
                    break;
                case 2:
                    cell.messageLabel.text = @"配送时间:";
                    cell.sellTime.text = [NSString stringWithFormat:@"%@-%@",_model.deliverStart?_model.deliverStart:@"",_model.deliverEnd?_model.deliverEnd:@""];
                    break;
                case 3:
                    cell.messageLabel.text = [NSString stringWithFormat:@"%@前下单，当天发货",_model.deliverLast?_model.deliverLast:@"17:00"];
                    cell.sellTime.hidden = YES;
                    break;
            }
            
            cell.adress.text = _model.branchAddr;
            [cell.enterBtn addTarget:self action:@selector(enterStoreDetail) forControlEvents:UIControlEventTouchUpInside];
            [cell.callBtn addTarget:self action:@selector(callStorePhone) forControlEvents:UIControlEventTouchUpInside];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]] || [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                [cell.locationBtn addTarget:self action:@selector(locationTool) forControlEvents:UIControlEventTouchUpInside];
            }else {
                cell.locationBtn.hidden = YES;
            }
            return cell;
            break;
        }
        case 2:
        {
//            InfoTableViewCell *cell;
//            cell = (InfoTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil][0];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.indentNumber.text = _model.orderCode;
//            switch ([_model.deliverType intValue]) {
//                case 1:
//                    cell.postStyle.text = @"到店取货";
//                    break;
//                case 2:
//                    cell.postStyle.text = @"送货上门";
//                    break;
//                case 3:
//                    cell.postStyle.text = @"快递";
//                    break;
//            }
//            if ([_model.payType intValue] == 1) {
//                cell.payStyle.text = @"当面支付";
//            }else {
//                cell.payStyle.text = @"在线支付";
//            }
//            cell.time.text = [NSString stringWithFormat:@"%@",_model.createStr?_model.createStr:@""];
//            cell.message.text = _model.orderDescUser;
//            cell.recieveCode.text = _model.receiveCode;
//            return cell;
            NewProInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewProInfoTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *key = proInfoArr[indexPath.row];
            NSString *des = proInfoDic[key];
            cell.key.text = key;
            cell.des.text = des;
            return cell;
            break;
        }
        case 3:
        {
            if([_model.deliverType integerValue] == 1) {
                UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
                
                return cell;
            }else {
                ReceiverTableViewCell *cell;
                cell = (ReceiverTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ReceiverTableViewCell" owner:self options:nil][0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.nameLabel.text = _model.receiver;
                cell.telLabel.text = _model.receiverTel;
                cell.addressLabel.text = [NSString stringWithFormat:@"收货地址: %@",_model.receiveAddr?_model.receiveAddr:@""];
                return cell;}
            break;
        }
        case 4:
        {
            ProTableViewCell *cell;
            cell = (ProTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ProTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UserMicroMallOrderDetailVO *vo = proArray[indexPath.row];
            setCellModel *model = [setCellModel creatSetCellModel:vo];
            //comboCount套餐商品总数
            NSInteger comboCount = 0;
            for (NSInteger index = 0; index < _model.orderComboVOs.count; index ++) {
                OrderComboVo *vo = _model.orderComboVOs[index];
                comboCount += vo.microMallOrderDetailVOs.count;
            }
            if (indexPath.row < comboCount) {
                //套餐
                model.type = CellTypeCombo;
                NSInteger comboIndex = 0;
                for (NSInteger index = 0; index < _model.orderComboVOs.count; index ++) {
                    OrderComboVo *vo = _model.orderComboVOs[index];
                    comboIndex += vo.microMallOrderDetailVOs.count;
                    if (indexPath.row == comboIndex - 1) {
                        //每个套餐的最后一个商品
                        model.type = CellTypeComboLast;
                        model.comboPrice = vo.comboPrice;
                        model.comboCount =  vo.comboAmount;
                    }
                }
            }else if (indexPath.row < comboCount + _model.microMallOrderDetailVOs.count) {
                //普通商品
                model.type = CellTypeNormal;
            }else {
                //换购商品
                model.type = CellTypeRedemption;
            }
            //储存每个index。row对应的type
            NSString *key = [NSString stringWithFormat:@"%i",indexPath.row];
            NSNumber *value = [NSNumber numberWithInteger:model.type];
            typeDic[key] = value;
            [cell setCell:model];
            return cell;
            break;
        }
        case 5:
        {
            ProPromotionTableViewCell *cell;
            cell = (ProPromotionTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"ProPromotionTableViewCell" owner:self options:nil][0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = kCFNumberFormatterRoundFloor;
            [formatter setMaximumFractionDigits:2];
            float proAmount = [_model.proAmount floatValue];
            float discountAmount = [_model.discountAmount floatValue];
            float deliverAmount = [_model.deliverAmount floatValue];
            float finalAmount = [_model.finalAmount floatValue];
            cell.allPrice.text = [NSString stringWithFormat:@"￥%@",[formatter stringFromNumber:[NSNumber numberWithFloat:proAmount]]];
//            cell.discountPrice.text = [NSString stringWithFormat:@"￥%@ + %@",[formatter stringFromNumber:[NSNumber numberWithFloat:discountAmount]],_model.branchPmt];
            cell.discountPrice.text = [NSString stringWithFormat:@"%@",_model.orderPmt?_model.orderPmt:@""];
            cell.postPrice.text = [NSString stringWithFormat:@"￥%@",[formatter stringFromNumber:[NSNumber numberWithFloat:deliverAmount]]];
            cell.finalPrice.text = [NSString stringWithFormat:@"￥%@",[formatter stringFromNumber:[NSNumber numberWithFloat:finalAmount]]];
            return cell;
            break;
        }
        default:
            return nil;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    switch (indexPath.section) {
        case 0:
            height = 60;
            break;
        case 1:
            height = [self calculateCellHeightWith:indexPath];
            break;
        case 2:
            height = 44;
            break;
        case 3:
            if([_model.deliverType integerValue] == 1) {
                height = .5;
            }else {
                height = [self calculateReceiverCellHeight];
            }
            break;
        case 4:
        {
            NSString *key = [NSString stringWithFormat:@"%i",indexPath.row];
            NSNumber *type = typeDic[key];
            switch (type.integerValue) {
                case CellTypeCombo:
                    height = 85;
                    break;
                case CellTypeComboLast:
                    height = 115;
                    break;
                case CellTypeNormal:
                {
                    UserMicroMallOrderDetailVO *vo = proArray[indexPath.row];
                    if(vo.freeBieQty){
                        if ([vo.freeBieQty intValue] > 0) {
                            height = 115;
                        }else {
                            height = 97;
                        }
                    }else{
                        height = 97;
                    }
                    
                }
                    break;
                case CellTypeRedemption:
                    height = 115;
                    break;
            }
        }
            break;
        case 5:
            height = 130;
            break;
    }
    return height;
}

- (CGFloat)calculateCellHeightWith:(NSIndexPath *)indexPath {
    static StoreInfoTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableMain dequeueReusableCellWithIdentifier:@"StoreInfoTableViewCell"];
    });
    sizingCell.storeName.text = _model.branchName;
    switch ([_model.deliverType intValue]) {
        case 1:
            sizingCell.messageLabel.text = @"营业时间:";
            sizingCell.sellTime.text = [NSString stringWithFormat:@"%@-%@",_model.workStart?_model.workStart:@"",_model.workEnd?_model.workEnd:@""];
            break;
        case 2:
            sizingCell.messageLabel.text = @"配送时间:";
            sizingCell.sellTime.text = [NSString stringWithFormat:@"%@-%@",_model.deliverStart?_model.deliverStart:@"",_model.deliverEnd?_model.deliverEnd:@""];
            break;
        case 3:
            sizingCell.messageLabel.text = @"17:00前下单，当天发货";
            sizingCell.sellTime.hidden = YES;
            break;
    }
    
    sizingCell.adress.text = _model.branchAddr;
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f,CGRectGetWidth(self.tableMain.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

-(CGFloat)calculateReceiverCellHeight {
    static ReceiverTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableMain dequeueReusableCellWithIdentifier:@"ReceiverTableViewCell"];
    });
    sizingCell.nameLabel.text = _model.receiver;
    sizingCell.telLabel.text = _model.receiverTel;
    sizingCell.addressLabel.text = [NSString stringWithFormat:@"收货地址: %@",_model.receiveAddr];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f,CGRectGetWidth(self.tableMain.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3 && [_model.deliverType integerValue] == 1) {
        return 0;
    }else {
        return 7.0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 7.0)];
    bgView.backgroundColor = [UIColor clearColor];
    
    return bgView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 4) {
        UserMicroMallOrderDetailVO *vo = proArray[indexPath.row];
        MedicineDetailViewController *medicintDetail = [[MedicineDetailViewController alloc]initWithNibName:@"MedicineDetailViewController" bundle:nil];
        medicintDetail.lastPageName = @"订单详情";
        medicintDetail.proId = vo.branchProId;
        [self.navigationController pushViewController:medicintDetail animated:YES];
    }
}

#pragma mark - pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return array[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    cancelReason = array[row];
}
#pragma mark - 其他方法
//底部倒计时
-(void)snapStart {
    snapView = [IndentSnapDownView indentSnapDownView];
    [snapView updateUI:time];
    snapView.frame = CGRectMake(0, 0.5, 60, 41.5);
    [footView addSubview:snapView];
//    if(snapTimer) {
//        dispatch_source_cancel(snapTimer);
//        snapTimer = NULL;
//    }
    snapTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(snapTimer, dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC), 1ull*NSEC_PER_SEC, DISPATCH_TIME_FOREVER);
    dispatch_source_set_event_handler(snapTimer, ^{
        time --;
        if (time >= 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [snapView updateUI:time];
            });
        }else {
            dispatch_source_cancel(snapTimer);
        }
    });
    dispatch_source_set_cancel_handler(snapTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (snapView) {
                [snapView removeFromSuperview];
            }
            //倒计时结束时，考虑到调度时间误差，主动请求操作订单
            OperateUseOrderR *modelR = [OperateUseOrderR new];
            if (QWGLOBALMANAGER.configure.userToken) {
                modelR.token = QWGLOBALMANAGER.configure.userToken;
            }
            modelR.operate = 5;
            modelR.orderId = _orderId;
            [Orders operateUserOrder:modelR success:^(OperateUseOrderModel *model) {
               
            } failure:^(HttpException *e) {
                
            }];
            //刷新订单
            [self queryOrderDetail];
        });
    });
    dispatch_resume(snapTimer);
}

//进入二维码页面
-(void)gotoCodeVC {
    OrderCodeViewController *vc = [[OrderCodeViewController alloc]initWithNibName:@"OrderCodeViewController" bundle:nil];
    vc.code = _model.orderId;
    vc.receiveCode = _model.receiveCode;
    [self.navigationController pushViewController:vc animated:YES];
}
//进入药房详情
-(void)enterStoreDetail {

    //fixed by lijian at V3.2.0
    [QWGLOBALMANAGER pushBranchDetail:_model.branchId withType:@"3" navigation:self.navigationController];
}
//拨打药房电话
-(void)callStorePhone {
    NSInteger status = [_model.orderStatus integerValue];
    if (status != 8 && status != 9 && status != 10 ) {
        [QWGLOBALMANAGER statisticsEventId:@"我的_未完成_订单详情_拨打药房电话" withLable:nil withParams:nil];
    }
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"价格总计"]=[NSString stringWithFormat:@"%@",_model.finalAmount];
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_dh" withLable:@"订单详情" withParams:tdParams];
    self.phoneCallType = PhoneCallTypeStore;
    NSArray *tels = [_model.branchMobile componentsSeparatedByString:@","];
    telArray = [NSMutableArray arrayWithArray:tels];
    [self chooseTelWithTels:tels];
}

-(void)chooseTelWithTels:(NSArray *)tels {
    UIActionSheet *telphone = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    for (int i = 0; i < tels.count ; i ++) {
        [telphone addButtonWithTitle:tels[i]];
    }
    telphone.tag = 101;
    [telphone showInView:self.view];
}

//打开导航
-(void)locationTool {
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"价格总计"]=[NSString stringWithFormat:@"%@",_model.finalAmount];
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_dw" withLable:@"订单详情" withParams:tdParams];
    
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"问药",@"quanweiios",[_model.branchLat floatValue],[_model.branchLot floatValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        return;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",[_model.branchLat floatValue],[_model.branchLot floatValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        return;
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 101) {
        if (buttonIndex != 0) {
            if (_phoneCallType == PhoneCallTypeService) {
                NSString *number = [NSString stringWithFormat:@"tel://%@",_model.serviceTel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
            }else {
                NSString *phoneNumber = telArray[buttonIndex - 1];
                NSString *number = [NSString stringWithFormat:@"tel://%@",phoneNumber];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
            }
        }
    }
}
//为下方的两个Btn设置事件
-(void)setTargetAction {
    switch ([_model.orderStatus intValue]) {
        case 1:
            cancelBtn.hidden = YES;
            [ensureBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
            ensureBtn.layer.borderColor = RGBHex(qwColor7).CGColor;
            if ([_model.payType integerValue] == 2) {//在线支付
                [ensureBtn setTitle:@"申请取消" forState:UIControlStateNormal];
                [ensureBtn addTarget:self action:@selector(applyForRefund) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [ensureBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [ensureBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
        case 2:
            cancelBtn.hidden = YES;
            [ensureBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
            ensureBtn.layer.borderColor = RGBHex(qwColor7).CGColor;
            if([_model.payType integerValue] == 1){
                [ensureBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [ensureBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
            }else {//在线支付的待配送状态是申请取消
                [ensureBtn setTitle:@"申请取消" forState:UIControlStateNormal];
                [ensureBtn addTarget:self action:@selector(applyForRefund) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
        case 3:
            if ([_model.deliverType intValue] == 2) {
                cancelBtn.hidden = YES;
                [ensureBtn setTitle:@"确认收货" forState:UIControlStateNormal];
                [ensureBtn addTarget:self action:@selector(ensureOrder) forControlEvents:UIControlEventTouchUpInside];
            }else if ([_model.deliverType intValue] == 3) {
                [cancelBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                [cancelBtn addTarget:self action:@selector(checkPost) forControlEvents:UIControlEventTouchUpInside];
                [ensureBtn addTarget:self action:@selector(ensureOrder) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
        case 6:
            if([_model.payType integerValue] == 2){//在线支付的待取货状态
                [cancelBtn setTitle:@"申请取消" forState:UIControlStateNormal];
                [cancelBtn addTarget:self action:@selector(applyForRefund) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [cancelBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
            }
            [ensureBtn addTarget:self action:@selector(ensureOrder) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            cancelBtn.hidden = YES;
            [ensureBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            [ensureBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
            ensureBtn.layer.borderColor = RGBHex(qwColor7).CGColor;
            [ensureBtn addTarget:self action:@selector(delOrderAction) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 9:
            if([_model.appraiseStatus intValue] == 1){ //评价状态
                if ([_model.deliverType intValue] == 3) {
                    [cancelBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                    [cancelBtn addTarget:self action:@selector(checkPost) forControlEvents:UIControlEventTouchUpInside];
                }else {
                    cancelBtn.hidden = YES;
                }
                [ensureBtn setTitle:@"我要评价" forState:UIControlStateNormal];
                [ensureBtn addTarget:self action:@selector(gotoComment:) forControlEvents:UIControlEventTouchUpInside];
            }else {
                cancelBtn.hidden = YES;
                if ([_model.deliverType intValue] == 3) {
                    [ensureBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                    [ensureBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
                    ensureBtn.layer.borderColor = RGBHex(qwColor7).CGColor;
                    [ensureBtn addTarget:self action:@selector(checkPost) forControlEvents:UIControlEventTouchUpInside];
                }else {
                    ensureBtn.hidden = YES;
                }
            }
            break;
        case 10:
            [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [ensureBtn setTitle:@"去付款" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
            [ensureBtn addTarget:self action:@selector(gotoPay) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            ensureBtn.hidden = YES;
            cancelBtn.hidden = YES;
            break;
    }
    
}
//取消订单
-(void)cancelOrderOpeartion {
    OperateUseOrderR *modelR = [OperateUseOrderR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    [_cancelView removeSelf];
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"价格总计"]=[NSString stringWithFormat:@"%@",_model.finalAmount];
    tdParams[@"时间"] = _model.createStr;
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_qx" withLable:@"订单详情" withParams:tdParams];
    
    modelR.operate = 2;
    modelR.cancelReason = cancelReason;
    modelR.orderId = _orderId;
    [Orders operateUserOrder:modelR success:^(OperateUseOrderModel *model) {
        if ([model.apiStatus integerValue] == 0) {
            [self queryOrderDetail];
        }else {
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.5];
        }
    } failure:^(HttpException *e) {
        
    }];
    
}

-(void)cancelOrder{
    _cancelView = [CancelAlertView cancelAlertView];
    _cancelView.picker.dataSource = self;
    _cancelView.picker.delegate = self;
    _cancelView.bkView.alpha = 0.0;
    [_cancelView.ensureBtn addTarget:self action:@selector(cancelOrderOpeartion) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [win addSubview:_cancelView];
    [UIView animateWithDuration:0.25 animations:^{
        _cancelView.bkView.alpha =0.4;
        _cancelView.picker.hidden = NO;
        _cancelView.reasonView.hidden = NO;
        
    }];
}

-(void)delOrderAction {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除订单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alertView.tag = 101;
    [alertView show];
}
//删除订单
-(void)delOrder {
    OperateUseOrderR *modelR = [OperateUseOrderR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    modelR.operate = 3;
    modelR.orderId = _orderId;
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"状态"] = @"已取消";
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_sc" withLable:@"订单详情" withParams:tdParams];
    
    [Orders operateUserOrder:modelR success:^(OperateUseOrderModel *model) {
        if ([model.apiStatus integerValue] == 0) {
            // [SVProgressHUD showSuccessWithStatus:model.apiMessage duration:.5];
            [self performSelector:@selector(popVCAction:) withObject:nil afterDelay:.5];
        }else {
             [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.5];
        }
    } failure:^(HttpException *e) {
        
    }];
    
}

-(void)ensureOrder {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您是否确认已收货？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 103;
    [alertView show];
}
//确认收货
-(void)configureOrder {
    OperateUseOrderR *modelR = [OperateUseOrderR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"价格总计"]=[NSString stringWithFormat:@"%@",_model.finalAmount];
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_qr" withLable:@"订单详情" withParams:tdParams];
    
    modelR.operate = 1;
    modelR.orderId = _orderId;
    [Orders operateUserOrder:modelR success:^(OperateUseOrderModel *model) {
        if ([model.apiStatus integerValue] == 0) {
            if ([model.apiStatus integerValue] == 0) {
                // [SVProgressHUD showSuccessWithStatus:model.apiMessage duration:.5];
                //                [self performSelector:@selector(popVCAction:) withObject:nil afterDelay:1];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"订单已经确认收货成功\n是否立即评价？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 100;
                [alertView show];
            }else {
                [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.5];
            }
        }
    } failure:^(HttpException *e) {
        
    }];
    
}

-(void)gotoPay {
    WebOrderDetailModel *model=[WebOrderDetailModel new];
    model.orderCode=_model.orderCode;
    model.orderId=_model.orderId;
    model.orderIdName=_model.branchName;
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_qfk" withLable:@"订单详情" withParams:nil];
    [QWGLOBALMANAGER jumpH5PayOrderWithOrderId:self.orderId totalPrice:_model.finalAmount isComeFrom:@"1" orderModel:model navigationController:self.navigationController];
}

-(void)applyForRefund {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"申请取消订单需联系客服热线\n%@" ,_model.serviceTel] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 102;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 100) {
        if (buttonIndex == 0) {
            [self queryOrderDetail];
        }else {
            [self gotoComment:nil];
        }
    }else if (alertView.tag == 101){
        if (buttonIndex == 1) {
            [self delOrder];
        }
    }else if (alertView.tag == 102){
        if (buttonIndex == 1) {
            NSString *number = [NSString stringWithFormat:@"tel://%@",_model.serviceTel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
            [self createRefundOrder];
        }
    }else if (alertView.tag == 103){
        if (buttonIndex == 1) {
            [self configureOrder];
        }
    }
}

//申请退款生成工单
-(void)createRefundOrder {
    OperateUseOrderR *modelR = [OperateUseOrderR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    modelR.operate = 6;
    modelR.orderId = _orderId;
    [Orders operateUserOrder:modelR success:^(OperateUseOrderModel *model) {
        if ([model.apiStatus integerValue] == 0) {
        
        }else {
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.5];
        }
    } failure:^(HttpException *e) {
        
    }];
}

//评价
-(void)gotoComment:(UIButton *)sender {
    EvaluateProductViewController *vcEva = (EvaluateProductViewController *)[[UIStoryboard storyboardWithName:@"EvaluateProduct" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"EvaluateProductViewController"];
    vcEva.orderId = _model.orderId;
    if ([_model.deliverType intValue] == 2) {
        vcEva.hasPostSpeed = YES;
    }else {
        vcEva.hasPostSpeed = NO;
    }
    __weak typeof(self) weakSelf = self;
    vcEva.refreshDetail =^{
        [weakSelf queryOrderDetail];
    };
    [self.navigationController pushViewController:vcEva animated:YES];
}

//查看物流
-(void)checkPost {
    CheckPostViewController *vc = [CheckPostViewController new];
    vc.postName = _model.expressCompany;
    vc.postNumber = _model.waybillNo;
    NSString *status;
    switch ([_model.orderStatus intValue]) {
        case 1:
            status = @"已提交";
            break;
        case 2:
            status = @"待配送";
            break;
        case 3:
            status = @"配送中";
            break;
        case 6:
            status = @"待取货";
            break;
        case 8:
            status = @"已取消";
            break;
        case 9:
            status = @"已收货";
            break;
    }
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"状态"]=status;
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_ck" withLable:@"订单详情" withParams:tdParams];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)login{
    LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    login.isPresentType = YES;
    login.parentNavgationController = self.navigationController;
    UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - networking
-(void)queryOrderDetail {
    QueryUserOrderDetailR *modelR = [QueryUserOrderDetailR new];
    modelR.orderId = _orderId;
    modelR.token = QWGLOBALMANAGER.configure.userToken?QWGLOBALMANAGER.configure.userToken:@"";
    if (snapView) {
        [snapView removeFromSuperview];
    }
    [Orders queryOrderDetail:modelR success:^(UserOrderDetialVO *model) {
        if ([model.apiStatus intValue] == 0) {
            [cancelBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            [ensureBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            self.model = model;
            if ([model.appraiseStatus integerValue] == 2) {
                self.tableMain.frame = CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height - 64);
                footView.hidden = YES;
            }else {
                self.tableMain.frame = CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height - 106);
                footView.hidden = NO;
            }
            if ([model.orderStatus integerValue] == 10 && [model.paySeconds longLongValue] > 0) {
                time = [model.paySeconds longLongValue];
                if(resume)
                    [self snapStart];
            }
            proArray = [@[] mutableCopy];
            for (OrderComboVo *vo in model.orderComboVOs) {
                [proArray addObjectsFromArray:vo.microMallOrderDetailVOs];
            }
            [proArray addObjectsFromArray:model.microMallOrderDetailVOs];
            [proArray addObjectsFromArray:model.redemptionPro];
            [self setTargetAction];
            [self.tableMain reloadData];
        }else {
            
        }
    } failure:^(HttpException *e) {
        
    }];
}
//取消订单理由
-(void)queryCancelReason {
    QueryCancelReasonR *modelR = [QueryCancelReasonR new];
    modelR.type = 1;
    [Orders queryCancelReason:modelR success:^(CancelReasonModel *model) {
        if (model.list > 0) {
            array = [NSMutableArray arrayWithArray:model.list];
            cancelReason = [array firstObject];
        }
    } failure:^(HttpException *e) {
        
    }];
}


- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotifPayStatusAlert == type) {
            self.isUp=YES;
            if([data isEqualToString:@"1"]){
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"很遗憾，您付款失败了！" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }else if ([data isEqualToString:@"2"]){
                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            }
        }

}

-(void)setModel:(UserOrderDetialVO *)model {
    _model = model;
    [self convertProInfoToDic];
    [self creatProInfoArr];
}

-(void)creatProInfoArr {
    NSInteger status = [_model.orderStatus integerValue];
    if (status != 8 && status != 9 && status != 10 ) {
        proInfoArr = @[@"订单编号",@"收货码",@"配送方式",@"支付方式",@"下单时间",@"买家留言"].mutableCopy;
    }else {
        proInfoArr = @[@"订单编号",@"配送方式",@"支付方式",@"下单时间",@"买家留言"].mutableCopy;
    }
    [self.tableMain reloadData];
}

-(void)convertProInfoToDic {
    NSString *deliver;
    switch ([_model.deliverType intValue]) {
        case 1:
            deliver = @"到店取货";
            break;
        case 2:
            deliver = @"送货上门";
            break;
        case 3:
            deliver = @"快递";
            break;
    }
    NSString *payType;
    if ([_model.payType intValue] == 1) {
        payType = @"当面支付";
    }else {
        payType = @"在线支付";
    }
    proInfoDic = @{@"订单编号":_model.orderCode,@"收货码":_model.receiveCode,@"配送方式":deliver,@"支付方式":payType,@"下单时间":_model.createStr,@"买家留言":_model.orderDescUser}.mutableCopy;
}
@end
