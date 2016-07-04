
//
//  FactoryDetail.m
//  quanzhi
//
//  Created by ZhongYun on 14-6-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "FactoryDetailViewController.h"
#import "FactoryMedicineListViewController.h"
#import "ReturnIndexView.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"
#import "WebDirectViewController.h"


#define MAX_DESC_H  12 * 4
@interface FactoryDetailViewController ()<ReturnIndexViewDelegate>
{
    UIView * labelView;
    UILabel * subLabel;
    UIView * medicineView;
    
    CGFloat subTextHeight;
    
    UIScrollView * scrollView;
    int current;
    BOOL isExpand;
    UIButton * textMore;
    UIImageView* arrImg;
    
    UIView *linefirst;
}
@property (nonatomic ,strong) NSMutableDictionary * dataDic;
@property (nonatomic ,strong) NSMutableArray * moreDataSource;
@property (nonatomic ,strong) ReturnIndexView *indexView;
@property (nonatomic ,assign) CGSize oriScrollViewSize;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end

@implementation FactoryDetailViewController

- (id)init{
    if (self = [super init]) {
        current = 0;
    }
    return self;
}

- (void)factoryViewDidLoad{
    
    isExpand = NO;
    self.dataDic = [NSMutableDictionary dictionary];
    self.moreDataSource = [NSMutableArray array];
    
    labelView = [[UIView alloc] init];
    labelView.backgroundColor = [UIColor whiteColor];
    subLabel = [[UILabel alloc] init];
    medicineView = [[UIView alloc] init];
    medicineView.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    scrollView.backgroundColor =[UIColor clearColor];
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:scrollView];

}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self factoryViewDidLoad];
    [self loadData];
}

#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, -2, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 1, 18, 18)];
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
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
    
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
- (void)returnIndex
{
   self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"ic_img_notice",@"icon home.PNG"] title:@[@"消息",@"首页"] passValue:self.passNumber];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    
    if (indexPath.row == 0)
    {
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
        
    }else if (indexPath.row == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }

}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"品牌详情";
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}


- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self factoryViewDidLoad];
    }
}


