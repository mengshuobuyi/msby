//
//  PharmacyDetailViewController.m
//  wenyao
//
//  Created by xiezhenghong on 14-10-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "PharmacyDetailViewController.h"
#import "AddNewMedicineViewController.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "UIButton+WebCache.h"

#import "Drug.h"
#import "DrugModel.h"
#import "DrugModelR.h"
#import "PharmacyCell.h"
#import "CouponPromotionTableViewCell.h"

#import "FamilyMedicine.h"
#import "FamilyMedicineCell.h"
#import "FamilyMedicineModel.h"

#import "WebDirectViewController.h"

#import "PromotionDrugDetailViewController.h"
@interface PharmacyDetailViewController ()<UIScrollViewDelegate>
{
    NSArray *similarDrugArr;
}
@property (nonatomic, strong) UIScrollView      *subScrollView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSMutableArray    *similarDrugList;
@property (nonatomic, assign) BOOL              editPharmacy;
@property (nonatomic, assign) BOOL              didExpand;

@end

@implementation PharmacyDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"用药详情";
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
        return;
    }
    self.noDataView.hidden = YES;
    similarDrugArr = [NSMutableArray array];
    [self subViewDidLoad];
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self subViewDidLoad];
    }
}


- (void)subViewDidLoad{
    
    self.similarDrugList = [NSMutableArray arrayWithCapacity:15];
     [self initCacheUI];
    [self queryPharmacyDetail];
    [self querySimilarDrug];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePharmacy) name:PHARMACY_NEED_UPDATE object:nil];
 
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    lblTitle.font = [UIFont systemFontOfSize:18.0f];
    lblTitle.text = @"用药详情";
    [lblTitle setFont:font(kFont2, kFontS2)];
    lblTitle.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = lblTitle;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 39.5, APP_W - 20, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
//    [self.effectView addSubview:line];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height - 0.5, APP_W, 0.5)];
    line1.backgroundColor = RGBHex(qwColor10);
    [self.headerView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line2.backgroundColor = RGBHex(qwColor10);
//    [self.effectView addSubview:line2];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line5.backgroundColor = RGBHex(qwColor10);
    [self.footerView addSubview:line5];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(10, 40, APP_W - 20, 0.5)];
    line4.backgroundColor = RGBHex(qwColor10);
    [self.footerView addSubview:line4];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PHARMACY_NEED_UPDATE object:nil];
}

- (void)updatePharmacy
{
    [self initCacheUI];
    [self queryPharmacyDetail];
}

//cell的收缩高度
- (CGFloat)calculateCollapseHeigtOffsetWithFontSize:(UIFont *)font withTextSting:(NSString *)text
{
    CGSize adjustSize = //[text sizeWithFont:fontSize constrainedToSize:CGSizeMake(294, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        [GLOBALMANAGER sizeText:text font:font constrainedToSize:CGSizeMake(294, 1000)];
    if(adjustSize.height > 90.0f)
    {
        if (self.didExpand) {
            return adjustSize.height;
        } else {
            return 90.0f;
        }
    }else{
        return adjustSize.height;//0;
    }
}

- (BOOL)shouldAddExpandView:(NSString *)strProductEffect withFont:(UIFont *)font
{
    CGSize adjustSize = 
        [GLOBALMANAGER sizeText:strProductEffect font:font constrainedToSize:CGSizeMake(294, 1000)];
    if (adjustSize.height > 90.0f) {
        return YES;
    } else {
        return NO;
    }
}

