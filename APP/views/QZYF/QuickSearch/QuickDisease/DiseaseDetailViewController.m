//
//  DiseaseDetailViewController.m
//  quanzhi
//
//  Created by Meng on 14-12-10.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "DiseaseDetailViewController.h"
#import "DiseaseMedicineListViewController.h"
#import "LoginViewController.h"
#import "Disease.h"
#import "DiseaseModel.h"
#import "DiseaseModelR.h"
#import "Favorite.h"
#import "Coupon.h"
#import "Categorys.h"
#import "AFNetworking.h"
#import "ZhPMethod.h"
#import "SBTextView.h"
#import "relateBgView.h"
#import "CalculateButtonViewHegiht.h"
#import "treatRuleBgView.h"
#import "DisesaeDetailInfoButton.h"
#import "CusTapGestureRecognizer.h"
#import "ReturnIndexView.h"
#import "ConsultForFreeRootViewController.h"
#import "MessageBoxListViewController.h"
#import "RCDraggableButton.h"
#import "WebDirectViewController.h"

#define kCauseTitle     @"病因"
#define kTraitTitle     @"疾病特点"
#define kSimilarTitle   @"易混淆疾病"
//---------------------------------------------
//A类 B类 的名称显示(此处分开写,方便应对产品人员脑子发热)
#define kTreatTitle_A   @"治疗原则"//A类疾病
#define kTreatTitle_B   @"治疗原则"//B类疾病
#define kHabitTitle     @"合理生活习惯"

#define kTitleFontSize  15 //标题字体大小
#define kDescFontSize   14 //描述字体大小


#define kX              10//控件的x坐标
#define kY              10//控件的y坐标
#define kH              10//两个控件间距离
#define kB              10//控件底部距离
#define kSectionHeight  30//Section段头的高度


#define kBoxBackgroundColor     UICOLOR(255, 249, 222)          //背景颜色
#define kBoxBorderColor         UICOLOR(254, 229, 176).CGColor  //边框颜色
#define kBoxBorderWidth         1                               //边框宽度

#define kEBu                    10//恶补高度
#define kRelateButtonHeight     20 //易混淆疾病的button高度

#define kRelateBoxIsShow        @"YES"//易混淆疾病的box是否显示 YES显示
#define kRelateBoxTag           300 //易混淆疾病box的tag值
#define kRelateBgViewTag        301//易混淆疾病的大背景

#define kTreatRuleBoxTag            400//治疗原则红色背景tag
#define kTreatRuleTitleTag          4001//
#define kTreatRuleContentTag        4002//
#define kTreatRuleButtonBgView      403

#define kThreeButtonBgViewHeight    10 //治疗原则三个按钮的高度
#define kThreeButtonTag             4567

#define kRelateDiseaseLabelTag      4005
@interface DiseaseDetailViewController ()<UITableViewDelegate, UITableViewDataSource,treatRuleBgViewDelegate,relateBgViewDelegate,ReturnIndexViewDelegate>
{
    //标题字体
    CGFloat titleFontSize;
    //内容字体
    CGFloat descFontSize;
    UIImageView * buttonImage;
    BOOL isUp;//字体是在放大,还是在缩小   YES:正在放大    NO:正在缩小
    
    RCDraggableButton *avatarButton; //浮动咨询按钮button
}

@property (strong, nonatomic) ReturnIndexView *indexView;
@property (strong, nonatomic) NSString *collectButtonImageName;
@property (strong, nonatomic) NSString *collectButtonName;
@property (weak,   nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *DescCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *DiseasCauseeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *DiseasFeatureCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *LifeHabitsCell;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic ,copy) NSString * diseaseType;
//黄色背景
@property (weak, nonatomic) IBOutlet UIView *causebgView;
@property (weak, nonatomic) IBOutlet UIView *traitbgView;
@property (weak, nonatomic) IBOutlet UIView *habitbgView;

//cell内容
//疾病
@property (weak, nonatomic) IBOutlet SBTextView *diseaseTitleTextView;
@property (weak, nonatomic) IBOutlet SBTextView *diseaseDescTextView;

//病因
@property (weak, nonatomic) IBOutlet UITextView *causeTitleTextView;
@property (weak, nonatomic) IBOutlet UITextView *causeContentTextView;

//病症
@property (weak, nonatomic) IBOutlet UITextView *traitTitleTextView;
@property (weak, nonatomic) IBOutlet UITextView *traitContentTextView;

//合理生活习惯
@property (weak, nonatomic) IBOutlet UITextView *habitTitleTextView;
@property (weak, nonatomic) IBOutlet UITextView *habitContentTextView;


//字典 数组 对象
@property (nonatomic, strong) NSMutableDictionary *tempDic;
@property (nonatomic ,strong) NSMutableDictionary * diseaseDict;
@property (nonatomic ,strong) NSMutableArray * formulaListArray;
@property (nonatomic ,strong) NSMutableArray * formulaDetailArray;

@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end



@implementation DiseaseDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        if (!HIGH_RESOLUTION) {
            [self.tableView setFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
        }
        buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
        self.collectButtonImageName = @"导航栏_收藏icon.png";
        self.collectButtonName=@"收藏";
        
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        if (!HIGH_RESOLUTION) {
            [self.tableView setFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
        }
        buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
        self.collectButtonImageName = @"导航栏_收藏icon.png";
        self.collectButtonName=@"收藏";

    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
    
    NSString *s = self.title;
    CGSize w = getTempTextSize(s, fontSystem(kFontS2), 10000);
    if (s.length > 9 && w.width > 162) {
        NSString *ss = [s substringToIndex:9];
        ss = [ss stringByAppendingString:@"..."];
        self.title = ss;
    }
    [self naviTitleView:nil];
    [self setRightItems];
    self.tableView.backgroundColor=RGBHex(qwColor4);
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    titleFontSize = kTitleFontSize;
    descFontSize = kDescFontSize;
    
    isUp = YES;
    
    
    self.diseaseDict = [NSMutableDictionary dictionary];
    self.formulaListArray = [NSMutableArray array];
    self.formulaDetailArray = [NSMutableArray array];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if([self isNetWorking]){
         
        return;
    }
    
    [self createCosutomButton];
}

#pragma ---index---
- (void)setRightItems{
    
    UIView *ypDetailBarItems=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 55)];
    
//    CGSize size = [@"Aa" sizeWithFont:[UIFont systemFontOfSize:19.0f]];
    UIButton * zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomButton setFrame:CGRectMake(23, -2, 55,55)];
    [zoomButton addTarget:self action:@selector(zoomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    zoomButton.titleLabel.font = [UIFont systemFontOfSize:19.0f];
    zoomButton.titleLabel.textColor = [UIColor whiteColor];
    [zoomButton setTitle:@"Aa" forState:UIControlStateNormal];
    [ypDetailBarItems addSubview:zoomButton];
    
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(65, 0, 60, 55)];
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(-5, 6, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(diseaseDetailreturnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 9, 18, 18)];
    self.numLabel.backgroundColor = RGBHex(qwColor3);
    self.numLabel.layer.cornerRadius = 9.0;
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:11];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.text = @"10";
    self.numLabel.hidden = YES;
    [rightView addSubview:self.numLabel];
    
    //小红点
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(29, 17, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    [ypDetailBarItems addSubview:rightView];
    
    
    UIBarButtonItem *fix=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width=-20;
    self.navigationItem.rightBarButtonItems=@[fix,[[UIBarButtonItem alloc]initWithCustomView:ypDetailBarItems]];
    
    if (self.passNumber > 0)
    {
        //显示数字
        self.numLabel.hidden = NO;
        self.redLabel.hidden = YES;
        if (self.passNumber > 99) {
            self.passNumber = 99;
        }
        self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
        
    }else if (self.passNumber == 0)
    {
        //显示小红点
        self.numLabel.hidden = YES;
        self.redLabel.hidden = NO;
        
    }else if (self.passNumber < 0)
    {
        //全部隐藏
        self.numLabel.hidden = YES;
        self.redLabel.hidden = YES;
    }

    
}

#pragma mark
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)diseaseDetailreturnIndex
{
    //comeFromNormalDisease
    NSArray *titleArr;
    NSArray *imageArr;
    if (self.comeFromNormalDisease) {
        imageArr = @[@"ic_img_notice.png",@"icon home.PNG"];
        titleArr = @[@"消息",@"首页"];
    }else{
        imageArr = @[@"ic_img_notice.png",@"icon home.PNG",self.collectButtonImageName];
        titleArr = @[@"消息",@"首页", self.collectButtonName];
    }
    
    self.indexView = [ReturnIndexView sharedManagerWithImage:imageArr title:titleArr passValue:self.passNumber];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    if (indexPath.row == 0) {
        
        if(!QWGLOBALMANAGER.loginStatus) {
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [self presentViewController:navgationController animated:YES completion:NULL];
            return;
        }
        
        MessageBoxListViewController *vcMsgBoxList = [[UIStoryboard storyboardWithName:@"MessageBoxListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageBoxListViewController"];
        
        vcMsgBoxList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
        
    }else if (indexPath.row == 1){
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }else if (indexPath.row == 2){
        [self collectButtonClick];
    }
    
}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}

#pragma mark---------------------------------------------跳转到首页-----------------------------------------------
#pragma mark

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self requestDiseaseData];
    }
}

