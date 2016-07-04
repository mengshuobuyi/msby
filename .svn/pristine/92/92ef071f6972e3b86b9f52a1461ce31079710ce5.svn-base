//
//  MyCouponDrugDetailViewController.m
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyCouponDrugDetailViewController.h"
#import "Coupon.h"
#import "CouponMyDrugTableViewCell.h"
#import "myConsultTableViewCell.h"
#import "ChatViewController.h"
#import "SVProgressHUD.h"
#import "MoreConsultViewController.h"
#import "PharmacySotreViewController.h"
#import "WebDirectViewController.h"
#import "Promotion.h"
#import "UsePromotionViewController.h"
#import "EvaluatingPromotionViewController.h"
#import "MyEvaluationViewController.h"
#import "MyCouponDrugViewController.h"
#import "LoginViewController.h"

@interface MyCouponDrugDetailViewController ()<UITableViewDataSource,UITableViewDelegate,myConsultTableViewCellDelegate,UIAlertViewDelegate>{
    
    BranchListVo *couponList;
    
    UIView *vInfo;
}

@property (strong, nonatomic) UITableView *mainTableView;

@end

@implementation MyCouponDrugDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"优惠商品";
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.mainTableView.scrollEnabled = YES;
    self.mainTableView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = view;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
}


#pragma mark - 分享功能
- (void)sharClick{
    //cj 224更改
    if(StrIsEmpty(couponList.proId) || StrIsEmpty(couponList.pid)){
        [SVProgressHUD showErrorWithStatus:@"无法分享"];
        return;
    }
    
    ShareContentModel *modelShare = [[ShareContentModel alloc] init];
    modelShare.typeShare    = ShareTypeMyDrug;
    NSArray *arrParams      = @[couponList.proId ,couponList.pid];
    modelShare.shareID      = modelShare.shareID = [arrParams componentsJoinedByString:SeparateStr];
    modelShare.title        = couponList.promotionTitle;
    modelShare.content      = couponList.desc;
    modelShare.imgURL       = couponList.imgUrl;
    
    ShareSaveLogModel *modelR = [ShareSaveLogModel new];
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    if(mapInfoModel) {
        modelR.city = mapInfoModel.city;
        modelR.province = mapInfoModel.province;
    }else{
        modelR.city = @"苏州市";
        modelR.province = @"江苏省";
    }
    modelR.shareObj = @"2";
    modelR.shareObjId = couponList.pid;
    modelShare.modelSavelog = modelR;
    [self popUpShareView:modelShare]; 

    
}

#pragma mark - 去消费按钮TableFooterView
- (void)setupFootView{
    
    if(([couponList.status intValue] == 1 || [couponList.status intValue] == 2) && couponList.canUserShare){
        if (couponList.open||couponList.canUserShare) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(sharClick)];
            self.navigationItem.rightBarButtonItem = item;
        }else{
        //非公开优惠商品不能分享
            self.navigationItem.rightBarButtonItem =nil;
        }
     
    }
    
    if([couponList.status intValue] == 1){
        self.mainTableView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H );
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, APP_H - NAV_H - 50, APP_W, 150)];
        view.backgroundColor = RGBHex(qwColor11);
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 50, APP_W - 30, 40)];
        btn.backgroundColor = RGBHex(qwColor2);
        [btn setTitle:@"去使用(到店消费)" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4.5f;
        [btn addTarget:self action:@selector(useDrug:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        self.mainTableView.tableFooterView = view;
        
    }
}

#pragma mark - 去使用到店消费
- (void)useDrug:(id)sender{
    
    if(!QWGLOBALMANAGER.loginStatus){
        [SVProgressHUD showErrorWithStatus:@"先登录"];
        return;
    }
    
    //if(couponList.proDrugId== nil || [couponList.proDrugId isEqualToString:@""]){
    if(StrIsEmpty(couponList.proDrugId)){
        [SVProgressHUD showErrorWithStatus:@"proDrugId为空"];
        return;
    }
    
    CreateVerifyCodeModelR *modelR = [CreateVerifyCodeModelR new];
    modelR.proDrugId = couponList.proDrugId;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    
    [Promotion createVerifyCode:modelR success:^(id obj) {
        
        OrderCreateVo *vo = obj;
        if([vo.apiStatus intValue] == 1 || [vo.apiStatus intValue] == 2){
            [SVProgressHUD showErrorWithStatus:vo.apiMessage];
            return;
        }else{
            UsePromotionViewController *usePromotionView = [[UsePromotionViewController alloc]initWithNibName:@"UsePromotionViewController" bundle:nil];
            usePromotionView.orderId = vo.orderId;
            usePromotionView.verifyCode = vo.verifyCode;
            [self.navigationController pushViewController:usePromotionView animated:YES];
        }
        
    } failure:^(HttpException *e) {
        
        
        
    }];
}

#pragma mark - HTTPRequest
- (void)loadData{
    
    myCouponDrugDetailModelR *modelR = [myCouponDrugDetailModelR new];
    
    modelR.proDrugId = self.proDrugId;
    
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        if(mapInfoModel){
            modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
            modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
            modelR.city = mapInfoModel.city;
        }else{
            modelR.longitude = @(120.730435);
            modelR.latitude = @(31.273391);
            modelR.city = @"苏州";
        }
    }];
    
    [Coupon myCouponDrugDetail:modelR success:^(id obj) {
        
        couponList = obj;
        
        if([couponList.status intValue] != 3 && [couponList.apiStatus intValue] != 0){
            
            if([couponList.apiStatus intValue] == 2){
                
                [self showMyInfoView:@"对不起，该优惠已下架" image:@"ic_img_cry" tag:0];
            }else{
                [self showMyInfoView:couponList.apiMessage image:@"ic_img_cry" tag:0];
            }
            return;
        }
        
        if([couponList.status intValue] == 1 && [couponList.frozen intValue] == 1){
            [self showMyInfoView:[NSString stringWithFormat:@"很抱歉，您的%@%@优惠已下架~",couponList.proName,couponList.label] image:@"ic_img_cry" tag:0];
            return;
        }
        
        [self setupFootView];
        
        [self.mainTableView reloadData];
        
    } failure:^(HttpException *e) {
        
        [SVProgressHUD showErrorWithStatus:e.Edescription];
    }];
}