- (void)initCacheUI
{
    self.titleLabel.text = self.boxModel.productName;
//    if(self.boxModel.source && ![self.boxModel.source isEqualToString:@""])
//    {
////        self.sourceLabel.text = self.boxModel.source;
//    }else{
////        self.sourceTitleLabel.hidden = YES;
////        self.sourceLabel.hidden = YES;
////        self.headerView.frame = CGRectMake(0, 0, APP_W, 120);
//    }
    self.useNameLabel.text = self.boxModel.useName;
    if(!self.boxModel.proId)
    {
        self.OTCImage.hidden = YES;
        self.OTCLabel.hidden = YES;
//        self.sourceTitleLabel.hidden = YES;
//        self.sourceLabel.hidden = YES;
//        self.effectView.hidden = YES;
//        self.headerView.frame = CGRectMake(0, 0, APP_W, 90);
    }
    NSString *useName = self.boxModel.useName;
    if(!useName)
    {
        useName = @"";
    }
    self.useNameLabel.text = [NSString stringWithFormat:@"使用者:  %@",useName];
    

    
//    if(_boxModel.useName && ![_boxModel.useName isEqualToString:@""]) {
        NSString *str1 = nil;//用法
        NSString *str2 = nil;//用量
        NSString *str3 = nil;//次数
        if(_boxModel.useMethod){
            str1 = _boxModel.useMethod;
            if([str1 isEqualToString:@""]) {
                str1 = nil;
            }
        }
        //第二行填满
        //if(_boxModel.perCount && ![_boxModel.perCount isEqualToString:@""] && [_boxModel.perCount integerValue] != -99 && _boxModel.unit && ![_boxModel.unit isEqualToString:@""]){
        if(!StrIsEmpty(_boxModel.perCount) && [_boxModel.perCount integerValue] != -99 && !StrIsEmpty(_boxModel.unit)){
            str2 = [NSString stringWithFormat:@"一次%@%@",_boxModel.perCount,_boxModel.unit];
            if([str2 isEqualToString:@""]) {
                str2 = nil;
            }
        }
        //第三行填满
        if(_boxModel.intervalDay && _boxModel.drugTime && [_boxModel.intervalDay integerValue] != -99 && [_boxModel.drugTime integerValue] != -99){
            NSUInteger intervalDay = [_boxModel.intervalDay integerValue];
            if(intervalDay == 0) {
//                str3 = @"即需即用";
            }else{
                str3 = [NSString stringWithFormat:@"%@日%@次",_boxModel.intervalDay,_boxModel.drugTime];
                if([str3 isEqualToString:@""]) {
                    str3 = nil;
                }
            }
        }
        
        if(str1)
            self.useageLabel.text = [NSString stringWithFormat:@"%@",str1];
        if(str2)
            self.useageLabel.text = [NSString stringWithFormat:@"%@",str2];
        if(str3)
            self.useageLabel.text = [NSString stringWithFormat:@"%@",str3];
        if(str1 && str2)
            self.useageLabel.text = [NSString stringWithFormat:@"%@，%@",str1,str2];
        if(str1 && str3)
            self.useageLabel.text = [NSString stringWithFormat:@"%@，%@",str1,str3];
        if(str2 && str3)
            self.useageLabel.text = [NSString stringWithFormat:@"%@，%@",str2,str3];
        if(str1 && str2 && str3)
            self.useageLabel.text = [NSString stringWithFormat:@"%@，%@，%@",str1,str2,str3];
        if([self.useageLabel.text isEqualToString:@""]) {
            self.useageLabel.text = @"请完善用法用量";
        }
        if(!str1 && !str2 && !str3) {
            self.useageLabel.text = @"请完善用法用量";
        }
//    }else{
//        self.useageLabel.text = @"用法用量请参考药品详情";
//    }
    
    
//    CGRect rect = self.effectView.frame;
//    rect.origin.y = self.headerView.frame.origin.y + self.headerView.frame.size.height + 10;
    //if (self.boxModel.productEffect && ![self.boxModel.productEffect isEqualToString:@""]) {
    if(!StrIsEmpty(self.boxModel.productEffect)){
        CGFloat heightCalculate = [self calculateCollapseHeigtOffsetWithFontSize:[UIFont systemFontOfSize:14.0f] withTextSting:self.boxModel.productEffect];
        
//        self.effectLabel.frame = CGRectMake(self.effectLabel.frame.origin.x, 55, self.effectLabel.frame.size.width, heightCalculate);
//        self.effectView.frame = CGRectMake(self.effectView.frame.origin.x, self.effectView.frame.origin.y, self.effectView.frame.size.width, 108 + heightCalculate + 14);

        if ([self shouldAddExpandView:self.boxModel.productEffect withFont:[UIFont systemFontOfSize:14.0f]]) {
//            rect.size.height = self.effectLabel.frame.origin.y + self.effectLabel.frame.size.height + 20.0f;
//            self.expandButton.hidden = NO;
        } else {
//            rect.size.height = self.effectLabel.frame.origin.y + self.effectLabel.frame.size.height + 19.0f;
//            self.expandButton.hidden = YES;
        }
//        self.effectView.frame = rect;
//        self.effectView.hidden = NO;
    } else {
//        self.effectView.hidden = YES;
//        rect.size.height = 0;
//        self.effectView.frame = rect;
    }
    
//    rect = self.footerView.frame;
//    rect.origin.y = self.effectView.frame.origin.y + self.effectView.frame.size.height + 10;
//    self.footerView.frame = rect;
}

