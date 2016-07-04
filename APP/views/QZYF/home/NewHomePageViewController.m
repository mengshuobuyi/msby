//
//  NewHomePageViewController.m
//  wenyao
//
//  Created by garfield on 15/1/19.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "NewHomePageViewController.h"
#import "UIImageView+WebCache.h"

#import "PharmacyStoreViewController.h"
#import "PharmacyStoreDetailViewController.h"
#import "Constant.h"
//#import "MessageBoxViewController.h"
#import "FamiliarQuestionViewController.h"
#import "newConsultPharmacyViewController.h"
//#import "CouponHomePageViewController.h"
#import "FactoryDetailViewController.h"
#import "MarketDetailViewController.h"
#import "HealthIndicatorDetailViewController.h"
#import "Promotion.h"
#import "SearchViewController.h"
#import "ScanReaderViewController.h"
#import "SBJSON.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "BannerModel.h"
#import "Problem.h"
#import "Store.h"
#import "QWConstant.h"
#import "Coupon.h"
#import "ConsultFirstViewController.h"
#import "MessageBoxListViewController.h"
#import "NotificationModel.h"
#import "PharmacyStoreDetailViewController.h"
#import "QYPhotoAlbum.h"
#import "swiftModule-swift.h"
#import "APP-Bridging-Header.h"
#import "ConsultForFreeRootViewController.h"
#import "ZipArchive.h"
#import "XMPPStream.h"
#import "APPCommentAlert.h"
#import "WebDirectViewController.h"
#import "CouponPromotionHomePageViewController.h"
#import "ConfigInfo.h"
#import "UIButton+WebCache.h"
#import "ProjectTemplateOneTableViewCell.h"
#import "ProjectTemplateSecondTableViewCell.h"
#import "ProjectTemplateTableViewCell.h"
#import "CouponPharmacyDeailViewController.h"
#import "LoginViewController.h"
#import "DeviceInfoWebModel.h"
#import "CustomInfoAlertView.h"
#import "CityListViewController.h"
#import "Search.h"
#import "CenterOperatingPointCell.h"



static NSString  *const ProjectTemplateOneIdentifier = @"ProjectTemplateOneIdentifier";
static NSString  *const ProjectTemplateSecondIdentifier = @"ProjectTemplateSecondIdentifier";
static NSString  *const ProjectSimpeContentIdentifier = @"ProjectSimpeContentIdentifier";


@interface NewHomePageViewController ()<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,UIAlertViewDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //用户地理位置
    CLLocation          *userLocation;
    
    //轮播banner数据源
    NSMutableArray      *bannerArray;

    MapInfoModel        *globalMapInfo;
    //当前banner停留在哪个Index索引
    int                 pushIndex;
    UIButton            *btn;
    
    MapInfoModel        *checkInfoModel;
}
//热词标签
@property (weak, nonatomic) IBOutlet UILabel *HotWordLabel;
//背景刷新的图片的高度,根据后台设置的图片配置等比例高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *refreshImageHeight;
@property (weak, nonatomic) IBOutlet UIImageView *refreshImageView;

@property (weak, nonatomic) IBOutlet UIView *searchContainer;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) XLCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UIView *bannerContaier;
@property (weak, nonatomic) IBOutlet UILabel *searchTextLabel;

@property (nonatomic, copy)   dispatch_source_t         countDownTimer;       //抢购倒数计时器

//是否已经显示通告栏,通告栏的关闭与隐藏由本地保存,不进行服务器通信


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorWidth1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorWidth2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorWidth3;




@property (nonatomic, strong) NSString          *lastCityName;
@property (nonatomic, strong) NSString          *currentProvinceName;
@property (nonatomic, strong) NSString          *currentCityName;

@property (weak, nonatomic) IBOutlet UIView *headerContainer;
@property (weak, nonatomic) IBOutlet UIImageView *searchBackGroundImage;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bulletinBoardHeight;

@property (weak, nonatomic) IBOutlet UIImageView *freeConsultImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nearByStoreImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bulletinBoardImageView;
@property (weak, nonatomic) IBOutlet UIView *bulletinBoardContainer;
@property (weak, nonatomic) IBOutlet UILabel *bulletinBoardLabel;
@property (weak, nonatomic) IBOutlet UIButton *preferentialGoods;
@property (weak, nonatomic) IBOutlet UIButton *preferentialTicket;
@property (strong,nonatomic) NSMutableArray   *ForumAreaList;
@property (strong, nonatomic) UITapGestureRecognizer    *bulletinTapGesture;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//首页运营点Model,多处需要使用,故全局保存
@property (nonatomic, strong) HomePageEleVoModel  *homePageEleVoModel;

//以下若干约束,需要适配iPhone6 6p适配 约束需要根据比例重新设置
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthButtonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerContainerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerButtonWidth;

@end

@implementation NewHomePageViewController

//右上角进入消息盒子
- (void)pushIntoMessageBox:(id)sender
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
    if(sender) {
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
    }else{
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
    }
}

//关闭通告栏
- (IBAction)closeBulletinBoard:(id)sender
{
    NSString *branchId = self.homePageEleVoModel.circular.uId;
    if(branchId) {
        [QWUserDefault setObject:[NSNumber numberWithBool:NO] key:branchId];
    }
    //[self closeBulletinConstraint];
}