- (void)loadData{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:@"网络未连接，请重试" image:@"网络信号icon.png"];
        return;
    }
    FactoryDetailModelR *modelR = [FactoryDetailModelR new];
    modelR.factoryCode = self.factoryId;
    
    [Factory queryFactoryDetailWithParam:modelR success:^(id Model) {
        [self.dataDic removeAllObjects];
        [self removeInfoView];
        FactoryDetailModel *factoryDetail = Model;
        if([factoryDetail.apiStatus intValue]==1&&self.bannerStatus==1){
            [self showInfoView:@"暂无数据" image:@"ic_img_fail"];
            return;
        }
        [self.dataDic addEntriesFromDictionary:[factoryDetail dictionaryModel]];
        [self performSelectorOnMainThread:@selector(loadDetail) withObject:nil waitUntilDone:YES];
        
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


- (void)loadDetail{
    
    FactoryProductListModelR *modelR = [FactoryProductListModelR new];
    modelR.factoryCode = self.factoryId;
    modelR.currPage = @"1";
    modelR.pageSize = @"10";
    
    [Factory queryFactoryProductListWithParam:modelR success:^(id Model) {
        
        [self.moreDataSource removeAllObjects];
        [self removeInfoView];
        FactoryProductList *productsList = (FactoryProductList *)Model;
        [self.moreDataSource addObjectsFromArray:productsList.list];
        
        [self performSelectorOnMainThread:@selector(buildDetailObjs) withObject:nil waitUntilDone:YES];
        
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


- (void)buildDetailObjs{
    
    CGSize titleSize=[GLOBALMANAGER sizeText:self.dataDic[@"name"] font:fontSystem(kFontS4) limitWidth:APP_W-20];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_W-20, titleSize.height)];
    titleLabel.text = self.dataDic[@"name"];
    titleLabel.font = font(kFont1, kFontS4);
    titleLabel.textColor = RGBHex(qwColor6);
    [labelView addSubview:titleLabel];
    labelView.layer.borderColor=RGBHex(qwColor10).CGColor;
    labelView.layer.borderWidth=0.5;
    
    CGSize subLabelSize=[GLOBALMANAGER sizeText:self.dataDic[@"desc"] font:fontSystem(kFontS4) limitWidth:APP_W-20];
    
    subTextHeight = subLabelSize.height;
    CGFloat sub_h;
    if (subLabelSize.height > 165) {
        sub_h = 165;
    }else{
        sub_h = subLabelSize.height+5;
    }
    
    
    [subLabel setFrame:CGRectMake(10, 34, APP_W-20, sub_h)];
    subLabel.font = fontSystem(kFontS4);
    subLabel.numberOfLines = 0;
    subLabel.text = self.dataDic[@"desc"];
    subLabel.textColor = RGBHex(qwColor6);
    [labelView addSubview:subLabel];
    
    CGFloat view_h = subLabel.frame.origin.y + subLabel.frame.size.height + 10;
    
    if (subLabelSize.height > 160) {
        if(!textMore){
            textMore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            arrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownAccessory.png"]];
        }
        textMore.frame = CGRectMake(APP_W-83, subLabel.frame.origin.y + subLabel.frame.size.height + 10, 83, 30);
        textMore.titleLabel.font = fontSystem(kFontS5);
        [textMore setTitle:@"更多" forState:UIControlStateNormal];
        [textMore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [textMore addTarget:self action:@selector(textMoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        arrImg.frame = RECT(50, (textMore.frame.size.height-arrImg.frame.size.height)/2,
                            arrImg.frame.size.width, arrImg.frame.size.height);
        [textMore addSubview:arrImg];
        view_h += textMore.frame.size.height;
        [labelView addSubview:textMore];
    }
    [labelView setFrame:CGRectMake(0, 0, APP_W, view_h)];

    
    [scrollView addSubview:labelView];
    
    
    if(self.moreDataSource.count == 0){
        return;
    }
    UIView *linesecond=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    [linesecond setBackgroundColor:RGBHex(qwColor10)];
    [medicineView addSubview:linesecond];
    //217的优化点  UI
//    [linefirst setFrame:CGRectMake(0, -10, APP_W, 0.5)];
//    [linefirst setBackgroundColor:RGBHex(qwColor10)];
//    [medicineView addSubview:linefirst];
    
    //主要产品
    CGSize tSize=[GLOBALMANAGER sizeText:@"主要产品" font:fontSystem(kFontS3) limitWidth:APP_W-20];
    
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, APP_W, tSize.height)];
    titleLab.text = @"主要产品";
    titleLab.textColor = RGBHex(qwColor6);
    titleLab.font = font(kFont1, kFontS3);
    [medicineView addSubview:titleLab];
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLab.frame.origin.y + titleLab.frame.size.height + 10, APP_W, 2)];
    line.tag = 12345;
    line.backgroundColor = RGBHex(qwColor1);
    [medicineView addSubview:line];
    
    
    
    ////////////// 添加药品列表 /////////////////////
    
    CGFloat pos_y = line.frame.origin.y + line.frame.size.height + 10;
    int num =(int)(self.moreDataSource.count / 3);
    if (self.moreDataSource.count%3 > 0)
        num++;
    CGFloat mw = 77;
    CGFloat mh = mw+2+12*2;
    CGFloat me = (APP_W-mw*3)/4;
    CGFloat mx = me;
    NSInteger countDataSource = 0;
    if (self.moreDataSource.count > 6) {
        countDataSource = 6;
    } else {
        countDataSource = self.moreDataSource.count;
    }
    for (int i = 0; i < countDataSource; i++) {
        FactoryProduct* item = self.moreDataSource[i];
        InfoButton* detailBtn = [[InfoButton alloc] initWithFrame:RECT(mx, pos_y, mw, mh)];
        detailBtn.info = (FactoryProduct *)item;
        [detailBtn addTarget:self action:@selector(onMedicDetailTouched:) forControlEvents:UIControlEventTouchUpInside];
        [medicineView addSubview:detailBtn];
        
//        NSString* imgurl = PORID_IMAGE(item.proId);
        NSString* imgurl=item.imgUrl;
        UIImageView* medicImg = [[UIImageView alloc] initWithFrame:RECT(0, 0, detailBtn.frame.size.width, detailBtn.frame.size.width)];
        medicImg.backgroundColor = [UIColor clearColor];
        [medicImg setImageWithURL:[NSURL URLWithString:imgurl]
                 placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
        medicImg.clipsToBounds = YES;
        medicImg.contentMode = UIViewContentModeScaleToFill;
        [detailBtn addSubview:medicImg];
        
        UILabel* medicTitle = [[UILabel alloc] initWithFrame:RECT(0, medicImg.frame.size.height+5, detailBtn.frame.size.width, 24)];
        medicTitle.text = item.proName;
        medicTitle.textAlignment = NSTextAlignmentCenter;
        medicTitle.textColor = RGBHex(qwColor6);
        medicTitle.font = fontSystem(kFontS5);
        medicTitle.numberOfLines = 1;
        [detailBtn addSubview:medicTitle];
        
        mx += (detailBtn.frame.size.width + me);
        if ((APP_W-mx)<me || (item==[self.moreDataSource lastObject])) {
            mx = me;
            pos_y += (detailBtn.frame.size.height + 10);
        }
    }
    NSInteger numb;
    CGFloat block_h = 0;
    if (self.moreDataSource.count > 3) {
        numb = 2;
        block_h = 10;
    }else{
        numb = 1;
    }
    
    [medicineView setFrame:CGRectMake(0, labelView.frame.origin.y + labelView.frame.size.height + 10, APP_W, line.frame.origin.y + line.frame.size.height + 10 + 103*numb + 10 + block_h)];


    UIView *linethree=[[UIView alloc]initWithFrame:CGRectMake(0,medicineView.frame.size.height, APP_W, 0.5)];
    [linethree setBackgroundColor:RGBHex(qwColor10)];
    [medicineView addSubview:linethree];
    
    [scrollView addSubview:medicineView];
    
    CGFloat button_h = 0.0;
    
    if (self.moreDataSource.count > 6) {
        UIButton * moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [moreButton setFrame:CGRectMake(220, medicineView.frame.origin.y + medicineView.frame.size.height + 10, 80, 28)];
        [moreButton setBackgroundColor:RGBHex(qwColor1)];
        moreButton.tag = 567;
        
        moreButton.layer.masksToBounds = YES;
        moreButton.layer.cornerRadius = 2.5f;
        [moreButton setTitle:@"更多药品" forState:UIControlStateNormal];
        [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        if(current == 0){
            [scrollView addSubview:moreButton];
        }
        current ++;
        button_h = moreButton.frame.origin.y + moreButton.frame.size.height;
    }
    

    if (self.moreDataSource.count > 6) {
        scrollView.contentSize = CGSizeMake(APP_W, button_h + 20);
    } else {
        scrollView.contentSize = CGSizeMake(APP_W, medicineView.frame.origin.y+medicineView.frame.size.height + 20);
    }
    scrollView.scrollEnabled = YES;
    self.oriScrollViewSize = scrollView.contentSize;
}

- (void)onMedicDetailTouched:(InfoButton*)sender
{

    FactoryProduct *info=sender.info;
    [self pushToDrugDetailWithDrugID:info.proId promotionId:info.promotionId];
    
}

- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID{
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];

    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
//    modelDrug.showDrug = @"1";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//    modelLocal.title = @"药品详情";
    modelLocal.modelDrug = modelDrug;
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}


//删除动画效果
//- (IBAction)popVCAction:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:NO];
//}


- (void)moreButtonClick{
    
    FactoryMedicineListViewController *viewControllerList = [[FactoryMedicineListViewController alloc] init];
    viewControllerList.strFactoryID = self.factoryId;
    [self.navigationController pushViewController:viewControllerList animated:YES];
}

- (void)textMoreButtonClick{
    
        if (isExpand) {
            [subLabel setFrame:CGRectMake(10, 34, APP_W-20, 165)];
            isExpand = NO;
            [textMore setTitle:@"更多" forState:UIControlStateNormal];
            arrImg.image = [UIImage imageNamed:@"DownAccessory.png"];
        }else{
            [subLabel setFrame:CGRectMake(10, 34, APP_W-20, subTextHeight+10)];
            [textMore setTitle:@"收起" forState:UIControlStateNormal];
            arrImg.image = [UIImage imageNamed:@"UpAccessory.png"];
            isExpand = YES;
        }
    
    NSInteger numb;
    CGFloat block_h = 0;
    if (self.moreDataSource.count > 3) {
        numb = 2;
        block_h = 10;
    }else{
        numb = 1;
    }
    UILabel * line = (UILabel *)[medicineView viewWithTag:12345];
    [UIView animateWithDuration:0.4 animations:^{

        [textMore setFrame:CGRectMake(APP_W-83, subLabel.frame.origin.y + subLabel.frame.size.height, 83, 30)];
        [labelView setFrame:CGRectMake(0, 0, APP_W, textMore.frame.size.height + textMore.frame.origin.y)];
        [medicineView setFrame:CGRectMake(0, labelView.frame.origin.y + labelView.frame.size.height + 10, APP_W, line.frame.origin.y + line.frame.size.height + 10 + 103*numb + 10 + block_h)];
        if (self.moreDataSource.count > 6) {
            UIButton * btn = (UIButton *)[scrollView viewWithTag:567];
            [btn setFrame:CGRectMake(220, medicineView.frame.origin.y + medicineView.frame.size.height + 10, 80, 28)];
        }else{
        }
    }];
    if (isExpand) {

        if (self.moreDataSource.count > 6) {
            UIButton * btn = (UIButton *)[scrollView viewWithTag:567];
            scrollView.contentSize = CGSizeMake(APP_W, btn.frame.origin.y + btn.frame.size.height + 20);
        }else{
            scrollView.contentSize = CGSizeMake(APP_W, medicineView.frame.origin.y+medicineView.frame.size.height+20.0f);
        }
    } else {
        scrollView.contentSize = self.oriScrollViewSize;
    }
    
    
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

@end