#pragma mark
#pragma mark  setDiseaseId
- (void)setDiseaseId:(NSString *)diseaseId
{
    _diseaseId = diseaseId;
    [self requestDiseaseData];
}

- (void)requestDiseaseData
{
    DiseaseDetailIosR *detaileR = [DiseaseDetailIosR new];
    detaileR.diseaseId = _diseaseId;
    HttpClientMgr.progressEnabled = NO;
    [Disease getDiseaseDetailIOSWithParam:detaileR success:^(id obj) {
        [self.diseaseDict addEntriesFromDictionary:obj];
        [self.formulaListArray removeAllObjects];
        if ([self.diseaseDict[@"formulaList"] isKindOfClass:[NSArray class]]) {
            [self.formulaListArray addObjectsFromArray:self.diseaseDict[@"formulaList"]];
        }
        
        if (self.diseaseDict.count > 0) {
            //控制默认展开和收缩 1 展开,2 收缩
            NSString *expendYES = @"1";//即使现在没用到也不要删,切记! note by meng
            NSString *expendNO = @"2";
            
            /*
             #define kCauseTitle     @"病因"
             #define kTraitTitle     @"病症"
             #define kSimilarTitle   @"易混淆疾病"
             #define kTreatTitle     @"治疗"
             #define kHabitTitle     @"合理生活习惯"
             */
            
            [self.diseaseDict setObject:expendNO forKey:@"causeExpend"];
            [self.diseaseDict setObject:expendNO forKey:@"traitExpend"];
            [self.diseaseDict setObject:expendNO forKey:@"similarExpend"];
            [self.diseaseDict setObject:expendNO forKey:@"treatExpend"];
            [self.diseaseDict setObject:expendNO forKey:@"habitExpend"];
            [self checkIsCollectOrNot];
        }
        [self coverData];
        
    } failure:^(HttpException *e) {
        //217的修改点  cj
        if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
            [self showInfoView:kWarning12 image:@"网络信号icon.png"];
            return;
        }else{
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
            return;
        }
    }];
}

- (void)popVCAction:(id)sender
{
    
    [super popVCAction:sender];

}