//推入扫描界面
- (void)scanAction:(id)sender
{
    StatisticsModel *model = [StatisticsModel new];
    model.eventId = @"e_index_scanss";
    [QWCLICKEVENT qwTrackEventModel:model];
    
    if (![QYPhotoAlbum checkCameraAuthorizationStatus]) {
        [self showError:kWarning42];
        return;
    }
    ScanReaderViewController *scanReaderViewController = [[ScanReaderViewController alloc] initWithNibName:@"ScanReaderViewController" bundle:nil];
    scanReaderViewController.useType = Enum_Scan_Items_Normal;
    scanReaderViewController.delegatePopVC = self;
    scanReaderViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanReaderViewController animated:YES];
}

//初始化TableView
- (void)setupTableView
{
    if(!self.tableView.tableHeaderView) {
        [self.tableView registerNib:[UINib nibWithNibName:@"ProjectTemplateOneTableViewCell" bundle:nil] forCellReuseIdentifier:ProjectTemplateOneIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:@"ProjectTemplateSecondTableViewCell" bundle:nil] forCellReuseIdentifier:ProjectTemplateSecondIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:@"ProjectTemplateTableViewCell" bundle:nil] forCellReuseIdentifier:ProjectSimpeContentIdentifier];
        if(iOSv7_1) {
            self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:self.headerContainer.bounds];
            [self.tableView.tableHeaderView addSubview:self.headerContainer];
        }else{
            self.tableView.tableHeaderView = self.headerContainer;
        }
    }
}

//推入药品详情界面
- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID mapInfo:(MapInfoModel *)modelMap
{
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
    modelDrug.showDrug = @"0";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.title = @"药品详情";
    modelLocal.modelDrug = modelDrug;
    modelLocal.typeLocalWeb = WebLocalTypeCouponProduct;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    vcWebMedicine.vcHolder = self;
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

//免费问药
- (IBAction)pushIntoFreeConsult:(id)sender
{
    StatisticsModel *model=[StatisticsModel new];
    model.eventId=@"e_im_mianfeizixun";
    [QWCLICKEVENT qwTrackEventModel:model];
    StatisticsModel *modelt = [StatisticsModel new];
    modelt.eventId = @"e_freeask_source";
    modelt.params = @{@"咨询来源":@"首页tab"};
    [QWCLICKEVENT qwTrackEventModel:modelt];
    ConsultForFreeRootViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultForFreeRootViewController"];
    consultViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:consultViewController animated:YES];
    
//    ConsultFirstViewController *consultFirstViewController = [[ConsultFirstViewController alloc] init];
//    consultFirstViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:consultFirstViewController animated:YES];
}

//推入附近药房
- (IBAction)pushIntoNearByStore:(id)sender
{
    newConsultPharmacyViewController *consultPharmacyViewController = [[newConsultPharmacyViewController alloc] init];
    consultPharmacyViewController.hidesBottomBarWhenPushed = YES;
    if (checkInfoModel) {
        consultPharmacyViewController.cityCloseInfoModel = checkInfoModel;
    }

    consultPharmacyViewController.comeFromHomePage = YES;
    [self.navigationController pushViewController:consultPharmacyViewController animated:YES];
}


//初始化滚动条以及tableViewHeader约束
- (void)setupView
{
    if(!self.cycleScrollView) {
        self.cycleScrollView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_W,  self.bannerHeight.constant)];
        self.cycleScrollView.delegate = self;
        self.cycleScrollView.datasource = self;