#pragma mark - 更多按钮点击事件
- (void)moreConsult:(id)sender{ 
    MoreConsultViewController *moreConsult = [[MoreConsultViewController alloc]init];
    
    moreConsult.consultType = Enum_Consult_ComeFromUserCenterPromotion;
    moreConsult.pid = couponList.pid;
    
    [self.navigationController pushViewController:moreConsult animated:YES];
}

#pragma mark - 打电话按钮点击事件
- (void)takePhone:(NSString *)telNumber{
    
    //if(telNumber && ![telNumber isEqualToString:@""]){
    if(!StrIsEmpty(telNumber)){
        [[[UIAlertView alloc]initWithTitle:@"呼叫" message:telNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

#pragma mark - 聊天按钮点击事件
- (void)takeTalk:(NSString *)branchId name:(NSString *)branchName{
    ChatViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ChatViewController"];
    consultViewController.sendConsultType = Enum_SendConsult_Common;
    consultViewController.branchId = branchId;
    consultViewController.branchName = branchName;
    [self.navigationController pushViewController:consultViewController animated:YES];
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        BranchVo *vo = couponList.branchVoList[0];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",vo.tel]]];
    }
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if([couponList.status intValue] == 3){
        return 2;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0){
        return 0;
    }
    if(section == 1){
        if(couponList.branchVoList.count == 0){
            return 0;
        }
        return 41.5;
    }
    if(section == 2){
        return 7;
    }
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
  
    if(section == 1){
        if([couponList.status intValue] == 2){
            return 0;
        }else if([couponList.branchCount intValue] > 1){
            return 38;
        }else{
            return 0;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(section == 1){
        if(couponList.branchVoList.count == 0){
            return nil;
        }
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 35)];
        headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, 200, 21)];
        label.font = fontSystem(14.0);
        label.textColor = RGBHex(qwColor8);

        if(couponList && couponList.branchCount){
            label.text = [NSString stringWithFormat:@"适用药房 (%@)",couponList.branchCount];
        }else{
            label.text = @"适用药房";
        }
        if([couponList.status intValue] == 2){
            label.text = @"消费药房";
        }
        [headView addSubview:label];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height - 0.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [headView addSubview:line];
        
        return headView;
    }else{
    
        UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 7)];
        seperator.backgroundColor = RGBHex(qwColor11);
        return seperator;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if(section == 1){
        if([couponList.branchCount intValue] <= 1){
            return nil;
        }
        if([couponList.status intValue] != 2){
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 38)];
        footView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [footView addSubview:line];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 21)];
        label.center = footView.center;
        label.font = fontSystem(14.0f);
        label.textColor = RGBHex(qwColor8);
        label.text = @"查看更多";
        label.textAlignment = NSTextAlignmentCenter;
        [footView addSubview:label];
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, APP_W, 38)];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(moreConsult:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btn];
        
        return footView;
        }else{
            return nil;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(couponList == nil){
        return 0;
    }else if(section == 1){
        return couponList.branchVoList.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch(indexPath.section){
        case 0:
            return [CouponMyDrugTableViewCell getCellHeight:nil];
            break;
        case 1:
            return [myConsultTableViewCell getCellHeight:nil];
            break;
        case 2:
            return 38;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        static NSString *Identifier = @"CouponMyDrugTableViewCell";
        CouponMyDrugTableViewCell *cell = (CouponMyDrugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        if(cell == nil){
            UINib *nib = [UINib nibWithNibName:@"CouponMyDrugTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Identifier];
            cell = (CouponMyDrugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        }
        MyDrugVo *model = [MyDrugVo new];
        
        model.proName = couponList.proName;
        model.spec = couponList.spec;
        model.label = couponList.label;
        model.imgUrl = couponList.imgUrl;
        model.beginTime = couponList.beginTime;
        model.endTime = couponList.endTime;
        model.expiredSoon = couponList.expiredSoon;
        model.comment = couponList.comment;
        
        cell.drugStatus = [couponList.status intValue];
        [cell setCell:model];
        
        if(cell.drugStatus == 2){
            cell.dateLabel.text = [NSString stringWithFormat:@"消费时间:%@",couponList.useTime];
        }
        
        if([couponList.status intValue] == 1 && [couponList.expiredSoon intValue] == 1){
            cell.expiredSoonImageView.hidden = YES;
        }
        
        return cell;
    }
    if(indexPath.section == 1){
        static NSString *Identifier = @"myConsultTableViewCell";
        myConsultTableViewCell *cell = (myConsultTableViewCell *)[self.tableMain dequeueReusableCellWithIdentifier:Identifier];
        if(cell == nil){
            UINib *nib = [UINib nibWithNibName:@"myConsultTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:Identifier];
            cell = (myConsultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
        }
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height - 0.5, APP_W, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [cell addSubview:line];
        
        BranchVo *vo = couponList.branchVoList[indexPath.row];
        cell.cellDelegate = self;
        cell.branchName.text = vo.branchName;
        cell.address.text = vo.address;
        cell.distance.text = vo.distance;
        if ([vo.online intValue] == 0) {
            cell.chatEnable = NO;
            cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisorygray"];
        }else{
            cell.branchImage.image = [UIImage imageNamed:@"btn_img_advisory"];
            cell.chatEnable = YES;
        }
        
        [cell.starView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
        float star = [vo.star floatValue]/2;
        [cell.starView displayRating:star];
        
        //if(vo.tel == nil || [vo.tel isEqualToString:@""]){
        if(StrIsEmpty(vo.tel)){
            [cell.phoneImage setImage:[UIImage imageNamed:@"btn_img_phonegray"]];
        }else{
            [cell.phoneImage setImage:[UIImage imageNamed:@"btn_img_phone"]];
        }
        
        cell.branchId = vo.branchId;
        cell.telNumber = vo.tel;
        
        return cell;
    }
    if(indexPath.section == 2){
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 8.5, 200, 21);
        label.text = @"";
        label.textColor = RGBHex(qwColor6);
        label.font = fontSystem(16.0f);
        [label removeFromSuperview];
        
        if([couponList.status intValue] == 1){
            label.text = @"优惠细则";
        }
        if([couponList.status intValue] == 2){
            if([couponList.comment intValue] == 0){
                label.text = @"去评价";
            }else{
                label.text = @"";
                label.text = @"我的评价";
                RatingView *ratView = [[RatingView alloc]initWithFrame:CGRectMake(90, 13.5, 80, 21)];
                ratView.userInteractionEnabled = NO;
                [ratView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
                float star = [couponList.star floatValue]/2;
                [ratView displayRating:star];
                [cell addSubview:ratView];
            }
            
        }
        [cell addSubview:label];
        if([couponList.status intValue] == 3){
            return nil;
        }
        UIImageView *im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arr_right"]];
        cell.accessoryView = im;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0){
        //进入药品详情
        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = mapInfoModel;
            modelDrug.proDrugID = couponList.proId;
            modelDrug.promotionID = couponList.pid;
//            modelDrug.showDrug = @"0";
            WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//            modelLocal.title = @"药品详情";
            modelLocal.modelDrug = modelDrug;
            modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            [self.navigationController pushViewController:vcWebMedicine animated:YES];
            
        }];
    }
    if(indexPath.section == 1){
        //进入药房详情
        BranchVo *model = couponList.branchVoList[indexPath.row];
        
        PharmacySotreViewController *VC = [[PharmacySotreViewController alloc]init];
        VC.branchId = model.branchId;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if(indexPath.section == 2){
        if([couponList.status intValue] == 1){
            //优惠细则
            WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            
            WebCouponConditionModel *modelCondition = [[WebCouponConditionModel alloc] init];
            modelCondition.couponId = couponList.pid;
            modelCondition.type = @"2";
            
            WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
            modelLocal.modelCondition = modelCondition;
            modelLocal.typeLocalWeb = WebLocalTypeCouponCondition;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            
            [self.navigationController pushViewController:vcWebMedicine animated:YES];
        }
        if([couponList.status intValue] == 2 && ![couponList.orderId isEqualToString:@""]){
            if([couponList.comment intValue] == 0){
                //去评价
                EvaluatingPromotionViewController *evaluatingPromotionView = [[EvaluatingPromotionViewController alloc]initWithNibName:@"EvaluatingPromotionViewController" bundle:nil];
                evaluatingPromotionView.didPopToRootView = NO;
                evaluatingPromotionView.star = 0.0;
                evaluatingPromotionView.orderId = couponList.orderId;
                BranchVo *model = couponList.branchVoList[indexPath.row];
                evaluatingPromotionView.branchName = model.branchName;
                [self.navigationController pushViewController:evaluatingPromotionView animated:YES];
                
            }else{
                //我的评价
                MyEvaluationViewController *myEvaluationView = [[MyEvaluationViewController alloc]initWithNibName:@"MyEvaluationViewController" bundle:nil];
                myEvaluationView.orderId = couponList.orderId;
                [self.navigationController pushViewController:myEvaluationView animated:YES];
            }
        }
        if([couponList.status intValue] == 3){
            return;
        }
    }
    
}

#pragma mark - 优惠过期/冻结UI
-(void)showMyInfoView:(NSString *)text image:(NSString*)imageName tag:(NSInteger)tag
{
    UIImage * imgInfoBG = [UIImage imageNamed:imageName];
    
    
    if (vInfo==nil) {
        vInfo = [[UIView alloc]initWithFrame:self.view.bounds];
        vInfo.backgroundColor = RGBHex(qwColor11);
    }
    
    vInfo.frame = self.view.bounds;
    
    for (id obj in vInfo.subviews) {
        [obj removeFromSuperview];
    }
    
    UIImageView *imgvInfo;
    UILabel* lblInfo;
    
    imgvInfo=[[UIImageView alloc]init];
    [vInfo addSubview:imgvInfo];
    
    lblInfo = [[UILabel alloc]init];
    lblInfo.numberOfLines=0;
    lblInfo.font = fontSystem(kFontS4);
    lblInfo.textColor = RGBHex(qwColor8);//0x89889b 0x6a7985
    lblInfo.textAlignment = NSTextAlignmentCenter;
    [vInfo addSubview:lblInfo];
    
    UIButton *btnClick = [[UIButton alloc] initWithFrame:vInfo.bounds];
    btnClick.tag=tag;
    [btnClick addTarget:self action:@selector(viewInfoClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [vInfo addSubview:btnClick];
    
    
    float vw=CGRectGetWidth(vInfo.bounds);
    
    CGRect frm;
    frm=RECT((vw-imgInfoBG.size.width)/2,45.0f, imgInfoBG.size.width, imgInfoBG.size.height);
    imgvInfo.frame=frm;
    imgvInfo.image = imgInfoBG;
    
    float lw=vw-40*2;
    float lh=(imageName!=nil)?CGRectGetMaxY(imgvInfo.frame) + 24:40;
    CGSize sz = [QWGLOBALMANAGER getTextSizeWithContent:text WithUIFont:fontSystem(kFontS1) WithWidth:lw];
    frm=RECT((vw-lw)/2, 67.0f + imgInfoBG.size.height, lw,sz.height);
    lblInfo.frame=frm;
    lblInfo.text = text;
    
    UIButton *checkButton = [[UIButton alloc]initWithFrame:CGRectMake(APP_W - 120, lblInfo.frame.origin.y + lblInfo.frame.size.height + 52, 100, 21) ];
    checkButton.titleLabel.font = fontSystem(kFontS4);
    [checkButton setTitle:@"查看我的优惠" forState:UIControlStateNormal];
    [checkButton setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(pushToMyCoupon:) forControlEvents:UIControlEventTouchUpInside];
    [vInfo addSubview:checkButton];
    
    [self.view addSubview:vInfo];
    [self.view bringSubviewToFront:vInfo];
}
#pragma mark - 移除优惠过期/冻结UI
- (void)removeMyInfoView{
    
    if(vInfo != nil){
        [vInfo removeFromSuperview];
    }
}
#pragma mark - 优惠过期/冻结UI进入我的优惠商品
- (void)pushToMyCoupon:(id)sender{
    
    if(QWGLOBALMANAGER.loginStatus){
        
        for(UIViewController *view in self.navigationController.viewControllers){
            
            if([view isKindOfClass:[MyCouponDrugViewController class]]){
                [self.navigationController popToViewController:view animated:YES];
                return;
            }
        }
        
        MyCouponDrugViewController *myCouponQuan = [[MyCouponDrugViewController alloc]init];
        [self.navigationController pushViewController:myCouponQuan animated:YES];
        
    }else{
        LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginView animated:YES];
    }
    
}

#pragma mark - popViewController
- (void)popVCAction:(id)sender{
    [super popVCAction:sender];
    
}

@end