- (void)coverData
{
    /*
     #define kCauseTitle     @"病因"
     #define kTraitTitle     @"病症"
     #define kSimilarTitle   @"易混淆疾病鉴别"
     #define kTreatTitle     @"治疗"
     #define kHabitTitle     @"合理生活习惯"
     */
    self.diseaseType = self.diseaseDict[@"type"];
    [self.diseaseDict setObject:kCauseTitle     forKey:@"causeTitle"];
    [self.diseaseDict setObject:kTraitTitle     forKey:@"traitTitle"];
    [self.diseaseDict setObject:kSimilarTitle   forKey:@"similarTitle"];
    if ([self.diseaseType isEqualToString:@"A"]) {
        [self.diseaseDict setObject:kTreatTitle_A forKey:@"treatTitle"];
    }else if ([self.diseaseType isEqualToString:@"B"]){
        [self.diseaseDict setObject:kTreatTitle_B forKey:@"treatTitle"];
    }
    [self.diseaseDict setObject:kHabitTitle     forKey:@"habitTitle"];
    
    /**
     *  1.获取字符串
     */
    //第0段 疾病
    NSString * name = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"name"]];//疾病名字
    NSString * desc = nil;//疾病描述
    if ([self.diseaseType isEqualToString:@"A"] || [self.diseaseType isEqualToString:@"B"]) {
        desc= [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"desc"]];
    }else if ([self.diseaseType isEqualToString:@"C"]){
        desc = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseSummarize"]];
    }
    if(desc !=nil){
       [self.diseaseDict setObject:desc forKey:@"desc"];
    }
 
    //-----------------------------------------------------------------------------------------------------
    //第1段 病因
    NSString * causeTitle = [QWGLOBALMANAGER replaceSpecialStringWith:kCauseTitle];//病因标题
    NSString * diseaseCauseTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseCauseTitle"]];//病因描述
    NSString * diseaseCauseContent = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseCauseContent"]];//病因内容
    if (diseaseCauseTitle.length == 0 && diseaseCauseContent.length == 0) {
        [self.diseaseDict setObject:@"YES" forKey:@"diseaseCauseHidden"];
    }

    //-----------------------------------------------------------------------------------------------------
    //第2段 病症
    NSString * traitTitle = [QWGLOBALMANAGER replaceSpecialStringWith:kTraitTitle];
    NSString * diseaseTraitTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseTraitTitle"]];
    NSString * diseaseTraitContent = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseTraitContent"]];
    if (diseaseTraitTitle.length == 0 && diseaseTraitContent.length == 0) {
        [self.diseaseDict setObject:@"YES" forKey:@"diseaseTraitHidden"];
    }
    
    //-----------------------------------------------------------------------------------------------------
    //第3段 易混淆疾病
    NSString *similarTitle = [QWGLOBALMANAGER replaceSpecialStringWith:kSimilarTitle];
    NSString *similarDiseaseTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"similarDiseaseTitle"]];
    NSString *similarDiseaseContent = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"similarDiseaseContent"]];
    if (similarDiseaseTitle.length == 0 && similarDiseaseContent.length == 0) {
        [self.diseaseDict setObject:@"YES" forKey:@"diseaseSimilarHidden"];
    }

    //-----------------------------------------------------------------------------------------------------
    //第4段 治疗
    NSString * treatTitle = nil;
    if ([self.diseaseType isEqualToString:@"A"]) {
        treatTitle = [QWGLOBALMANAGER replaceSpecialStringWith:kTreatTitle_A];
    }else if ([self.diseaseType isEqualToString:@"B"]){
        treatTitle = [QWGLOBALMANAGER replaceSpecialStringWith:kTreatTitle_B];
    }
    NSString * treatRuleTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleTitle"]];
    NSString * treatRuleContent = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleContent"]];
    NSArray * formulaListArr;
    if ([self.diseaseDict[@"formulaList"] isKindOfClass:[NSArray class]]) {
        formulaListArr = self.diseaseDict[@"formulaList"];
    }
    if (treatRuleTitle.length == 0 && treatRuleContent.length == 0 && formulaListArr.count == 0) {
        [self.diseaseDict setObject:@"YES" forKey:@"treatRuleHidden"];
    }
    //-----------------------------------------------------------------------------------------------------
    //第5段 合理生活习惯
    NSString * habitTitle = [QWGLOBALMANAGER replaceSpecialStringWith:kHabitTitle];
    NSString * goodHabitTitle  = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"goodHabitTitle"]];
    NSString * goodHabitContent = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"goodHabitContent"]];
    if (goodHabitTitle.length == 0 && goodHabitContent.length == 0) {
        [self.diseaseDict setObject:@"YES" forKey:@"goodHabitHidden"];
    }
    
    
    
    /**
     *  2/计算高度
     */
    //第0段 疾病
    CGSize nameSize = [self getTextViewHeightWithContent:name FontSize:titleFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(nameSize) forKey:@"nameSize"];
    CGSize descSize = [self getTextViewHeightWithContent:desc FontSize:descFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(descSize) forKey:@"descSize"];
    
    //-----------------------------------------------------------------------------------------------------
    //第1段 病因
    //1)标题size
    CGSize causeTitleSize = [self getTextViewHeightWithContent:causeTitle FontSize:titleFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(causeTitleSize) forKey:@"causeTitleSize"];
    //2)子标题size
    CGSize diseaseCauseTitleSize = CGSizeZero;
    if ([self.diseaseType isEqualToString:@"A"]) {
        diseaseCauseTitleSize = [self getTextViewHeightWithContent:diseaseCauseTitle FontSize:descFontSize width:APP_W-30];
    }else if ([self.diseaseType isEqualToString:@"B"]){
        diseaseCauseTitleSize = CGSizeMake(0, 0);
    }
    [self.diseaseDict setObject:NSStringFromCGSize(diseaseCauseTitleSize) forKey:@"diseaseCauseTitleSize"];
    //3)内容size
    CGSize diseaseCauseContentSize = [self getTextViewHeightWithContent:diseaseCauseContent FontSize:descFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(diseaseCauseContentSize) forKey:@"diseaseCauseContentSize"];
    //4)rowSize
    CGSize causeRowSize = CGSizeZero;
    if ([self.diseaseType isEqualToString:@"A"]) {
        if (diseaseCauseTitle != nil && diseaseCauseTitle.length > 0) {
            causeRowSize = CGSizeMake(0, kY + diseaseCauseTitleSize.height + kH + diseaseCauseContentSize.height);
        }else{
            causeRowSize = CGSizeMake(0, kY + diseaseCauseContentSize.height);
        }
    }else if ([self.diseaseType isEqualToString:@"B"]){//B类疾病和空  都会因此黄色背景
        causeRowSize = CGSizeMake(0, kY + diseaseCauseContentSize.height);
    }
    [self.diseaseDict setObject:NSStringFromCGSize(causeRowSize) forKey:@"causeRowSize"];
    
    //-----------------------------------------------------------------------------------------------------
    //第2段 病症
    //1)标题size
    CGSize traitTitleSize = [self getTextViewHeightWithContent:traitTitle FontSize:titleFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(traitTitleSize) forKey:@"traitTitleSize"];
    //2)子标题size
    CGSize diseaseTraitTitleSize = CGSizeZero;
    if ([self.diseaseType isEqualToString:@"A"]) {
        diseaseTraitTitleSize = [self getTextViewHeightWithContent:diseaseTraitTitle FontSize:descFontSize width:APP_W-30];
    }else if ([self.diseaseType isEqualToString:@"B"]){
        diseaseTraitTitleSize = CGSizeMake(0, 0);
    }
    [self.diseaseDict setObject:NSStringFromCGSize(diseaseTraitTitleSize) forKey:@"diseaseTraitTitleSize"];
    //3)内容size
    CGSize diseaseTraitContentSize = [self getTextViewHeightWithContent:diseaseTraitContent FontSize:descFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(diseaseTraitContentSize) forKey:@"diseaseTraitContentSize"];
    //4)rowSize
    CGSize traitRowSize = CGSizeZero;
    if ([self.diseaseType isEqualToString:@"A"]) {
        if (diseaseTraitTitle != 0 && diseaseTraitTitle.length > 0) {
            traitRowSize = CGSizeMake(0, kY + diseaseTraitTitleSize.height + kH + diseaseTraitContentSize.height);
        }else{
            traitRowSize = CGSizeMake(0, kY + diseaseTraitContentSize.height);
        }
    }else if ([self.diseaseType isEqualToString:@"B"]){//B类疾病和空  都会因此黄色背景
        traitRowSize = CGSizeMake(0, kY + diseaseTraitContentSize.height);
    }
    [self.diseaseDict setObject:NSStringFromCGSize(traitRowSize) forKey:@"traitRowSize"];
    
    //-----------------------------------------------------------------------------------------------------
    //第3段 易混淆疾病 -------
    CGFloat relateDiseaseRowHeight = kY;
    NSString * symptomStr = @"相同症状:";//getTextSize(symptomStr, Font(descFontSize), APP_W-20)
    CGSize similarTitleSize = [self getTextViewHeightWithContent:similarTitle FontSize:titleFontSize width:APP_W-20];
    CGSize similarDiseaseTitleSize = CGSizeZero;
    CGSize  symptomStrSize = [self getTextViewHeightWithContent:symptomStr FontSize:descFontSize width:APP_W-20];
    
    if ([self.diseaseType isEqualToString:@"A"]) {
        similarDiseaseTitleSize = [self getTextViewHeightWithContent:similarDiseaseTitle FontSize:descFontSize width:APP_W-30];
    }else if ([self.diseaseType isEqualToString:@"B"]){
        similarDiseaseTitleSize = CGSizeMake(0, 0);
    }
    
    [self.diseaseDict setObject:NSStringFromCGSize(similarTitleSize) forKey:@"similarTitleSize"];
    [self.diseaseDict setObject:NSStringFromCGSize(similarDiseaseTitleSize) forKey:@"similarDiseaseTitleSize"];
    [self.diseaseDict setObject:NSStringFromCGSize(symptomStrSize) forKey:@"symptomStrSize"];
    
    if ([kRelateBoxIsShow isEqualToString:@"YES"]) {
        if (similarDiseaseTitle != nil && similarDiseaseTitle.length > 0) {
            relateDiseaseRowHeight += similarDiseaseTitleSize.height + kB;
        }else{
            relateDiseaseRowHeight += similarDiseaseTitleSize.height;
        }
    }
    
    
    if ([self.diseaseType isEqualToString:@"A"]) {
        NSString * relateDesc = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"similarDiseaseContent"]];
        
        NSArray * differentArray = [relateDesc componentsSeparatedByString:@"@"];//用"@"符号分割
        if (differentArray.count > 0) {
            NSMutableArray * tmpList = [[NSMutableArray alloc] init];
            
            for (NSString * item in differentArray) {
                NSMutableDictionary * tmpRow = [[NSMutableDictionary alloc] init];
                
                NSArray * disInfo = [item componentsSeparatedByString:@"#"];//用"#"分割
                
                CGFloat bgViewHeght = 0;
                if (disInfo.count > 0) {
                    [tmpRow setObject:[QWGLOBALMANAGER replaceSpecialStringWith:disInfo[0]] forKey:@"relateTitle"];
                    bgViewHeght += kY;
                    CGSize relateTitleSize = [self getTextViewHeightWithContent:disInfo[0] FontSize:descFontSize width:APP_W-20];
                    bgViewHeght += kRelateButtonHeight + kB;
                    [tmpRow setObject:NSStringFromCGSize(relateTitleSize) forKey:@"relateTitleSize"];
                }
                if (disInfo.count > 1) {
                    bgViewHeght += symptomStrSize.height + kB;
                    [tmpRow setObject:[QWGLOBALMANAGER replaceSpecialStringWith:disInfo[1]] forKey:@"relateText1"];
                    CGSize relateText1Size = [self getTextViewHeightWithContent:disInfo[1] FontSize:descFontSize width:APP_W-20];
                    bgViewHeght +=  relateText1Size.height + kB;
                    [tmpRow setObject:NSStringFromCGSize(relateText1Size) forKey:@"relateText1Size"];
                }
                if (disInfo.count > 2) {
                    bgViewHeght += symptomStrSize.height + kB;
                    [tmpRow setObject:[QWGLOBALMANAGER replaceSpecialStringWith:disInfo[2]] forKey:@"relateText2"];
                    CGSize relateText2Size = [self getTextViewHeightWithContent:disInfo[2] FontSize:descFontSize width:APP_W-20];
                    bgViewHeght += relateText2Size.height + kB;
                    [tmpRow setObject:NSStringFromCGSize(relateText2Size) forKey:@"relateText2Size"];
                }
                CGSize bgViewSize = CGSizeMake(APP_W-20, bgViewHeght);
                
                relateDiseaseRowHeight += bgViewHeght;
                [tmpRow setObject:font(kFont1, descFontSize) forKey:@"font"];
                [tmpRow setObject:NSStringFromCGSize(bgViewSize) forKey:@"bgViewSize"];
                [tmpList addObject:tmpRow];
            }
            [self.diseaseDict setObject:tmpList forKey:@"similarDiseaseContentDict"];
            
        }
        [self.diseaseDict setObject:NSStringFromCGSize(CGSizeMake(APP_W-20, relateDiseaseRowHeight)) forKey:@"relateDiseaseRowHeight"];
    }else if ([self.diseaseType isEqualToString:@"B"]){
        NSString * similarDiseaseContent = self.diseaseDict[@"similarDiseaseContent"];
        CGSize similarDiseaseContentSize = [self getTextViewHeightWithContent:similarDiseaseContent FontSize:descFontSize width:APP_W-20];
        [self.diseaseDict setObject:NSStringFromCGSize(similarDiseaseContentSize) forKey:@"similarDiseaseContentSize"];
        relateDiseaseRowHeight += similarDiseaseContentSize.height;
        [self.diseaseDict setObject:NSStringFromCGSize(CGSizeMake(APP_W-20, relateDiseaseRowHeight)) forKey:@"relateDiseaseRowHeight"];
    }
    
    
    //-----------------------------------------------------------------------------------------------------
    //第4段 治疗
    CGSize treatTitleSize = [self getTextViewHeightWithContent:treatTitle FontSize:titleFontSize width:APP_W-20];
    CGSize treatRuleTitleSize = CGSizeZero;
    if ([self.diseaseType isEqualToString:@"A"]) {
        treatRuleTitleSize = [self getTextViewHeightWithContent:treatRuleTitle FontSize:descFontSize width:APP_W-30];

    }else if ([self.diseaseType isEqualToString:@"B"]){
        treatRuleTitleSize = CGSizeMake(0, 0);
    }
    CGSize treatRuleContentSize = [self getTextViewHeightWithContent:treatRuleContent FontSize:descFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(treatTitleSize) forKey:@"treatTitleSize"];
    [self.diseaseDict setObject:NSStringFromCGSize(treatRuleTitleSize) forKey:@"treatRuleTitleSize"];
    [self.diseaseDict setObject:NSStringFromCGSize(treatRuleContentSize) forKey:@"treatRuleContentSize"];
    
    //1)处理数据源⌄✓✓✓✓✓✓✓✓✓
    NSMutableArray * formulaList;
    if ([self.diseaseDict[@"formulaList"] isKindOfClass:[NSArray class]]) {
        formulaList = [NSMutableArray arrayWithArray:self.diseaseDict[@"formulaList"]];
    }
    for (int i = 0; i < formulaList.count; i++) {
        NSMutableDictionary * formulaListDic = [NSMutableDictionary dictionaryWithDictionary:formulaList[i]];
        [formulaListDic setObject:font(kFont1, descFontSize) forKey:@"font"];
        [formulaListDic setObject:font(kFont1, titleFontSize) forKey:@"titleFont"];
        
        NSMutableArray * formulaDetailArr = [NSMutableArray arrayWithArray:formulaListDic[@"formulaDetail"] ];
        for (int j = 0; j < formulaDetailArr.count; j++) {
            NSMutableDictionary * detailDic = [NSMutableDictionary dictionaryWithDictionary:formulaDetailArr[j]];
            [detailDic setObject:[UIFont systemFontOfSize:titleFontSize] forKey:@"titleFont"];
            [formulaDetailArr replaceObjectAtIndex:j withObject:detailDic];
        }
        [formulaListDic setObject:formulaDetailArr forKey:@"formulaDetail"];
        [formulaList replaceObjectAtIndex:i withObject:formulaListDic];
    }
    if (formulaList) {
        [self.diseaseDict setObject:formulaList forKey:@"formulaList"];
    }
    
    //2)处理数据源结束↑✔︎✔︎✔︎✔︎✔︎✔︎✔︎✔︎✔︎✔︎✔︎✔︎✔︎
    
    CGFloat treatRuleRowHeight = kY;
    treatRuleRowHeight += treatRuleTitleSize.height + kB;
    treatRuleRowHeight += treatRuleContentSize.height + kB;
    
    
    for (int i = 0; i< formulaList.count; i++) {
        CGFloat ruleBlockHeight = 0;
        NSMutableDictionary * formulaDetailDic = [NSMutableDictionary dictionaryWithDictionary:formulaList[i]];
        NSDictionary * ruleDic = formulaList[i];
        CGSize ruleTitleSize = [self getTextViewHeightWithContent:ruleDic[@"ruleName"] FontSize:titleFontSize width:APP_W-20];
        CGSize ruleContentSize = [self getTextViewHeightWithContent:ruleDic[@"ruleDesc"] FontSize:descFontSize width:APP_W-30];
        CGFloat buttonHeight = [CalculateButtonViewHegiht calculateButtonsHeightWith:ruleDic[@"formulaDetail"]];
        
        ruleBlockHeight = kY + ruleTitleSize.height + kB + ruleContentSize.height + kB + ruleTitleSize.height + kB + buttonHeight;
        treatRuleRowHeight += ruleBlockHeight + kB;
        CGSize ruleBlockSize = CGSizeMake(APP_W-20, ruleBlockHeight);
        [formulaDetailDic setObject:NSStringFromCGSize(ruleBlockSize) forKey:@"ruleBlockSize"];
        [formulaList replaceObjectAtIndex:i withObject:formulaDetailDic];
    }
    if (formulaList) {
        [self.diseaseDict setObject:formulaList forKey:@"formulaList"];
    }
    
    CGSize treatRuleRowSize = CGSizeZero;
    if ([self.diseaseType isEqualToString:@"A"]) {
        treatRuleRowSize = CGSizeMake(APP_W-20, treatRuleRowHeight + kThreeButtonBgViewHeight);
    }else if ([self.diseaseType isEqualToString:@"B"]){
        treatRuleRowSize = CGSizeMake(APP_W-20, treatRuleRowHeight);
    }
    
    [self.diseaseDict setObject:NSStringFromCGSize(treatRuleRowSize) forKey:@"treatRuleRowSize"];
    
    
    //-----------------------------------------------------------------------------------------------------
    
    //第5段 合理生活习惯
    CGSize habitTitleSize = [self getTextViewHeightWithContent:habitTitle FontSize:titleFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(habitTitleSize) forKey:@"habitTitleSize"];
    CGSize goodHabitTitleSize;
    goodHabitTitleSize = [self getTextViewHeightWithContent:goodHabitTitle FontSize:descFontSize width:APP_W-30];
    [self.diseaseDict setObject:NSStringFromCGSize(goodHabitTitleSize) forKey:@"goodHabitTitleSize"];
    CGSize goodHabitContentSize = [self getTextViewHeightWithContent:goodHabitContent FontSize:descFontSize width:APP_W-20];
    [self.diseaseDict setObject:NSStringFromCGSize(goodHabitContentSize) forKey:@"goodHabitContentSize"];
    
    
    
    CGSize habitRowSize;
    if (goodHabitTitle != nil && goodHabitTitle.length == 0) {
        habitRowSize = CGSizeMake(0, kY + goodHabitTitleSize.height + kH + goodHabitContentSize.height);
    }else{
        habitRowSize = CGSizeMake(0, kY + goodHabitContentSize.height);
    }
    [self.diseaseDict setObject:NSStringFromCGSize(habitRowSize) forKey:@"habitRowSize"];

    [self.tableView reloadData];
}