//        self.cycleScrollView.scrollView.scrollEnabled = NO;
        [self.bannerContaier addSubview:self.cycleScrollView];
        
        [self.bannerContaier addConstraint:[NSLayoutConstraint constraintWithItem:self.cycleScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.bannerContaier attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
        [self.bannerContaier addConstraint:[NSLayoutConstraint constraintWithItem:self.cycleScrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.bannerContaier attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
        
        [self.bannerContaier addConstraint:[NSLayoutConstraint constraintWithItem:self.cycleScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bannerContaier attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self.bannerContaier addConstraint:[NSLayoutConstraint constraintWithItem:self.cycleScrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bannerContaier attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        
        self.cycleScrollView.pageControl.pageIndicatorTintColor = RGBHex(qwGcolor8);
        self.cycleScrollView.pageControl.currentPageIndicatorTintColor = RGBHex(qwMcolor1);
        self.cycleScrollView.pageControl.hidesForSinglePage = YES;
        self.cycleScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        

    }
}

- (void)saveBannerCache:(NSArray *)bannerList
{
    [BannerInfoModel deleteAllObjFromDB];
    [BannerInfoModel saveObjToDBWithArray:bannerList];
}

- (void)loadBannerCache
{
    NSArray *array = [BannerInfoModel getArrayFromDBWithWhere:nil];
    if(array && array.count > 0) {
        [bannerArray addObjectsFromArray:array];
        [self.cycleScrollView reloadData];
        self.cycleScrollView.scrollView.scrollEnabled = YES;
    }
}

- (void)saveConfigInfoCache:(id)responModel
{
    [QWUserDefault setString:[responModel JSONRepresentation] key:HomePageEleVoModelKey];
}

- (void)loadConfigInfo
{
    id homePageEleVoModel = [[QWUserDefault getStringBy:HomePageEleVoModelKey] JSONValue];
    HomePageEleVoModel *homeModel = [HomePageEleVoModel parse:homePageEleVoModel Elements:[ConfigInfoModel class] forAttribute:@"icons"];
    HomePageEleVoModel *homeModel3 = [HomePageEleVoModel parse:homePageEleVoModel Elements:[ConfigInfoModel class] forAttribute:@"couponCover"];
    homeModel.couponCover = homeModel3.couponCover;
    self.homePageEleVoModel = homeModel;
    [self fillupOperatingPoint:homeModel];
}


//运营点接口,包括滚动Bannder图片
- (void)queryConfigInfo
{
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        ConfigInfoQueryModelR *modelR = [ConfigInfoQueryModelR new];
        if(mapInfoModel) {
            modelR.province = mapInfoModel.province;
            modelR.city = mapInfoModel.city;
        }else{
            modelR.province = @"江苏省";
            modelR.city = @"苏州市";
        }
        //获取运营点 数据
        [ConfigInfo configInfoQuery:modelR success:^(id responModel) {
            HomePageEleVoModel *homeModel = [HomePageEleVoModel parse:responModel Elements:[ConfigInfoModel class] forAttribute:@"icons"];
            HomePageEleVoModel *homeModel3 = [HomePageEleVoModel parse:responModel Elements:[ConfigInfoModel class] forAttribute:@"couponCover"];
            homeModel.couponCover = homeModel3.couponCover;
            if([homeModel.apiStatus integerValue] == 0)
            {
                [self saveConfigInfoCache:responModel];
                self.homePageEleVoModel = homeModel;
                [self fillupOperatingPoint:_homePageEleVoModel];
            }
        } failure:NULL];
        modelR.place = @"1";
        [self.cycleScrollView stopAutoScroll];
        HttpClientMgr.progressEnabled=NO;
        self.cycleScrollView.userInteractionEnabled = NO;
        
        //获取首页Banner接口
        [ConfigInfo configInfoQueryBanner:modelR success:^(BannerInfoListModel *responModel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *bannerList = responModel.list;
                if([responModel.apiStatus intValue] == 0){
                    if(bannerList.count > 0){
                        [bannerArray removeAllObjects];
                        [bannerArray addObjectsFromArray:bannerList];
                        [self saveBannerCache:bannerList];
                        
                        [self.cycleScrollView reloadData];
                    }
                }else{
                    [bannerArray removeAllObjects];
                    [self.cycleScrollView reloadData];
                }
                self.cycleScrollView.userInteractionEnabled = YES;
            });
            
        } failure:^(HttpException *e) {
            self.cycleScrollView.datasource = self;
            self.cycleScrollView.delegate = self;
            self.cycleScrollView.userInteractionEnabled = YES;
        }];
    }];
}


//填充首页运营点数据
- (void)fillupOperatingPoint:(HomePageEleVoModel *)model
{
    if(model.icons) {
        for(ConfigInfoModel *icon in model.icons)
        {
            if([icon.iconPos intValue] == 1) {
                [_freeConsultImageView setImageWithURL:[NSURL URLWithString:icon.imgUrl] placeholderImage:[UIImage imageNamed:@"首页_免费问药"]];
            }else if([icon.iconPos intValue] == 2) {
                [_nearByStoreImageView setImageWithURL:[NSURL URLWithString:icon.imgUrl] placeholderImage:[UIImage imageNamed:@"首页_附近药店"]];
            }
        }
    }
    if(model.couponCover) {
        for(ConfigInfoModel *couponCover in model.couponCover)
        {
            if([couponCover.type intValue] == 7) {
                //优惠券封面
                [_preferentialTicket setBackgroundImageWithURL:[NSURL URLWithString:couponCover.imgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"btn_img_ticket"]];
            }else{
                //优惠商品封面
                [_preferentialGoods setBackgroundImageWithURL:[NSURL URLWithString:couponCover.imgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"btn_img_gift"]];
            }
        }
    }
    
    if(model.start) {
        //保存启动时长
        [QWUserDefault setDouble:[model.start.duration doubleValue] key:APP_LAUNCH_DURATION];
//        //保存外链地址
        [QWUserDefault setString:model.start.content key:APP_LAUNCH_URL];
        [QWUserDefault setString:model.start.title key:APP_LAUNCH_TITLE];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.start.imgUrl] options:SDWebImageDownloaderHighPriority progress:NULL completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            //保存启动引导页
            if(image)
                [QWUserDefault setObject:image key:APP_LAUNCH_IMAGE];
        }];
    }else{
        [QWUserDefault setString:@"" key:APP_LAUNCH_URL];
        //        //保存外链地址
        [QWUserDefault setString:model.start.content key:APP_LAUNCH_URL];
        [QWUserDefault setString:model.start.title key:APP_LAUNCH_TITLE];
    }
    if(model.refreshPattern)
    {
        [_refreshImageView setImageWithURL:[NSURL URLWithString:model.refreshPattern.imgUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image) {
                CGFloat height = APP_W / image.size.width * image.size.height;
                self.refreshImageHeight.constant = height;
            }
        }];
    }
}

- (void)updateMeters
{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd:HH:mm:ss";
    NSString *dateString = [format stringFromDate:date];
    
    NSArray *dateArray  = [dateString componentsSeparatedByString:@":"];
    
    
    
}

- (void)cancelCountDownTimer
{
    
    
}