- (void)decideLogo
{
    NSString *signcode = self.boxModel.signCode;
    NSString *recipeString = nil;
    CGFloat offsetX = 15.0f;
    CGFloat offsetXOTCIMG = 8.0f;
    if([signcode isEqualToString:@"1a"])
    {
        self.OTCImage.image = [UIImage imageNamed:@"处方药.png"];
        self.OTCImage.frame = CGRectMake(offsetX , self.OTCImage.frame.origin.y , 20, 14);
        self.OTCLabel.text = @"处方药";
        [self.OTCImage sizeToFit];
        self.OTCLabel.frame =CGRectMake(offsetXOTCIMG +self.OTCImage.frame.size.width +self.OTCImage.frame.origin.x, self.OTCImage.frame.origin.y , 20, 14);
        recipeString = @"西药";
    }else if([signcode isEqualToString:@"1b"]){
        self.OTCImage.frame = CGRectMake(offsetX , self.OTCImage.frame.origin.y , 20, 14);
        self.OTCImage.image = [UIImage imageNamed:@"处方药.png"];
        self.OTCLabel.text = @"处方药";
        [self.OTCImage sizeToFit];
        self.OTCLabel.frame =CGRectMake(offsetXOTCIMG +self.OTCImage.frame.size.width +self.OTCImage.frame.origin.x, self.OTCImage.frame.origin.y , 20, 14);
//        DDLogVerbose(@"")
        recipeString = @"中成药";
    }else if([signcode isEqualToString:@"2a"]){
        self.OTCImage.frame = CGRectMake(offsetX, self.OTCImage.frame.origin.y, 51, 20);
        self.OTCImage.image = [UIImage imageNamed:@"otc-甲类.png"];
        self.OTCLabel.text = @"甲类OTC非处方药";
        [self.OTCImage sizeToFit];
        self.OTCLabel.frame =CGRectMake(offsetXOTCIMG +self.OTCImage.frame.size.width +self.OTCImage.frame.origin.x, self.OTCImage.frame.origin.y , 20, 14);
        recipeString = @"西药";
    }else if([signcode isEqualToString:@"2b"]){
        self.OTCImage.frame = CGRectMake(offsetX, self.OTCImage.frame.origin.y, 51, 20);
        self.OTCImage.image = [UIImage imageNamed:@"otc-甲类.png"];
        self.OTCLabel.text = @"甲类OTC非处方药";
        [self.OTCImage sizeToFit];
        self.OTCLabel.frame =CGRectMake(offsetXOTCIMG +self.OTCImage.frame.size.width +self.OTCImage.frame.origin.x, self.OTCImage.frame.origin.y , 20, 14);
        recipeString = @"中成药";
    }
    else if ([signcode isEqualToString:@"3a"]){
        self.OTCImage.frame = CGRectMake(offsetX,  self.OTCImage.frame.origin.y, 51, 20);
        self.OTCImage.image = [UIImage imageNamed:@"otc-乙类.png"];
        self.OTCLabel.text = @"乙类OTC非处方药";
        [self.OTCImage sizeToFit];
        self.OTCLabel.frame =CGRectMake(offsetXOTCIMG +self.OTCImage.frame.size.width +self.OTCImage.frame.origin.x, self.OTCImage.frame.origin.y , 20, 14);
        recipeString = @"西药";
    }else if([signcode isEqualToString:@"3b"]) {
        self.OTCImage.frame = CGRectMake(offsetX, self.OTCImage.frame.origin.y, 51, 20);
        self.OTCImage.image = [UIImage imageNamed:@"otc-乙类.png"];
        self.OTCLabel.text = @"乙类OTC非处方药";
        [self.OTCImage sizeToFit];
        self.OTCLabel.frame =CGRectMake(offsetXOTCIMG +self.OTCImage.frame.size.width +self.OTCImage.frame.origin.x, self.OTCImage.frame.origin.y , 20, 14);
        recipeString = @"中成药";
    }else if([signcode isEqualToString:@"4c"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"定型包装中药饮片";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"4d"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"散装中药饮片";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"5"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"保健食品";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"6"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"食品";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"7"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"械字号一类";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"8"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"械字号二类";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"10"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"消字号";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"11"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"妆字号";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"12"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"无批准号";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"13"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"其他";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else if([signcode isEqualToString:@"9"]) {
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"械字号三类";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }else{
        self.OTCImage.hidden = YES;
        self.OTCLabel.text = @"自定义用药";
        self.OTCLabel.frame = CGRectMake(15, self.OTCLabel.frame.origin.y, self.OTCLabel.frame.size.width, self.OTCLabel.frame.size.height);
    }
    if(recipeString)
    {
        [self.OTCLabel sizeToFit];
             self.recipeImage.frame = CGRectMake(self.OTCLabel.frame.origin.x + offsetXOTCIMG+self.OTCLabel.frame.size.width, self.recipeImage.frame.origin.y, self.recipeImage.frame.size.width, self.recipeImage.frame.size.height);
        if([recipeString isEqualToString:@"西药"]) {
            self.recipeImage.image = [UIImage imageNamed:@"西药.png"];
        }else{
            self.recipeImage.image = [UIImage imageNamed:@"中成药-1.png"];
        }
        self.recipeLabel.text = recipeString;
                self.recipeLabel.frame = CGRectMake(self.recipeImage.frame.origin.x + offsetXOTCIMG+self.recipeImage.frame.size.width, self.recipeLabel.frame.origin.y, self.recipeLabel.frame.size.width, self.recipeLabel.frame.size.height);
    }

}
- (void)queryPharmacyDetail
{
    GetBoxProductDetailR *getBoxProductDetailR = [GetBoxProductDetailR new];
    getBoxProductDetailR.boxId = self.boxModel.boxId;
    
    [Box GetBoxProductDetailWithParams:getBoxProductDetailR success:^(id productDetailModel) {
        GetBoxProductDetailModel *productModel = (GetBoxProductDetailModel *)productDetailModel;
        self.boxModel.type = productModel.type;
        self.boxModel.productEffect = productModel.productEffect;
        self.boxModel.signCode = productModel.signCode;
//        self.effectLabel.text = self.boxModel.productEffect;
        [self initCacheUI];
        [self decideLogo];
    } failure:NULL];
//
//    MedicineDetailR *medic  Id = self.boxModel.boxId;;
//    [FamilyMedicine medicineDetail:medicineDetailR success:^(id productDetailModel) {
//        GetBoxProductDetailModel *productModel = (GetBoxProductDetailModel *)productDetailModel;
//        self.boxModel.type = productModel.type;
//        self.boxModel.productEffect = productModel.productEffect;
//        self.boxModel.signCode = productModel.signCode;
//        self.effectLabel.text = self.boxModel.productEffect;
//        [self initCacheUI];
//        [self decideLogo];
//    } failure:^(HttpException *e) {
//        
//    }];
}


- (void)popVCAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if(self.changeMedicineInformation && self.editPharmacy)
    {
        self.changeMedicineInformation(self.boxModel);
    }
}


- (void)querySimilarDrug
{
    if(!self.boxModel.proId)
        return;
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        if (mapInfoModel) {
            SimilarDrugsR *similarDrugR = [SimilarDrugsR new];
            similarDrugR.proId = self.boxModel.proId;
            similarDrugR.currPage = @"1";
            similarDrugR.pageSize = @"100";
            similarDrugR.province = mapInfoModel.province;
            similarDrugR.city = mapInfoModel.city;
            [Drug similarDrugs:similarDrugR Success:^(id DFModel) {
                SimilarDrugsModel *model = (SimilarDrugsModel *)DFModel;
                similarDrugArr = model.list;
                if (similarDrugArr.count >0) {
                    self.noDataView.hidden = YES;
                }else
                {
                    self.noDataView.hidden = NO;
                }
                [self.tableviewSim reloadData];
            } failure:^(HttpException *e) {
                
            }];
        }else
        {
            SimilarDrugsR *similarDrugR = [SimilarDrugsR new];
            similarDrugR.proId = self.boxModel.proId;
            similarDrugR.currPage = @"1";
            similarDrugR.pageSize = @"100";
            similarDrugR.province = @"江苏省";
            similarDrugR.city = @"苏州市";
            [Drug similarDrugs:similarDrugR Success:^(id DFModel) {
                SimilarDrugsModel *model = (SimilarDrugsModel *)DFModel;
                similarDrugArr = model.list;
                if (similarDrugArr.count >0) {
                    self.noDataView.hidden = YES;
                }else
                {
                    self.noDataView.hidden = NO;
                }
                [self.tableviewSim reloadData];
            } failure:^(HttpException *e) {
                
            }];
        }
    }];
   
    
}