/*
 relateTitle
 relateTitleSize
 relateText1//相同症状
 relateText1Size
 relateText2//不同症状
 relateText2Size
 */

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.diseaseDict.count == 0) {
        return 0;
    }
    if ([self.diseaseType isEqualToString:@"A"]) {
        return 6;
    }else if ([self.diseaseType isEqualToString:@"B"]){
        return 5;
    }else
        return 1;
}

#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    /*
    [self.diseaseDict setObject:@"YES" forKey:@"diseaseCauseHidden"];
    [self.diseaseDict setObject:@"YES" forKey:@"diseaseTraitHidden"];
    [self.diseaseDict setObject:@"YES" forKey:@"diseaseSimilarHidden"];
    [self.diseaseDict setObject:@"YES" forKey:@"treatRuleHidden"];
    [self.diseaseDict setObject:@"YES" forKey:@"goodHabitHidden"];
     */
    NSString * hiddenStr = nil;
    switch (section) {
        case 1:
            hiddenStr = self.diseaseDict[@"diseaseCauseHidden"];
            break;
        case 2:
            hiddenStr = self.diseaseDict[@"diseaseTraitHidden"];
            break;
        case 3:
            hiddenStr = self.diseaseDict[@"diseaseSimilarHidden"];
            break;
        case 4:
            hiddenStr = self.diseaseDict[@"treatRuleHidden"];
            break;
        case 5:
            hiddenStr = self.diseaseDict[@"goodHabitHidden"];
            break;
        default:
            break;
    }
    if ([hiddenStr isEqualToString:@"YES"]) {
        return 0;
    }
    
    return kSectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        /*
         #define kCauseTitle     @"病因"
         #define kTraitTitle     @"病症"
         #define kSimilarTitle   @"易混淆疾病鉴别"
         #define kTreatTitle     @"治疗"
         #define kHabitTitle     @"合理生活习惯"
         
         [self.diseaseDict setObject:kCauseTitle forKey:@"causeTitle"];
         [self.diseaseDict setObject:kTraitTitle forKey:@"traitTitle"];
         [self.diseaseDict setObject:kSimilarTitle forKey:@"similarTitle"];
         [self.diseaseDict setObject:kTreatTitle forKey:@"treatTitle"];
         [self.diseaseDict setObject:kHabitTitle forKey:@"habitTitle"];
         */
        NSString * name = nil;
        NSString * subName = nil;
        NSString * hiddenStr = nil;
        switch (section) {
            case 1:
                name = kCauseTitle;
                subName = @"causeTitleSize";
                hiddenStr = self.diseaseDict[@"diseaseCauseHidden"];
                break;
            case 2:
                name = kTraitTitle;
                subName = @"traitTitleSize";
                hiddenStr = self.diseaseDict[@"diseaseTraitHidden"];
                break;
            case 3:
                name = kSimilarTitle;
                subName = @"similarTitleSize";
                hiddenStr = self.diseaseDict[@"diseaseSimilarHidden"];
                break;
            case 4:
                if ([self.diseaseType isEqualToString:@"A"]) {
                    name = kTreatTitle_A;
                }else if ([self.diseaseType isEqualToString:@"B"]){
                    name = kTreatTitle_B;
                }
                hiddenStr = self.diseaseDict[@"treatRuleHidden"];
                subName = @"treatTitleSize";
                break;
            case 5:
                name = kHabitTitle;
                subName = @"habitTitleSize";
                hiddenStr = self.diseaseDict[@"goodHabitHidden"];
                break;
            default:
                break;
        }
        CGSize titleSize = CGSizeFromString(self.diseaseDict[subName]);
        
        UIView * sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, kSectionHeight)];
        
        if ([hiddenStr isEqualToString:@"YES"]) {
            sectionHeaderView.hidden = YES;
        }
        SBTextView * titleTextView = [[SBTextView alloc] initWithFrame:CGRectMake(kX, kSectionHeight/2 - titleSize.height/2, titleSize.width, titleSize.height)];
        titleTextView.text = name;
        titleTextView.backgroundColor = [UIColor clearColor];
        titleTextView.font = font(kFont1, titleFontSize);
        [sectionHeaderView addSubview:titleTextView];
        
        //arr_down.png" : @"arr_up.png"
        UIImage * arrDownImage = [UIImage imageNamed:@"arr_down.png"];
        UIImage * arrUpImage = [UIImage imageNamed:@"arr_up.png"];
        CGSize arrSize = arrUpImage.size;
        UIImageView * arrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_W-15-arrSize.width, sectionHeaderView.FH/2 - arrSize.height/2, arrSize.width, arrSize.height)];
        
        
        //控制展开和收缩
        NSString * expendYES = @"1";
        NSString * expendNO = @"2";
        
        NSString * expendStatus = nil;
        switch (section) {
            case 1:
                expendStatus = self.diseaseDict[@"causeExpend"];
                break;
            case 2:
                expendStatus = self.diseaseDict[@"traitExpend"];
                break;
            case 3:
                expendStatus = self.diseaseDict[@"similarExpend"];
                break;
            case 4:
                expendStatus = self.diseaseDict[@"treatExpend"];
                break;
            case 5:
                expendStatus = self.diseaseDict[@"habitExpend"];
                break;
            default:
                break;
        }
        
        if ([expendStatus isEqualToString:expendYES]) {
            arrImageView.image = arrUpImage;
        }else if ([expendStatus isEqualToString:expendNO]){
            arrImageView.image = arrDownImage;
        }
        [sectionHeaderView addSubview:arrImageView];
        /*
         #define kCauseTitle     @"病因"
         #define kTraitTitle     @"病症"
         #define kSimilarTitle   @"易混淆疾病"
         #define kTreatTitle     @"治疗"
         #define kHabitTitle     @"合理生活习惯"
         */
        
        
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setFrame:sectionHeaderView.bounds];
        [titleButton addTarget:self action:@selector(sectionExpandClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.backgroundColor = [UIColor clearColor];
        titleButton.tag = section;
        [sectionHeaderView addSubview:titleButton];
        
//        CusTapGestureRecognizer * tap = [[CusTapGestureRecognizer alloc] init];
//        tap.section = section;
//        [tap addTarget:self action:@selector(sectionExpandClick:)];
//        [sectionHeaderView addGestureRecognizer:tap];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, sectionHeaderView.frame.size.height - 0.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [sectionHeaderView addSubview:line];
        sectionHeaderView.backgroundColor = [UIColor whiteColor];
        
        
        
        return sectionHeaderView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 && ![self.diseaseType isEqualToString:@"C"]) {
        return 10;
    }
    return 0;
//    NSString * hiddenStr = nil;
//    switch (section) {
//        case 1:
//            hiddenStr = self.diseaseDict[@"diseaseCauseHidden"];
//            break;
//        case 2:
//            hiddenStr = self.diseaseDict[@"diseaseTraitHidden"];
//            break;
//        case 3:
//            hiddenStr = self.diseaseDict[@"diseaseSimilarHidden"];
//            break;
//        case 4:
//            hiddenStr = self.diseaseDict[@"treatRuleHidden"];
//            break;
//        case 5:
//            hiddenStr = self.diseaseDict[@"goodHabitHidden"];
//            break;
//        default:
//            break;
//    }
//    
//    if (self.diseaseDict.count == 0) {
//        return 0;
//    }
//    if ([self.diseaseType isEqualToString:@"A"]) {
//        if (section == 5) {
//            return 0;
//        }
//    }else if ([self.diseaseType isEqualToString:@"B"]){
//        if (section == 4) {
//            return 0;
//        }
//    }else{
//        if ([hiddenStr isEqualToString:@"YES"]) {
//            return 0;
//        }
//    }
//    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0 && ![self.diseaseType isEqualToString:@"C"]) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 9)];
        [v setBackgroundColor:RGBHex(qwColor11)];
        return v;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //控制展开和收缩
    NSString * expendYES = @"1";
    NSString * expendNO = @"2";
    
    NSString * expendStatus = nil;
    
    if (indexPath.section == 0) {
        CGSize nameSize = CGSizeFromString(self.diseaseDict[@"nameSize"]);
        CGSize descSize = CGSizeFromString(self.diseaseDict[@"descSize"]);
        
        return kY + nameSize.height + kH + descSize.height + kB;
        
    }else if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 5){
        NSString * size = nil;
        NSString * hiddenStr = nil;
        switch (indexPath.section) {
            case 1:
                size = @"causeRowSize";
                hiddenStr = self.diseaseDict[@"diseaseCauseHidden"];
                expendStatus = self.diseaseDict[@"causeExpend"];
                break;
            case 2:
                size = @"traitRowSize";
                hiddenStr = self.diseaseDict[@"diseaseTraitHidden"];
                expendStatus = self.diseaseDict[@"traitExpend"];
                break;
            case 5:
                size = @"habitRowSize";
                hiddenStr = self.diseaseDict[@"goodHabitHidden"];
                expendStatus = self.diseaseDict[@"habitExpend"];
                break;
            default:
                break;//
        }
        CGFloat rowHeight = 0;
        if ([hiddenStr isEqualToString:@"YES"]) {
            return rowHeight;
        }
        if ([expendStatus isEqualToString:expendYES]) {
            rowHeight = CGSizeFromString(self.diseaseDict[size]).height + kEBu;
            
            if (indexPath.section == 5) {
                rowHeight += 45;
            }
            
            
        }else if ([expendStatus isEqualToString:expendNO]){
            rowHeight = 0;
        }
        return rowHeight;
        
    }else if (indexPath.section == 3){//易混淆疾病鉴别
        CGFloat rowHeght = 0;
        NSString * hiddenStr = self.diseaseDict[@"diseaseSimilarHidden"];
        if ([hiddenStr isEqualToString:@"YES"]) {
            return rowHeght;
        }
        expendStatus = self.diseaseDict[@"similarExpend"];
        if ([expendStatus isEqualToString:expendYES]) {
            rowHeght = CGSizeFromString(self.diseaseDict[@"relateDiseaseRowHeight"]).height;
            if ([self.diseaseType isEqualToString:@"B"]) {
                CGSize relateDiseaseSize = CGSizeFromString(self.diseaseDict[@"similarDiseaseContentSize"]);
                rowHeght = relateDiseaseSize.height + 15;
            }
            
        }else if ([expendStatus isEqualToString:expendNO]){
            rowHeght = 0;
        }
        return rowHeght;
    }else if (indexPath.section == 4){//治疗原则
        CGFloat rowHeght = 0;
        NSString *hiddenStr = self.diseaseDict[@"treatRuleHidden"];
        if ([hiddenStr isEqualToString:@"YES"]) {
            return rowHeght;
        }
        expendStatus = self.diseaseDict[@"treatExpend"];
        if ([expendStatus isEqualToString:expendYES]) {
            rowHeght = CGSizeFromString(self.diseaseDict[@"treatRuleRowSize"]).height;
            NSString *treatRuleTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleTitle"]];
            if (treatRuleTitle == nil || treatRuleTitle.length == 0 ) {
                rowHeght -= 20;
            }
            
        }else if ([expendStatus isEqualToString:expendNO]){
            rowHeght = 0;
        }
        return rowHeght;
    }
    return 0;
    
}