- (void)startSnapUpCountDownTimer
{
    _countDownTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_countDownTimer, dispatch_time(DISPATCH_TIME_NOW, 1ull*NSEC_PER_SEC), 1ull*NSEC_PER_SEC , DISPATCH_TIME_FOREVER);
    __weak typeof (self) weakSelf = self;
    dispatch_source_set_event_handler(_countDownTimer, ^{
        [weakSelf cancelCountDownTimer];
    });
    dispatch_source_set_cancel_handler(_countDownTimer, ^{
        [weakSelf cancelCountDownTimer];
    });
    dispatch_resume(_countDownTimer);
}

- (void)endSnapUpCountDownTimer
{
     dispatch_source_cancel(_countDownTimer);
}


//通告是一个View,可点击故增加了TapGesture事件
- (void)bulletinTapGesture:(UITapGestureRecognizer *)gesture
{
    [QWGLOBALMANAGER statisticsEventId:@"e_index_tzl"];
    ConfigInfoModel *circular = _homePageEleVoModel.circular;
    if( [circular.type integerValue] == 1) {
        [self pushIntoWebViewController:circular.content title:circular.title];
    }else if([circular.type integerValue] == 2){
        //2.商家优惠活动
        CouponPharmacyDeailViewController *couponPharmacy = [[CouponPharmacyDeailViewController alloc]initWithNibName:@"CouponPharmacyDeailViewController" bundle:nil];
        couponPharmacy.storeId = circular.branchId;
        couponPharmacy.activityId = circular.content;
        couponPharmacy.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:couponPharmacy animated:YES];
    }
}

- (void)saveForumAreaCache:(NSArray *)array
{
    [ForumAreaInfoModel deleteAllObjFromDB];
    [ForumAreaInfoModel saveObjToDBWithArray:array];
}


- (void)loadForumAreaCache
{
    NSArray *list = [ForumAreaInfoModel getArrayFromDBWithWhere:nil];
    if(list.count > 0) {
        [self.ForumAreaList addObjectsFromArray:list];
        [self.tableView reloadData];
    }
}

//获取专区接口
- (void)queryForumArea
{
    BaseAPIModel *apiModelR = [BaseAPIModel new];
    [ConfigInfo configInfoQueryForumArea:apiModelR success:^(ForumAreaInfoListModel *listModel) {
        if([listModel.apiStatus integerValue] == 0) {
            [self saveForumAreaCache:listModel.list];
            [self.ForumAreaList removeAllObjects];
            [self.ForumAreaList addObjectsFromArray:listModel.list];
            [self.tableView reloadData];
        }
    } failure:NULL];
}

#pragma mark
#pragma mark 定位功能
//用户启动定位
- (void)startUserLocation
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {//断网,直接加载本地数据
        [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            if (mapInfoModel) {
                [self stLeftBarButtonWithModel:mapInfoModel];
            }
        }];
        return;
    }
    [QWGLOBALMANAGER statisticsEventId:@"e_index_dw"];
    checkInfoModel = nil;
    
    [QWUserDefault setBool:YES key:kCanConsultPharmacists];
    [QWGLOBALMANAGER resetLocationInformation:^(MapInfoModel *mapInfoModel) {
        if(mapInfoModel) {//定位成功
            NSLog(@"请不要删定位注释:");
            NSLog(@"定位成功 1");
            //如果没有省市区,代表是在国外,直接加载全部数据
            if (StrIsEmpty(mapInfoModel.province) && StrIsEmpty(mapInfoModel.city)) {//国外,加载苏州数据
                NSLog(@"定位到国外了,开始加载苏州数据 2");
                [QWUserDefault setBool:NO key:kLocationSuccess];
                [QWUserDefault setBool:YES key:kCanConsultPharmacists];
                CLLocationDegrees latitude = DEFAULT_LATITUDE;
                CLLocationDegrees longitude = DEFAULT_LONGITUDE;
                CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
                [QWGLOBALMANAGER mapReGeocodeSearchRequest:location block:^(MapInfoModel *mapInfoModel) {

                    [self stLeftBarButtonWithModel:mapInfoModel];
                }];
            }else{//如果有省市区,代表是在国内,判断该城市是否已经开通
                NSLog(@"定位到了国内城市:%@ 2",mapInfoModel.city);
                //读取历史缓存数据
                
                [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
                    NSLog(@"读取历史城市:%@ 3",mapInfoModel.city);
                    if (mapInfoModel) {//有历史缓存
                        _lastCityName = mapInfoModel.city;
                        
                    }else{//无历史缓存
                        
                    }
                }];
                //判断当前城市是否已经开通
                [QWGLOBALMANAGER checkCityOpenInfo:mapInfoModel openBlock:^(MapInfoModel *openMapInfo) {
                    //城市已开通
                    NSLog(@"当前定位城市%@已开通 4",openMapInfo.city);
                    globalMapInfo = openMapInfo;
                    [self stLeftBarButtonWithModel:mapInfoModel];
                    NSString *currentCity = openMapInfo.city;
                    //与上次定位城市不一致
                    if (currentCity && _lastCityName && ![currentCity isEqualToString:_lastCityName])
                    {
                        NSLog(@"两次定位城市不一致,询问是否从%@切换到%@？ 5",_lastCityName,currentCity);
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"定位显示当前您在%@,是否为您切换城市",currentCity] delegate:self cancelButtonTitle:nil otherButtonTitles:@"不用了",@"切换", nil];
                        alertView.tag = 2001;
                        [alertView show];
                    }else{//与上次定位城市一致或者上次定位失败
                        //存入QWUserDefault
                        [QWUserDefault setBool:YES key:kCanConsultPharmacists];
                        NSLog(@"两次定位城市一致,开始加载数据 5");
                        [self stLeftBarButtonWithModel:openMapInfo];

                        [QWGLOBALMANAGER saveLastLocationInfo:openMapInfo];
                    }
                    
                } closeBlock:^(MapInfoModel *closeMapInfo) {
                    //城市未开通
                    //首页地理位置显示定位城市
                    //弹框提示“参考提示语：12”
                    //存在缓存经纬度,则判断新城市是否与之前城市相同,若不相同,则加载本地已缓存数据
                    NSLog(@"定位显示您当前在%@城市暂未开通服务 4",closeMapInfo.city);
                    if (_lastCityName && closeMapInfo.city &&  ![_lastCityName isEqualToString:closeMapInfo.city]) {
                        globalMapInfo = (MapInfoModel *)mapInfoModel;
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"定位显示您当前在%@城市暂未开通服务，不为您切换城市喽",closeMapInfo.city] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        alertView.tag = 2002;
                        [alertView show];
                        
                    }else{//否则 弹窗提示当前城市未开通 ,隐藏优质药房功能
                        [QWUserDefault setBool:NO key:kCanConsultPharmacists];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您所在的城市%@暂未开通服务",closeMapInfo.city] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                        [self stLeftBarButtonWithModel:closeMapInfo];
                        [QWGLOBALMANAGER saveLastLocationInfo:closeMapInfo];
                        checkInfoModel = closeMapInfo;
                    }
                } failureBlock:^(HttpException *e) {
                    
                }];
            }
        }else{//定位失败
            NSLog(@"请不要删定位注释:定位失败 1");
            //读取历史缓存数据
            [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
                NSLog(@"读取历史城市 2 %@",mapInfoModel);
                if (mapInfoModel) {//有历史缓存经纬度,加载缓存的经纬度
                    globalMapInfo = mapInfoModel;
                    [self stLeftBarButtonWithModel:mapInfoModel];

                }else{//无历史缓存经纬度,显示苏州数据
                    [QWUserDefault setBool:YES key:kCanConsultPharmacists];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:kWarning40 delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    alertView.tag = 2000;
                    [alertView show];
                }
            }];
        }
        [self queryConfigInfo];
        [self queryForumArea];
        [QWGLOBALMANAGER loadHotWord];
    }];
}