- (IBAction)pushIntoMedicineDetail:(UIButton *)sender
{
    if(sender.tag > 1000) {
        SimilarDrugModel *similarDrugModel = self.similarDrugList[sender.tag - 1000];
        [self pushToDrugDetailWithDrugID:similarDrugModel.proId promotionId:@""];
    }else{
        [self pushToDrugDetailWithDrugID:self.boxModel.proId promotionId:@""];
    }
}

- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID{
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
//    modelDrug.showDrug = @"0";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//    modelLocal.title = @"药品详情";
    modelLocal.modelDrug = modelDrug;
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}


- (IBAction)medcineDetail:(id)sender {
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
        modelDrug.modelMap = mapInfoModel;
        modelDrug.proDrugID = self.boxModel.proId;
        modelDrug.promotionID = @"";
//        modelDrug.showDrug = @"0";
        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//        modelLocal.title = @"药品详情";
        modelLocal.modelDrug = modelDrug;
        modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
        [vcWebMedicine setWVWithLocalModel:modelLocal];
        [self.navigationController pushViewController:vcWebMedicine animated:YES];
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
        return [CouponPromotionTableViewCell getCellHeight:nil];
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return similarDrugArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SimpleProductWithPromotionVOModel *vo = [similarDrugArr objectAtIndex:indexPath.row];
//    PharmacyCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"PharmacyCell"];
//
//     [cell setCell:simpleProductWithPromotionVOModel];

    
    CouponPromotionTableViewCell *cell = (CouponPromotionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CouponPromotionTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    [cell.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    cell.proName.text = vo.proName;
    cell.spec.text = vo.spec;
    cell.factoryName.text = vo.factory;
    cell.label.text = vo.label;
    if([vo.gift intValue] == 0){
        [cell.gift removeFromSuperview];
    }
    if([vo.discount intValue] == 0){
        [cell.discount removeFromSuperview];
    }
    if([vo.voucher intValue] == 0){
        [cell.voucher removeFromSuperview];
    }
    if([vo.special intValue] == 0){
        [cell.special removeFromSuperview];
    }

    
    return cell;
}
 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SimpleProductWithPromotionVOModel *vo = [similarDrugArr objectAtIndex:indexPath.row];
    //进入详情
    if([vo.multiPromotion intValue]==0)
    {
        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        
        [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = mapInfoModel;
            modelDrug.proDrugID = vo.proId;
            modelDrug.promotionID = vo.promotionId;
//            modelDrug.showDrug = @"0";
            WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//            modelLocal.title = @"药品详情";
            modelLocal.modelDrug = modelDrug;
            modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            [self.navigationController pushViewController:vcWebMedicine animated:YES];
        }];
    }
    else
    {
        //跳转到列表
        PromotionDrugDetailViewController *drugDetail = [[PromotionDrugDetailViewController alloc]init];
        drugDetail.vo = [DrugVo new];
        
        drugDetail.vo.productId=vo.productId;
        drugDetail.vo.proId =vo.proId;
        drugDetail.vo.proName =vo.proName;
        drugDetail.vo.spec =vo.spec;
        drugDetail.vo.factory =vo.factory;
        drugDetail.vo.imgUrl =vo.imgUrl;
        drugDetail.vo.gift=vo.gift;
        drugDetail.vo.discount =vo.discount;
        drugDetail.vo.voucher =vo.voucher;
        drugDetail.vo.special =vo.special;
        drugDetail.vo.label =vo.label;
//        drugDetail.vo.desc =vo.desc;
        drugDetail.vo.promotionId =vo.promotionId;
        drugDetail.vo.multiPromotion =vo.multiPromotion;
//        drugDetail.vo.type =vo.type;
        drugDetail.vo.beginDate =vo.startDate;
        drugDetail.vo.endDate =vo.endDate;
        drugDetail.vo.source =vo.source ;
        
        [self.navigationController pushViewController:drugDetail animated:YES];
    }}



- (IBAction)editUseMether:(id)sender {
    
    __weak __typeof(self)weakSelf = self;
    AddNewMedicineViewController *addNewMedicineViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddNewMedicineViewController"];
    addNewMedicineViewController.editMode = 2;
    addNewMedicineViewController.memberId = self.memberId;
    addNewMedicineViewController.InsertNewPharmacy = ^(QueryMyBoxModel *myBoxModel) {
        weakSelf.editPharmacy = YES;
    };
    addNewMedicineViewController.boxModelDidChange = ^(QueryMyBoxModel *myboxModel) {
        weakSelf.boxModel = myboxModel;
        [weakSelf updatePharmacy];
         [QWGLOBALMANAGER postNotif:NotifUpdateMyPh data:nil object:self];
    };
    addNewMedicineViewController.queryMyBoxModel = self.boxModel;
    [self.navigationController pushViewController:addNewMedicineViewController animated:YES];
}
@end