#pragma mark 
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)//疾病简介
    {
        if (self.DescCell) {
            [self.DescCell removeFromSuperview];
        }
        CGSize nameSize = CGSizeFromString(self.diseaseDict[@"nameSize"]);
        CGSize descSize = CGSizeFromString(self.diseaseDict[@"descSize"]);
        [self.diseaseTitleTextView setFrame:CGRectMake(kX, kY, nameSize.width + 10, nameSize.height + 3)];
        [self.diseaseDescTextView setFrame:CGRectMake(kX, self.diseaseTitleTextView.FY + self.diseaseTitleTextView.FH + kH, descSize.width, descSize.height)];
        self.diseaseTitleTextView.font = [UIFont boldSystemFontOfSize:titleFontSize];
        self.diseaseTitleTextView.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"name"]];
        self.diseaseDescTextView.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"desc"]];
        self.diseaseDescTextView.font =font(kFont1, descFontSize);

        self.DescCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.DescCell;
    }else if (indexPath.section == 1)//病因
    {
        if (self.DiseasCauseeCell) {
            [self.DiseasCauseeCell removeFromSuperview];
        }
        CGSize subTitleSize = CGSizeFromString(self.diseaseDict[@"diseaseCauseTitleSize"]);
        CGSize contentSize = CGSizeFromString(self.diseaseDict[@"diseaseCauseContentSize"]);
        NSString * diseaseCauseTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseCauseTitle"]];//病因描述
        CGFloat cause_y = kY;
        if ([self.diseaseType isEqualToString:@"A"]) {
            if (diseaseCauseTitle == nil || diseaseCauseTitle.length == 0) {
                [self.causebgView setFrame:CGRectMake(kX, 0, APP_W-20, 0)];
            }else{
                [self.causebgView setFrame:CGRectMake(kX, cause_y - 5, APP_W-20, subTitleSize.height + kB)];
                cause_y += subTitleSize.height + kB;
            }
        }else if ([self.diseaseType isEqualToString:@"B"]){
            [self.causebgView setFrame:CGRectMake(kX, kY - 5, APP_W-20, 0)];
        }
        [self.causebgView setBackgroundColor: RGBHex(qwColor15)];
        self.causebgView.layer.borderColor = RGBHex(qwColor15).CGColor;
        self.causebgView.layer.borderWidth = kBoxBorderWidth;
        [self.causeTitleTextView setFrame:CGRectMake(kX - 5, 5, subTitleSize.width, subTitleSize.height)];
        [self.causeContentTextView setFrame:CGRectMake(kX, cause_y, contentSize.width, contentSize.height)];
        self.causeTitleTextView.font = font(kFont1, descFontSize);
        self.causeContentTextView.font =font(kFont1, descFontSize);
        self.causeTitleTextView.text = diseaseCauseTitle;
        self.causeContentTextView.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseCauseContent"]];
        
        self.DiseasCauseeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10,0.5, APP_W-10, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [self.DiseasCauseeCell addSubview:line];

        return self.DiseasCauseeCell;
    }else if (indexPath.section == 2)//症状特点
    {
        if (self.DiseasFeatureCell) {
            [self.DiseasFeatureCell removeFromSuperview];
        }
        CGSize subTitleSize = CGSizeFromString(self.diseaseDict[@"diseaseTraitTitleSize"]);
        CGSize contentSize = CGSizeFromString(self.diseaseDict[@"diseaseTraitContentSize"]);
        NSString *diseaseTraitTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseTraitTitle"]];
        CGFloat trait_y = kY;
        if ([self.diseaseType isEqualToString:@"A"]) {
            if (diseaseTraitTitle == nil || diseaseTraitTitle.length == 0) {
                [self.traitbgView setFrame:CGRectMake(kX, 0, APP_W-20, 0)];
            }else{
                [self.traitbgView setFrame:CGRectMake(kX, trait_y - 5, APP_W-20, subTitleSize.height + kB)];
                trait_y += subTitleSize.height + kB;
            }
        }else if ([self.diseaseType isEqualToString:@"B"]){
            [self.traitbgView setFrame:CGRectMake(kX, kY - 5, APP_W-20, 0)];
        }
        
        [self.traitbgView setBackgroundColor:RGBHex(qwColor15)];
        self.traitbgView.layer.borderColor = RGBHex(qwColor15).CGColor;
        self.traitbgView.layer.borderWidth = kBoxBorderWidth;
        
        [self.traitTitleTextView setFrame:CGRectMake(kX - 5, 5, subTitleSize.width, subTitleSize.height)];
        [self.traitContentTextView setFrame:CGRectMake(kX, trait_y, contentSize.width, contentSize.height)];
        self.traitTitleTextView.font = font(kFont1, descFontSize);
        self.traitContentTextView.font =font(kFont1, descFontSize);
        self.traitTitleTextView.text = diseaseTraitTitle;
        self.traitContentTextView.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"diseaseTraitContent"]];
        
        self.DiseasFeatureCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10,0.5, APP_W-10, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [self.DiseasFeatureCell addSubview:line];
        
        return self.DiseasFeatureCell;
    }else if (indexPath.section == 3)//易混淆疾病
    {
        static NSString * cellIdentifier = @"relateDiseaseCellIdentifier";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        NSArray * relateContentArray = self.diseaseDict[@"similarDiseaseContentDict"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //黄色背景盒子
            
            NSString * isShow = kRelateBoxIsShow;
            if ([self.diseaseType isEqualToString:@"A"]) {
                isShow = @"YES";
            }else if ([self.diseaseType isEqualToString:@"B"]){
                isShow = @"NO";
            }
            
            if ([isShow isEqualToString:@"YES"]) {
                UIView * relateBoxView = [[UIView alloc] init];
                relateBoxView.tag = kRelateBoxTag;
                [relateBoxView setBackgroundColor:RGBHex(qwColor15)];
                relateBoxView.layer.borderColor = RGBHex(qwColor15).CGColor;
                relateBoxView.layer.borderWidth = kBoxBorderWidth;
                [cell.contentView addSubview:relateBoxView];
                
                SBTextView * t = [[SBTextView alloc] init];
                t.tag = 3001;
                t.backgroundColor = [UIColor clearColor];
                [relateBoxView addSubview:t];
                
            }
            
            if ([self.diseaseType isEqualToString:@"A"]) {
                //按钮
                for (int i = 0; i<relateContentArray.count; i++) {
                    relateBgView * relateBgV = [[relateBgView alloc] init];
                    relateBgV.delegate = self;
                    relateBgV.tag = kRelateBgViewTag + i;
                    [cell.contentView addSubview:relateBgV];
                }
            }else if ([self.diseaseType isEqualToString:@"B"]){
                SBTextView * relateDiseaseLabel = [[SBTextView alloc] init];
                relateDiseaseLabel.tag = kRelateDiseaseLabelTag;
                [cell.contentView addSubview:relateDiseaseLabel];
            }
            
        }
        //NSArray * viewArray = cell.contentView.subviews;
        CGFloat bg_y = 0;
        
        NSString * isShow = kRelateBoxIsShow;
        if ([self.diseaseType isEqualToString:@"A"]) {
            isShow = @"YES";
        }else if ([self.diseaseType isEqualToString:@"B"]){
            isShow = @"NO";
        }
        
        
        if ([isShow isEqualToString:@"YES"]) {
            CGSize boxSize = CGSizeFromString(self.diseaseDict[@"similarDiseaseTitleSize"]);
            UIView * boxView = (UIView *)[cell.contentView viewWithTag:kRelateBoxTag];
            
            NSString *similarDiseaseTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"similarDiseaseTitle"]];
            if (similarDiseaseTitle != nil && similarDiseaseTitle.length > 0) {
                [boxView setFrame:CGRectMake(kX, kY - 5, APP_W-20, boxSize.height + kB)];
                bg_y += boxSize.height + kY + kB;
            }else{
                [boxView setFrame:CGRectMake(kX, 0, APP_W-20, 0)];
                bg_y += boxSize.height + kY;
            }
            
            SBTextView * t = (SBTextView *)[boxView viewWithTag:3001];
            [t setFrame:CGRectMake(kX - 5, 5, boxSize.width, boxSize.height)];
            t.text = similarDiseaseTitle;
            t.font = font(kFont1, descFontSize);
            
        }
        
        if ([self.diseaseType isEqualToString:@"A"]) {
            for (int i = 0; i < relateContentArray.count; i++) {
                CGSize size = CGSizeFromString(relateContentArray[i][@"bgViewSize"]);
                relateBgView * bgView = (relateBgView *)[cell.contentView viewWithTag:kRelateBgViewTag + i];
                [bgView setFrame:CGRectMake(kX, bg_y, APP_W-20, size.height)];
                bgView.infoDict = relateContentArray[i];
                bg_y += size.height;
                
//                NSString *similarDiseaseContent = [self replaceSpecialStringWith:self.diseaseDict[@"similarDiseaseContent"]];
            }
        }else if ([self.diseaseType isEqualToString:@"B"]){
            SBTextView * relateDiseaseLabel = (SBTextView *)[cell.contentView viewWithTag:kRelateDiseaseLabelTag];
            
            relateDiseaseLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"similarDiseaseContent"]];
            relateDiseaseLabel.font = font(kFont1, descFontSize);
            CGSize relateDiseaseSize = CGSizeFromString(self.diseaseDict[@"similarDiseaseContentSize"]);
            [relateDiseaseLabel setFrame:CGRectMake(kX, kY, APP_W-20, relateDiseaseSize.height)];
        }
        
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10,0.5, APP_W-10, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [cell.contentView addSubview:line];
        
        
        return cell;
    }else if (indexPath.section == 4){//治疗原则
        static NSString * cellIdentifier = @"treatDiseaseCellIdentifier";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        NSArray * formulaList;
        if ([self.diseaseDict[@"formulaList"] isKindOfClass:[NSArray class]]) {
            formulaList = self.diseaseDict[@"formulaList"];
        }
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView * relateBoxView = [[UIView alloc] init];
            relateBoxView.tag = kTreatRuleBoxTag;
            [relateBoxView setBackgroundColor:RGBHex(qwColor15)];
            relateBoxView.layer.borderColor = RGBHex(qwColor15).CGColor;
            relateBoxView.layer.borderWidth = 1;
            [cell.contentView addSubview:relateBoxView];
            
            NSString *treatRuleTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleTitle"]];
            if (treatRuleTitle == nil || treatRuleTitle.length == 0 ) {
                relateBoxView.hidden = YES;
            }
            
            SBTextView * titleText = [[SBTextView alloc] init];
            titleText.tag = kTreatRuleTitleTag;
            titleText.backgroundColor = [UIColor clearColor];
            [relateBoxView addSubview:titleText];
            
            
            SBTextView * contentText = [[SBTextView alloc] init];
            contentText.tag = kTreatRuleContentTag;
            contentText.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:contentText];
            
            for (int i = 0; i < formulaList.count; i++) {
                treatRuleBgView * bgView = [[treatRuleBgView alloc] initWithArr:formulaList[i]];
                bgView.delegate = self;
                bgView.tag = kTreatRuleButtonBgView + i;
                [cell.contentView addSubview:bgView];
            }
            //注释掉治疗原则底部三个按钮(2.1.7需求)