#pragma mark
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2001) { //询问是否切换
        switch (buttonIndex) {
            case 1://切换
            {
                //存入QWUserDefault
                NSLog(@"开始切换 7");
                [QWUserDefault setBool:YES key:kCanConsultPharmacists];
                [self stLeftBarButtonWithModel:globalMapInfo];
                [QWGLOBALMANAGER saveLastLocationInfo:globalMapInfo];
                [self startUserLocation];
            }
                break;
            case 0://不用了
            {
                NSLog(@"不切换,加载本地数据 7");

            }
                break;
            default:
                break;
        }
        
    }else if (alertView.tag == 2000){//点击加载苏州  知道了
        
        //加载默认苏州位置数据
        CLLocationDegrees latitude = DEFAULT_LATITUDE;
        CLLocationDegrees longitude = DEFAULT_LONGITUDE;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [QWGLOBALMANAGER mapReGeocodeSearchRequest:location block:^(MapInfoModel *mapInfoModel) {
            [self stLeftBarButtonWithModel:mapInfoModel];
        }];
    }else if (alertView.tag == 2002){//当前城市未开通,且有历史缓存经纬度  则加载历史缓存经纬度数据

    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //立刻刷新小红点
    [QWGLOBALMANAGER updateRedPoint];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self loadConfigInfo];
    }
}

- (void)chooseCity:(id)sender
{
    
    CityListViewController *cityListViewController = [[CityListViewController alloc] init];
    __weak typeof (self) __weakSelf = self;
    cityListViewController.selectBlock = ^(OpenCityModel *model) {
        if(model) {
            QWGLOBALMANAGER.manualCity = model;
        }else{
            QWGLOBALMANAGER.manualCity = nil;
        }
        [__weakSelf startUserLocation];
    };
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityListViewController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adjustConstraint];
    bannerArray = [NSMutableArray array];
    _widthButtonConstraint.constant = APP_W / 2.0;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [btn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateNormal];
    btn.titleLabel.font = fontSystem(14.0);
    if([SHOW_CITY boolValue]) {
        [btn addTarget:self action:@selector(chooseCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImage *searchImage = [UIImage imageNamed:@"bg_img_search"];
    searchImage = [searchImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 100, 10, 10) resizingMode:UIImageResizingModeStretch];
    self.searchBackGroundImage.image = searchImage;
    
    //NavigationBarTitleView
    self.titleView.layer.masksToBounds = YES;
    self.titleView.layer.cornerRadius = 14.0f;
    self.ForumAreaList = [NSMutableArray array];
    
    //右上角未读数红点
    _badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(5, -6, 35, 35)];
    _badgeView.shadow = NO;
    _badgeView.userInteractionEnabled = NO;
    _badgeView.hideWhenZero = NO;
    _badgeView.tag = 888;
    _badgeView.hidden = NO;
    _badgeView.textColor=RGBHex(qwMcolor4);
    
    self.bulletinTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bulletinTapGesture:)];
    [_bulletinBoardContainer addGestureRecognizer:self.bulletinTapGesture];
    __weak typeof (self) __weakSelf = self;
    //下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [__weakSelf startUserLocation];
        [__weakSelf.tableView headerEndRefreshing];
    }];
    [self.tableView.header setBackgroundColor:[UIColor clearColor]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:RGBHex(qwGcolor11)];

    self.tableView.headerReleaseToRefreshText = @"松开立即刷新";