//            for (int i = 0; i < 3; i++) {
//                DisesaeDetailInfoButton * threeButton = [DisesaeDetailInfoButton buttonWithType:UIButtonTypeCustom];
//                threeButton.tag = kThreeButtonTag + i;
//                threeButton.layer.borderWidth = 0.5;
//                threeButton.layer.masksToBounds = YES;
//                threeButton.layer.cornerRadius = 3;
//                threeButton.layer.borderColor = RGBHex(kColor24).CGColor;
//                [threeButton addTarget:self action:@selector(threeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//                [cell.contentView addSubview:threeButton];
//            }
            
        }
        CGFloat rule_y = kY - 5;
        CGSize treatRuleTitleSize = CGSizeFromString(self.diseaseDict[@"treatRuleTitleSize"]);

        UIView * treatRuleBoxView = (UIView *)[cell.contentView viewWithTag:kTreatRuleBoxTag];
        if ([self.diseaseType isEqualToString:@"A"]) {
            
            [treatRuleBoxView setFrame:CGRectMake(kX, rule_y, APP_W-20, treatRuleTitleSize.height + kB)];
            NSString *treatRuleTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleTitle"]];
            if (treatRuleTitle == nil || treatRuleTitle.length == 0 ) {
                rule_y += 0;
            }else
            {
                rule_y += treatRuleTitleSize.height + kB;
                rule_y += kB;
            }
            
            
        }else if ([self.diseaseType isEqualToString:@"B"]){
            [treatRuleBoxView setFrame:CGRectMake(kX, rule_y, APP_W-20, 0)];
        }
        
        SBTextView * titleText = (SBTextView *)[treatRuleBoxView viewWithTag:kTreatRuleTitleTag];
        [titleText setFrame:CGRectMake(kX - 5, 5, treatRuleTitleSize.width, treatRuleTitleSize.height)];
        NSString *treatRuleTitle = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleTitle"]];
        titleText.text = treatRuleTitle;
        titleText.font =font(kFont1, descFontSize);
        
        CGSize treatRuleContentSize = CGSizeFromString(self.diseaseDict[@"treatRuleContentSize"]);
        SBTextView * contentText = (SBTextView *)[cell.contentView viewWithTag:kTreatRuleContentTag];
        [contentText setFrame:CGRectMake(kX, rule_y, APP_W-20, treatRuleContentSize.height)];
        contentText.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"treatRuleContent"]];
        contentText.font = font(kFont1, descFontSize);
        
        rule_y += treatRuleContentSize.height + kB;
        
        for (int i = 0; i < formulaList.count; i++) {
            NSDictionary * dic = formulaList[i];
            CGSize ruleBlockSize = CGSizeFromString(dic[@"ruleBlockSize"]);
            treatRuleBgView * bgView = (treatRuleBgView *)[cell.contentView viewWithTag:kTreatRuleButtonBgView + i];
            [bgView setFrame:CGRectMake(0, rule_y, APP_W, ruleBlockSize.height)];
            bgView.infoDict = dic;
            rule_y += ruleBlockSize.height + kB;
        }
        if ([self.diseaseType isEqualToString:@"A"]) {
            rule_y += kY-5;
            CGFloat buttonWidth = (APP_W-20 -20)/3;
            for (int j = 0; j < 3; j++) {
                DisesaeDetailInfoButton * button = (DisesaeDetailInfoButton *)[cell.contentView viewWithTag:kThreeButtonTag + j];
                NSInteger buttonTag = button.tag;
                NSString * buttonName = nil;
                switch (buttonTag) {
                    case kThreeButtonTag:
                        [button setFrame:CGRectMake(kX, rule_y, buttonWidth, kRelateButtonHeight)];
                        buttonName = @"治疗用药";
                        break;
                    case kThreeButtonTag+1:
                        [button setFrame:CGRectMake(kX + buttonWidth + kH, rule_y, buttonWidth, kRelateButtonHeight)];
                        buttonName = @"健康食品";
                        break;
                    case kThreeButtonTag+2:
                        [button setFrame:CGRectMake(kX + (buttonWidth + kH)*2, rule_y, buttonWidth, kRelateButtonHeight)];
                        buttonName = @"医疗用品";
                        break;
                    default:
                        break;
                }
                button.buttonName = buttonName;
                button.titleLabel.font = font(kFont1, titleFontSize);
                [button setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
                [button setTitle:buttonName forState:UIControlStateNormal];
            }
        }
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10,0.5, APP_W-10, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [cell.contentView addSubview:line];
        
        
        return cell;
    }else if (indexPath.section == 5){//合理生活习惯
        if (self.LifeHabitsCell) {
            [self.LifeHabitsCell removeFromSuperview];
        }
        CGSize subTitleSize = CGSizeFromString(self.diseaseDict[@"goodHabitTitleSize"]);
        CGSize contentSize = CGSizeFromString(self.diseaseDict[@"goodHabitContentSize"]);
        NSString *goodHabitTitle  = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"goodHabitTitle"]];
        if (goodHabitTitle == nil || goodHabitTitle.length == 0) {
            [self.habitbgView setFrame:CGRectMake(kX, 0, APP_W-20, 0)];
        }else{
            [self.habitbgView setFrame:CGRectMake(kX, kY - 5, APP_W-20, subTitleSize.height + kB)];
        }
        [self.habitbgView setBackgroundColor:RGBHex(qwColor15)];
        self.habitbgView.layer.borderColor = RGBHex(qwColor15).CGColor;
        self.habitbgView.layer.borderWidth = kBoxBorderWidth;
        
        [self.habitTitleTextView setFrame:CGRectMake(kX - 5, 5, subTitleSize.width, subTitleSize.height)];
        [self.habitContentTextView setFrame:CGRectMake(kX, self.habitbgView.FY + self.habitbgView.FH + kB, contentSize.width, contentSize.height)];
        self.habitTitleTextView.font = font(kFont1, descFontSize);
        self.habitContentTextView.font = font(kFont1, descFontSize);
        
        self.habitTitleTextView.text = goodHabitTitle;
        self.habitContentTextView.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.diseaseDict[@"goodHabitContent"]];
        
        
        self.LifeHabitsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10,0.5, APP_W-10, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [self.LifeHabitsCell addSubview:line];
        
        return self.LifeHabitsCell;
    }
    return nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    //控制展开和收缩
    NSString * expendYES = @"1";
    NSString * expendNO = @"2";
    
    NSString * expendStatus = nil;
    switch (section) {
        case 1:
            expendStatus = self.diseaseDict[@"causeExpend"];
            if ([expendStatus isEqualToString:expendYES]) {
                return 1;
            }else if ([expendStatus isEqualToString:expendNO]){
                return 0;
            }
            break;
        case 2:
            expendStatus = self.diseaseDict[@"traitExpend"];
            if ([expendStatus isEqualToString:expendYES]) {
                return 1;
            }else if ([expendStatus isEqualToString:expendNO]){
                return 0;
            }
            break;
        case 3:
            expendStatus = self.diseaseDict[@"similarExpend"];
            if ([expendStatus isEqualToString:expendYES]) {
                return 1;
            }else if ([expendStatus isEqualToString:expendNO]){
                return 0;
            }
            break;
        case 4:
            expendStatus = self.diseaseDict[@"treatExpend"];
            if ([expendStatus isEqualToString:expendYES]) {
                return 1;
            }else if ([expendStatus isEqualToString:expendNO]){
                return 0;
            }
            break;
        case 5:
            expendStatus = self.diseaseDict[@"habitExpend"];
            if ([expendStatus isEqualToString:expendYES]) {
                return 1;
            }else if ([expendStatus isEqualToString:expendNO]){
                return 0;
            }
            break;
        default:
            break;
    }
    
    
    return 1;
}