//    self.tableView.headerRefreshingText = @"正在刷新";

    self.bannerHeight.constant = (APP_W / 320.0) * self.bannerHeight.constant;
    self.containerViewHeight.constant += self.bannerHeight.constant - 85;
    self.centerContainerViewHeight.constant = (APP_W / 320.0) * self.centerContainerViewHeight.constant;
    _centerButtonWidth.constant = (APP_W / 320.) * _centerButtonWidth.constant;

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(20, 0, 25, 44);
    [rightButton addSubview:_badgeView];
    [rightButton setImage:[UIImage imageNamed:@"ic_btn_newsbox"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pushIntoMessageBox:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    
    [self setupTableView];
    
    [self performSelector:@selector(checkAppCommentStatus) withObject:nil afterDelay:10.0];
    
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self loadBannerCache];
        [self loadForumAreaCache];
    }
}

- (void)adjustConstraint
{
    self.separatorWidth.constant = self.separatorWidth1.constant = self.separatorWidth2.constant = self.separatorWidth3.constant = (APP_W - 4 * 39) / 5.0;
    
    

}


- (void)checkAppCommentStatus{
    //评论
    [QWGLOBALMANAGER checkAppComment];
}

- (void)postTestNotifi
{
    NotificationModel *modelNoti = [NotificationModel new];
    modelNoti.consultid = @"1430900812883";
    modelNoti.type = @"3";
    NSLog(@"sendd");
    [QWGLOBALMANAGER postNotif:NotiMessageBoxUpdateStatue data:modelNoti object:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.badgeView.hidden = YES;
    [self performSelector:@selector(stoped) withObject:nil afterDelay:0.5];
    [self.searchContainer removeFromSuperview];
}

- (void)stoped
{
    [self.cycleScrollView stopAutoScroll];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    CGRect frame = CGRectMake(0.0, 0.0, 320.0, 49.0);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    v.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.tabBar insertSubview:v atIndex:0];
    
    [self.cycleScrollView resumeTimer];
    if(self.badgeView.value > 0) {
        self.badgeView.hidden = NO;
    }else{
        self.badgeView.hidden = YES;
    }
    [self setupView];
    pushIndex = 0;
   
    [self.navigationController.navigationBar addSubview:self.searchContainer];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

//设置右上角城市City
- (void)stLeftBarButtonWithModel:(MapInfoModel *)model{
    
    [QWGLOBALMANAGER postNotif:NotifLocationPush data:model object:nil];
    NSString *title = model.city;
    if(title) {
        if([title hasSuffix:@"市"]) {
            title = [title substringToIndex:title.length - 1];
        }
        title = [NSString stringWithFormat:@"%@",title];
    }
    //if(title== nil || [title isEqualToString:@""]){
    if(StrIsEmpty(title)){
        [btn setTitle:@"" forState:UIControlStateNormal];
        UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixed.width = -50;
        UIBarButtonItem *cityButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        cityButton.width = 120;
        self.navigationItem.leftBarButtonItems = @[fixed,cityButton];
        return;
    }
    
//    if (title.length <= 2) {
    [btn setTitle:title forState:UIControlStateNormal];
//    }else if(title.length - 1 <= 3){
//        
//        [btn setTitle:[title substringToIndex:(title.length - 1)] forState:UIControlStateNormal];
//        
//    }else if((title.length - 1) > 3){
//        NSString *str;
//        if(title.length - 1 > 3){
//            str = [NSString stringWithFormat:@"%@...",[title substringToIndex:2]];
//        }else{
//            str = [title substringToIndex:(title.length - 1)];
//        }
//        
//        [btn setTitle:str forState:UIControlStateNormal];
//    }
    
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -25;
    UIBarButtonItem *cityButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    cityButton.width = 120;
    self.navigationItem.leftBarButtonItems = @[fixed,cityButton];
}

#pragma mark -
#pragma mark XLCycleScrollViewDelegate
//TODO: 解正鸿  通告也是同样的逻辑
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    if(bannerArray.count == 0){
        return;
    }
    [self.cycleScrollView stopAutoScroll];
    if(pushIndex == 0){
        BannerInfoModel *banner = bannerArray[index];
        [QWGLOBALMANAGER pushIntoDifferentBannerType:banner navigation:self.navigationController bannerLocation:@"首页"];
        pushIndex ++;
    }
}

- (NSInteger)numberOfPages
{
    if(bannerArray == nil || bannerArray.count == 0 || bannerArray.count == 1){
        self.cycleScrollView.scrollView.scrollEnabled = NO;
        [self.cycleScrollView stopAutoScroll];
        return 1;
    }else{
        self.cycleScrollView.scrollView.scrollEnabled = YES;
        [self.cycleScrollView startAutoScroll:5.0f];
        return bannerArray.count;
    }
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,APP_W, self.bannerHeight.constant)];
    if(bannerArray == nil || bannerArray.count == 0){
        [imageView setImage:[UIImage imageNamed:@"banner_no-picture.jpg"]];
        return imageView;
    }else{
        BannerInfoModel *banner = bannerArray[index];
        [imageView setImageWithURL:[NSURL URLWithString:banner.imgUrl] placeholderImage:[UIImage imageNamed:@"img_banner_nomal"]];
        return imageView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 处理本视图收到的通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotifLocationNeedReload == type) {
        NSLog(@"接到通知,开始定位 哈哈");
        [self startUserLocation];
    }else if (NotifLoginSuccess == type) {
       
    }else if(NotifNetworkDisconnectWhenStart == type) {
        [self startUserLocation];
    }else if (NotifKickOff == type){
        [self quickOut];
    }else if (NotifLocationPush == type) {
        MapInfoModel *model=(MapInfoModel*)data;
        [QWUserDefault setString:model.province key:APP_PROVIENCE_INDEX];
        [QWUserDefault setString:model.city key:APP_CITY_INDEX];
    }else if (NotifLocationRelocated == type){
        [self startUserLocation];
    }
    else if(NotiMessageBadgeNum == type)
    {
        [self.badgeView setValueOnly:[data integerValue]];
    }
    //if(QWGLOBALMANAGER.hotWord.homeHintMsg && ![QWGLOBALMANAGER.hotWord.homeHintMsg isEqualToString:@""])
    if(!StrIsEmpty(QWGLOBALMANAGER.hotWord.homeHintMsg))
        _searchTextLabel.text = QWGLOBALMANAGER.hotWord.homeHintMsg;
}

- (void)quickOut
{
    [SVProgressHUD showErrorWithStatus:@"登录状态失效，请重新登录" duration:0.8];
    [QWGLOBALMANAGER clearAccountInformation];
    [QWUserDefault setBool:NO key:APP_LOGIN_STATUS];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"apploginloginstatus"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"apppasswordkey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    QWGLOBALMANAGER.loginStatus = NO;
    [self performSelector:@selector(delayShowLoginViewController) withObject:nil afterDelay:0.3f];
}

- (void)delayShowLoginViewController
{
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.isPresentType = YES;
    [QWGLOBALMANAGER.tabBar presentViewController:navgationController animated:YES
                                       completion:NULL];
}



#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ForumAreaList.count;
}

//高度根据屏幕等比例调整
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumAreaInfoModel *model = self.ForumAreaList[indexPath.section];
    if([model.type integerValue] == 1) {
        return 133 * APP_W / 320.0;
    }else if ([model.type integerValue] == 2) {
        return 133 * APP_W / 320.0;
    }else{
        return 64 * APP_W / 320.0;
    }
}

//cell 分为三种类型 1-1 1-2  3,具体效果参考UI图,每个Cell上有1-4个Button ,点击不同Button需要对应到不同数据源的Model,然后进行H5界面
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[indexPath.section];
    if([areaModel.type integerValue] == 1) {//1-2
        ProjectTemplateOneTableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:ProjectTemplateOneIdentifier];
        [cell setCell:areaModel];
        [cell.button1 addTarget:self action:@selector(firstSectionButton1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button1 setTag:indexPath.section];
        
        [cell.button2 addTarget:self action:@selector(firstSectionButton2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 setTag:indexPath.section];
        
        [cell.button3 addTarget:self action:@selector(firstSectionButton3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 setTag:indexPath.section];
        
        return cell;
        
    }else if ([areaModel.type integerValue] == 2) {//2-2
        ProjectTemplateSecondTableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:ProjectTemplateSecondIdentifier];
        [cell setCell:areaModel];
        [cell.button1 addTarget:self action:@selector(secondSectionButton1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button2 addTarget:self action:@selector(secondSectionButton2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button3 addTarget:self action:@selector(secondSectionButton3:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button4 addTarget:self action:@selector(secondSectionButton4:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.button1 setTag:indexPath.section];
        [cell.button2 setTag:indexPath.section];
        [cell.button3 setTag:indexPath.section];
        [cell.button4 setTag:indexPath.section];

        return cell;
    }else{
        ProjectTemplateTableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:ProjectSimpeContentIdentifier];
        [cell setCell:areaModel];
        return cell;
    }
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    ForumAreaInfoModel *areaModel = self.ForumAreaList[indexPath.section];
    [self pushIntoWebViewControllerWithURL:areaModel.posFirst_ContentUrl cls:areaModel.posFirst_Cls isSpecial:areaModel.posFirst_IsSpecial title:areaModel.posFirst_Title];
}

//cell 1-1的Button点击事件
- (void)firstSectionButton1:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posFirst_ContentUrl cls:areaModel.posFirst_Cls isSpecial:areaModel.posFirst_IsSpecial title:areaModel.posFirst_Title];
}

- (void)firstSectionButton2:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posTwo_ContentUrl cls:areaModel.posTwo_Cls isSpecial:areaModel.posTwo_IsSpecial title:areaModel.posTwo_Title];
}

- (void)firstSectionButton3:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posThree_ContentUrl cls:areaModel.posThree_Cls isSpecial:areaModel.posThree_IsSpecial title:areaModel.posThree_Title];
}

//cell 2-1的Button点击事件
- (void)secondSectionButton1:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posFirst_ContentUrl cls:areaModel.posFirst_Cls isSpecial:areaModel.posFirst_IsSpecial title:areaModel.posFirst_Title];
}

- (void)secondSectionButton2:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posTwo_ContentUrl cls:areaModel.posTwo_Cls isSpecial:areaModel.posTwo_IsSpecial title:areaModel.posTwo_Title];
}

//cell 3的Button点击事件
- (void)secondSectionButton3:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posThree_ContentUrl cls:areaModel.posThree_Cls isSpecial:areaModel.posThree_IsSpecial title:areaModel.posThree_Title];
}