#pragma mark
#pragma mark 计算textView的高度
-(CGSize)getTextViewHeightWithContent:(NSString *)content FontSize:(CGFloat)fontSize width:(CGFloat)width
{
    if (content != nil && content.length > 0) {
        CGFloat tvHeight =0.0f;
        SBTextView *textViewTemp = [[SBTextView alloc] initWithFrame:CGRectMake(0, 0, width, 5000)];
        content = [QWGLOBALMANAGER replaceSpecialStringWith:content];
        textViewTemp.text = content;
        textViewTemp.font = font(kFont1, fontSize);
        [textViewTemp sizeToFit];
        if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f){
            tvHeight = [textViewTemp.layoutManager usedRectForTextContainer:textViewTemp.textContainer].size.height+2*fabs(textViewTemp.contentInset.top);
        }else{
            tvHeight = textViewTemp.contentSize.height;
        }
        
        CGSize size = CGSizeMake(textViewTemp.FW, tvHeight);
        
        return size;
    }else{
        return CGSizeMake(0, 0);
    }
}

#pragma mark
#pragma mark -------收藏---------
- (void)collectButtonClick{
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.isPresentType = YES;
        login.parentNavgationController = self.navigationController;
        UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    FavoriteCollectR *collectR=[FavoriteCollectR new];
    collectR.token=QWGLOBALMANAGER.configure.userToken;
    collectR.objId= self.diseaseDict[@"diseaseId"];
    collectR.objType=@"3";
    collectR.method=@"1";//检查对象是否已经收藏
    
    [Favorite collectWithParam:collectR success:^(id DFUserModel) {
        
        CancleResult *model=(CancleResult *)DFUserModel;
        if ([model.apiStatus intValue]==1001003) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:ALERT_MESSAGE delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.tag = 999;
            alertView.delegate = self;
            [alertView show];
            return;
        }else if([model.apiStatus intValue]==0){
        if([model.result isEqualToString:@"1"]){//已经收藏
            collectR.method = @"3";
            [Favorite collectWithParam:collectR success:^(id DFUserModel) {
                CancleResult *subModel=(CancleResult *)DFUserModel;
                if ([subModel.result isEqualToString:@"4"]) {//取消收藏成功
                    [self showSuccess:@"取消收藏成功"];
                    buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
                    self.collectButtonImageName = @"导航栏_收藏icon.png";
                     self.collectButtonName=@"收藏";
                }else if ([subModel.result isEqualToString:@"5"]) {//取消收藏失败
                    [self showError:subModel.apiMessage];
                    return ;
                }
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                    
                }
                return;
            }];
            
        }else if([model.result isEqualToString:@"0"]){
            collectR.method = @"2";
            [Favorite collectWithParam:collectR success:^(id DFUserModel) {
                CancleResult *subModel=(CancleResult *)DFUserModel;
                if ([subModel.result isEqualToString:@"2"]) {//收藏成功
                    [self showSuccess:@"添加收藏成功"];
                    buttonImage.image = [UIImage imageNamed:@"导航栏_已收藏icon.png"];
                    self.collectButtonImageName = @"导航栏_已收藏icon.png";
                    self.collectButtonName=@"取消收藏";
                }else if ([subModel.result isEqualToString:@"3"]) {//收藏失败
                    [self showError:subModel.apiMessage];
                    return ;
                }
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                    
                }
                return;
            }];
        }
    }
    }failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
            
        }
        return;
    }];

    
}