- (void)secondSectionButton4:(UIButton *)sender
{
    ForumAreaInfoModel *areaModel = self.ForumAreaList[sender.tag];
    [self pushIntoWebViewControllerWithURL:areaModel.posFour_ContentUrl cls:areaModel.posFour_Cls isSpecial:areaModel.posFour_IsSpecial title:areaModel.posFour_Title];
}

#pragma mark
#pragma mark H5界面各种跳转
- (void)pushIntoWebViewControllerWithURL:(NSString *)url cls:(NSString *)cls isSpecial:(NSString *)isSpecial title:(NSString *)strTitle
{
    NSString *strEventID = [NSString stringWithFormat:@"e_index_zt_%@",cls];
    [QWGLOBALMANAGER statisticsEventId:strEventID];
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.title = strTitle;
    if ([url hasPrefix:@"http"]) {
        modelLocal.url = url;
    } else {
        modelLocal.url = @"";
        modelLocal.strParams = url;
    }
    if ([isSpecial isEqualToString:@"Y"]) {
        vcWebDirect.isSpecial = YES;
    }
    if (([cls intValue] == 1) || ([cls intValue] == 2)) {       // 1 慢病  2 专题列表
        if ([cls intValue] == 1) {
            // 慢病专区
            StatisticsModel *model = [StatisticsModel new];
            model.eventId = @"e_mb_click";
            [QWCLICKEVENT qwTrackEventModel:model];
            modelLocal.typeLocalWeb = WebLocalTypeSlowDiseaseArea;
        } else if ([cls intValue] == 2) {
            // 专题列表
            StatisticsModel *model = [StatisticsModel new];
            model.eventId = @"e_index_zt";
            model.params = @{@"专题类型":@"专题列表",
                             @"专题标题":strTitle};
            [QWCLICKEVENT qwTrackEventModel:model];
            modelLocal.typeLocalWeb = WebLocalTypeTopicList;
            [QWGLOBALMANAGER statisticsEventId:@"e_subject_zt_lb"];
        }
        [vcWebDirect setWVWithLocalModel:modelLocal];
    } else {
        if ([cls intValue] == 3) {
            //专区
            StatisticsModel *model = [StatisticsModel new];
            model.eventId = @"e_index_zq";
            model.params = @{@"专区名":strTitle};
            [QWCLICKEVENT qwTrackEventModel:model];
            modelLocal.typeLocalWeb = WebLocalTypeDivision;
            [vcWebDirect setWVWithLocalModel:modelLocal];
            [QWGLOBALMANAGER statisticsEventId:@"e_subject_tk_lb"];
        } else if ([cls intValue] == 4) {
            // 某个专题详情
            StatisticsModel *model = [StatisticsModel new];
            model.eventId = @"e_index_zt";
            model.params = @{@"专题类型":@"专题",
                             @"专题标题":strTitle};
            [QWCLICKEVENT qwTrackEventModel:model];
            modelLocal.typeLocalWeb = WebLocalTypeTopicDetail;
            [vcWebDirect setWVWithLocalModel:modelLocal];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    vcWebDirect.vcHolder = weakSelf;
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

- (void)pushIntoWebViewController:(NSString *)url title:(NSString *)title
{
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    NSString *strUrl = @"";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    if (![url hasPrefix:@"http"]) {
        url = [NSString stringWithFormat:@"%@%@",H5_BASE_URL,url];
    }
    strUrl = [NSString stringWithFormat:@"%@",url];
    modelLocal.url = strUrl;
    modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
    modelLocal.title = @"";
    vcWebDirect.isOtherLinks = YES;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    
    vcWebDirect.vcHolder = self;
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
}

//跳转到搜索界面
- (IBAction)pushToSearchView:(id)sender
{
    StatisticsModel *model = [StatisticsModel new];
    model.eventId = @"e_index_djss";
    [QWCLICKEVENT qwTrackEventModel:model];
    
    SearchViewController * searchViewController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    searchViewController.hidesBottomBarWhenPushed = YES;
    searchViewController.isHideBranchList = NO;
    [self.navigationController pushViewController:searchViewController animated:YES];
}

//跳转动扫码界面
- (IBAction)pushToScanRedaerView:(id)sender {
    if (![QYPhotoAlbum checkCameraAuthorizationStatus]) {
        [self showError:kWarning42];
        return;
    }
    ScanReaderViewController *scanReaderViewController = [[ScanReaderViewController alloc] initWithNibName:@"ScanReaderViewController" bundle:nil];
    scanReaderViewController.useType = Enum_Scan_Items_Normal;
    scanReaderViewController.delegatePopVC = self;
    scanReaderViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanReaderViewController animated:NO];
}

//跳转领券中心界面
- (IBAction)pushIntoCouponTicket:(id)sender
{
    [QWGLOBALMANAGER statisticsEventId:@"e_index_yhq"];
    CouponCenterViewController *couponCenterViewController = [[CouponCenterViewController alloc] initWithNibName:@"CouponCenterViewController" bundle:nil];
    couponCenterViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:couponCenterViewController animated:YES];
}

//跳转优惠商品界面
- (IBAction)pushIntoCouponProduct:(id)sender
{
    CouponPromotionHomePageViewController *couponProduct = [[CouponPromotionHomePageViewController alloc]init];
    couponProduct.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:couponProduct animated:YES];
}

@end