// opType: 1 查询; 2 写入; 3 取消;
- (void)checkIsCollectOrNot
{
    if (QWGLOBALMANAGER.loginStatus) {
        FavoriteCollectR *collectR=[FavoriteCollectR new];
        collectR.token=QWGLOBALMANAGER.configure.userToken;
        collectR.objId=self.diseaseDict[@"diseaseId"];
        collectR.objType=@"3";
        collectR.method=@"1";
        [Favorite collectWithParam:collectR success:^(id DFUserModel) {
            CancleResult *model=(CancleResult *)DFUserModel;
            if ([model.result isEqualToString:@"1"]) {
                buttonImage.image = [UIImage imageNamed:@"导航栏_已收藏icon.png"];
                self.collectButtonImageName = @"导航栏_已收藏icon.png";
                self.collectButtonName=@"取消收藏";
            }else if([model.result isEqualToString:@"0"]){
                buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
                self.collectButtonImageName = @"导航栏_收藏icon.png";
                self.collectButtonName=@"收藏";
            }
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
            return;
        }];
    }
}

#pragma mark -------去登陆---------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 999) {
        if (buttonIndex == 0) {
            LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            login.isPresentType = YES;
            login.parentNavgationController = self.navigationController;
            UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}


#pragma mark -------放大缩小字体---------
- (void)zoomButtonClick{
    if (descFontSize == 20) {
        isUp = NO;
    }else if(descFontSize == 14){
        isUp = YES;
    }
    
    if (isUp) {
        descFontSize+=3;
        titleFontSize+=3;
    }else{
        descFontSize = kDescFontSize;//12
        titleFontSize = kTitleFontSize;//14
    }
    [self coverData];
}

#pragma mark
#pragma mark 点击展开 收缩段
- (void)sectionExpandClick:(UIButton *)button
{
    //控制展开和收缩
    NSString * expendYES = @"1";
    NSString * expendNO = @"2";
    
    
    
    
    NSString * expendStatus = nil;
    NSString * sectionName = nil;
    switch (button.tag) {
        case 1:
        {
            expendStatus = self.diseaseDict[@"causeExpend"];
            sectionName = @"causeExpend";
        }
            break;
        case 2:
        {
            expendStatus = self.diseaseDict[@"traitExpend"];
            sectionName = @"traitExpend";
        }
            break;
        case 3:
        {
            expendStatus = self.diseaseDict[@"similarExpend"];
            sectionName = @"similarExpend";
        }
            break;
        case 4:
        {
            expendStatus = self.diseaseDict[@"treatExpend"];
            sectionName = @"treatExpend";
        }
            break;
        case 5:
        {
            expendStatus = self.diseaseDict[@"habitExpend"];
            sectionName = @"habitExpend";
        }
            break;
        default:
            break;
    }
    
    //先隐藏所有
    [self.diseaseDict setObject:expendNO forKey:@"causeExpend"];
    [self.diseaseDict setObject:expendNO forKey:@"traitExpend"];
    [self.diseaseDict setObject:expendNO forKey:@"similarExpend"];
    [self.diseaseDict setObject:expendNO forKey:@"treatExpend"];
    [self.diseaseDict setObject:expendNO forKey:@"habitExpend"];
    
    if ([expendStatus isEqualToString:expendYES]) {
        [self.diseaseDict setObject:expendNO forKey:sectionName];
    }else if ([expendStatus isEqualToString:expendNO]){
        [self.diseaseDict setObject:expendYES forKey:sectionName];
    }
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:button.tag];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    //CGRect rect = [self.tableView convertRect:button.frame toView:self.view];
    
    //滑动sectionView算法
    CGRect rect = [self.tableView rectForSection:button.tag];//或者本sectionView在self.View中得位置
    CGSize contentSize = self.tableView.contentSize;
    if (contentSize.height > self.view.bounds.size.height) { //tableView的contentSize高度超出屏幕
        CGFloat offSet = fabs(contentSize.height - self.view.bounds.size.height); //超出多少高度
        
        CGFloat sectionView_y = rect.origin.y;
        CGFloat scrollViewOffSet = 0;
        //以高度较小的为准
        if (offSet > sectionView_y) { //如果超出部分大于 sectionView_y高度,则tableView向上滑动sectionView_y高度
            scrollViewOffSet = sectionView_y;
        }else{                        // 否则向上滑动offSet高度
            scrollViewOffSet = offSet;
        }
        [self.tableView setContentOffset:CGPointMake(0, scrollViewOffSet) animated:YES];
    }
}

- (void)threeButtonClick:(DisesaeDetailInfoButton *)btn
{
    NSInteger buttonTag = btn.tag;
    NSNumber * typeNumber = [[NSNumber alloc] init];
    switch (buttonTag) {
        case kThreeButtonTag:
            typeNumber = @1;
            break;
            
        case kThreeButtonTag+1:
            typeNumber = @2;
            break;
        case kThreeButtonTag+2:
            typeNumber = @3;
            break;
        default:
            break;
    }
    DiseaseMedicineListViewController* vc = [[DiseaseMedicineListViewController alloc] init];
    vc.title = btn.buttonName;
    vc.params = @{@"diseaseId":self.diseaseDict[@"diseaseId"], @"type":typeNumber};
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark
#pragma mark 治疗原则相关药品
- (void)treatRuleBgViewButtonClick:(NSDictionary *)buttonDict
{
    DiseaseMedicineListViewController* vc = [[DiseaseMedicineListViewController alloc] init];
    vc.title = buttonDict[@"formulaName"];
    vc.params = @{@"diseaseId":self.diseaseDict[@"diseaseId"], @"formulaId":buttonDict[@"formulaId"]};
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark
#pragma mark 相关疾病
- (void)relateBgViewDiseaseButtonClick:(NSString *)buttonName button:(DisesaeDetailInfoButton *)button
{
    
    if (QWGLOBALMANAGER.currentNetWork==kNotReachable) {
        [self showError:kWarningN2];
        button.enabled = YES;
        return;
    }
    diseaseDetaileIosR *detaileIosR=[diseaseDetaileIosR new];
    detaileIosR.diseaseId=buttonName;
    HttpClientMgr.progressEnabled = NO;
    [Disease getDiseaseDetailIOSWithParam:detaileIosR success:^(id obj) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic addEntriesFromDictionary:obj];
        if ([obj[@"diseaseId"] isEqualToString:@""]) {
            [self showError:@"暂无疾病详情"];
            button.enabled = YES;
            return ;
        }
        NSString *title = buttonName;
        NSString *diseaseId = obj[@"diseaseId"];

        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        vcWebDirect.showConsultBtn = YES;
        
        WebDiseaseDetailModel *modelDisease = [[WebDiseaseDetailModel alloc] init];
        modelDisease.diseaseId = diseaseId;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        modelLocal.modelDisease = modelDisease;
        modelLocal.title = title;
        modelLocal.typeTitle = WebTitleTypeOnlyShare;
        modelLocal.typeLocalWeb = WebPageToWebTypeDisease;
        [vcWebDirect setWVWithLocalModel:modelLocal];
        
        vcWebDirect.showConsultBtn = YES;
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];

        button.enabled = YES;
    } failure:^(HttpException *e) {
        button.enabled = YES;
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
            
        }
        return;
    }];
    
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotiWhetherHaveNewMessage == type) {
        
        NSString *str = data;
        self.passNumber = [str integerValue];
        self.indexView.passValue = self.passNumber;
        [self.indexView.tableView reloadData];
        if (self.passNumber > 0)
        {
            //显示数字
            self.numLabel.hidden = NO;
            self.redLabel.hidden = YES;
            if (self.passNumber > 99) {
                self.passNumber = 99;
            }
            self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
            
        }else if (self.passNumber == 0)
        {
            //显示小红点
            self.numLabel.hidden = YES;
            self.redLabel.hidden = NO;
            
        }else if (self.passNumber < 0)
        {
            //全部隐藏
            self.numLabel.hidden = YES;
            self.redLabel.hidden = YES;
        }
    }
}

#pragma mark
#pragma mark 浮动咨询按钮

- (void)createCosutomButton
{
    //增加咨询的按钮
    
    avatarButton = [[RCDraggableButton alloc] initWithFrame:CGRectMake(APP_W-68, SCREEN_H-142, 45, 45)];
    [avatarButton setBackgroundImage:[UIImage imageNamed:@"img_btn_advisory"] forState:UIControlStateNormal];
    [self.view addSubview:avatarButton];//加载图片
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(consultDoctor:)];
    [avatarButton addGestureRecognizer:singleTap];//点击图片事件
    [self.view addSubview:avatarButton];//加载图片
}




//跳转到咨询页面
- (IBAction)consultDoctor:(id)sender {
    ConsultForFreeRootViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultForFreeRootViewController"];
    
    consultViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:consultViewController animated:YES];
    
}


@end