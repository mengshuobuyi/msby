//
//  ConsultMedicineListViewController.m
//  wenyao
//
//  Created by chenzhipeng on 15/1/19.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "ConsultMedicineListViewController.h"
#import "StoreModelR.h"
#import "FavoriteModelR.h"
#import "StoreModel.h"
#import "FavoriteModel.h"
#import "Store.h"
#import "Favorite.h"
#import "FavoriteModel.h"
#import <MapKit/MapKit.h>
#import "ConsultMedicineCell.h"
#import "MessageBoxViewController.h"

#import "XHMessageBubbleFactory.h"
#import "XHMessage.h"
#import "XMPPStream.h"
//#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "XMPPIQ+XMPPMessage.h"
//#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "ConsultMedicineMyFavCell.h"
#import "QWMessage.h"
#define K_NODATA_MYFAV @"您还未关注任何药房哦!"
#define k_NONETWORK_MYFAV @"网络未连接，请重试"

typedef enum
{
    Enum_DataNormal = 0x00000001,               //数据正常
    Enum_needRelocation = 0x00000001 << 1,      //需要重新定位
    Enum_noData = 0x00000001 << 2,              //没有数据
    Enum_cityNotOpen = 0x00000001 << 3          //城市未开通
}EnumDataStatus;

@interface ConsultMedicineListViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewRelocation;
@property (weak, nonatomic) IBOutlet UIButton *btnRelocation;
//@property (nonatomic, strong) CLLocationManager *locationManager;
//@property (nonatomic, strong) ConsultViewModel *viewModelConsult;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (strong, nonatomic) NSMutableSet *setSelected;
@property (strong, nonatomic) NSMutableSet *setMyFavSelected;
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) CLLocation *lastUserLocation;
@property (strong, nonatomic) MapInfoModel *lastUserMapInfo;
@property (nonatomic, strong) NSString          *lastCityName;
@property (nonatomic, strong) NSString *lastProvinceName;
@property (weak, nonatomic) IBOutlet UILabel *lblNoData;
@property (nonatomic, strong) NSString          *currentCityName;
@property (nonatomic, strong) NSString *currentProvinceName;
//@property (nonatomic, strong) AMapReGeocode     *aMapReGeocode;
@property (nonatomic, strong) MBProgressHUD *progressWait;
@property (weak, nonatomic) IBOutlet UILabel *lblCityNotOpen;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseMyFav;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseAround;
@property (weak, nonatomic) IBOutlet UIImageView *imgAround;
@property (weak, nonatomic) IBOutlet UIImageView *imgMyFav;
@property (weak, nonatomic) IBOutlet UIView *viewNearPharmacy;
@property (weak, nonatomic) IBOutlet UIView *viewFavPharmacy;
@property (weak, nonatomic) IBOutlet UITableView *tbViewMyFav;
@property (weak, nonatomic) IBOutlet UILabel *lblMyFavNoNetWork;

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) MapInfoModel *modelMap;
@property (nonatomic, strong) StoreNearByListModel *modelListNearBy;
//@property (nonatomic, strong) MyFavListModel *modelListMyFav;
@property (nonatomic, strong) NSMutableArray *arrMyFavList;

- (IBAction)btnPressed_choosePharmacySource:(id)sender;

- (IBAction)btnPressed_updateLocation:(id)sender;
- (IBAction)btnPressed_submit:(id)sender;
@end

@implementation ConsultMedicineListViewController

/**
 *  根据不同情况控制界面隐藏
 *
 *  @param enumDataType 枚举: Enum_DataNormal 数据正常
                            Enum_needRelocation 需要显示重新定位.
                            Enum_noData  没有数据
                            Enum_cityNotOpen 当前城市未开通
 
 */

- (void)appealLocationAndDataStatus:(EnumDataStatus)enumDataType
{
    if (enumDataType == Enum_DataNormal) {
        self.tbViewContent.hidden = NO;
        self.viewRelocation.hidden = YES;
        self.lblCityNotOpen.hidden = YES;
        self.lblNoData.hidden = YES;
    } else if (enumDataType == Enum_needRelocation) {
        self.tbViewContent.hidden = YES;
        self.viewRelocation.hidden = NO;
        self.lblCityNotOpen.hidden = YES;
        self.lblNoData.hidden = YES;
    } else if (enumDataType == Enum_noData) {
        self.tbViewContent.hidden = YES;
        self.viewRelocation.hidden = YES;
        self.lblCityNotOpen.hidden = YES;
        self.lblNoData.hidden = NO;
    } else if (enumDataType == Enum_cityNotOpen) {
        self.tbViewContent.hidden = YES;
        self.viewRelocation.hidden = YES;
        self.lblCityNotOpen.hidden = NO;
        self.lblNoData.hidden = YES;
    }
}

- (void)setNaviBar
{
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblTitle.text = kWarning18;
    lblTitle.font = fontSystem(kFontSize18);//[UIFont systemFontOfSize:18];
    lblTitle.textColor = RGBHex(kColor2);
//    self.navigationItem.titleView = lblTitle;
    [self naviTitleView:lblTitle];
    
//    UIButton *btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnNext.frame = CGRectMake(0, 0, 30, 30);
//    btnNext.titleLabel.font = [UIFont systemFontOfSize:15];
//    btnNext.titleLabel.textAlignment = NSTextAlignmentRight;
//    [btnNext setTitleColor:RGBHex(kColor2) forState:UIControlStateNormal];
//    [btnNext setTitle:@"提交" forState:UIControlStateNormal];
//    [btnNext addTarget:self action:@selector(btnPressed_submit:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *nextBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnNext];
//    self.navigationItem.rightBarButtonItem = nextBtnItem;
}

- (void)UIGlobal{
    [super UIGlobal];
    [self naviRightBotton:@"提交" action:@selector(btnPressed_submit:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBar];

    self.setSelected = [NSMutableSet set];
    self.setMyFavSelected = [NSMutableSet set];
    [self appealLocationAndDataStatus:Enum_DataNormal];
    self.curPage = 1;
    self.pageSize = 10;
    self.modelMap = nil;
    self.arrMyFavList = [@[] mutableCopy];
    __weak ConsultMedicineListViewController *weakSelf = self;
    if (QWGLOBALMANAGER.currentNetWork != NotReachable) {
        [self.tbViewMyFav addFooterWithCallback:^{
            weakSelf.curPage++;
            [weakSelf requestMyFavStore];
        }];
    }
    [QWGLOBALMANAGER readLocationWhetherReLocation:YES block:^(MapInfoModel *mapInfoModel) {
        if (mapInfoModel) {
            weakSelf.modelMap = mapInfoModel;
            [weakSelf requestForNearPharmacyList:mapInfoModel.location withCity:mapInfoModel.city withProvince:mapInfoModel.province];
        } else {
            [weakSelf appealLocationAndDataStatus:Enum_noData];
            [weakSelf requireRelocation];
        }
    }];
    //TODO: 测试重新定位
//    [self requireRelocation];
    [self btnPressed_choosePharmacySource:self.btnChooseAround];
    [self appealLocationAndDataStatus:Enum_noData];
    self.tbViewContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.btnRelocation.layer.cornerRadius = 4.0f;
    self.btnRelocation.layer.borderWidth = 1.0f;
    self.btnRelocation.layer.masksToBounds = YES;
    self.btnRelocation.layer.borderColor = [RGBHex(kColor3) CGColor];//[RGBHex(kColor3) CGColor];
    self.view.backgroundColor = RGBHex(kColor7);//RGBHex(kColor7);
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startUserLocation) name:NEED_RELOCATION object:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self requestForNearPharmacyList:self.userLocation withCity:self.currentCityName withProvince:self.currentProvinceName];
        [QWGLOBALMANAGER saveLastLocationInfo:self.lastUserMapInfo];
    }else{
        //        [self loadLocalPharmacyList];
        // 不切换城市
        [self requestForNearPharmacyList:self.lastUserLocation withCity:self.lastCityName withProvince:self.lastProvinceName];
        self.userLocation = self.lastUserLocation;
    }
}

- (void)requireRelocation
{
    __block NSString *strCity = @"";
    __block NSString *strProvince = @"";
//    __weak ConsultMedicineListViewController *weakSelf = self;
    [QWGLOBALMANAGER readLocationWhetherReLocation:YES block:^(MapInfoModel *mapInfoModel) {
        if (mapInfoModel) {
            strCity = mapInfoModel.city;
            strProvince = mapInfoModel.province;
            //            __block MapInfoModel *lastMapInfo = mapInfoModel;
            [QWGLOBALMANAGER resetLocationInformation:^(MapInfoModel *mapInfoModel) {
                if(mapInfoModel) {
                    //成功
                    __weak MapInfoModel *weakMapInfo = mapInfoModel;
                    [QWGLOBALMANAGER checkCityOpenInfo:mapInfoModel openBlock:^(MapInfoModel *openMapInfo) {
                        //城市已开通
                        //                        self.userLocation = openMapInfo.location;
                        NSString *currentCity = openMapInfo.city;
                        
                        if (currentCity && strCity && ![currentCity isEqualToString:strCity])
                        {
                            self.lastUserLocation = openMapInfo.location;
                            self.lastCityName = openMapInfo.city;
                            self.lastProvinceName = openMapInfo.province;
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"定位显示当前您在%@,是否为您切换城市",currentCity] delegate:self cancelButtonTitle:nil otherButtonTitles:@"不用了",@"切换", nil];
                            [alertView show];
                        }else{
                            [self requestForNearPharmacyList:weakMapInfo.location withCity:weakMapInfo.city withProvince:weakMapInfo.province];
                            
                            [QWGLOBALMANAGER saveLastLocationInfo:mapInfoModel];
                        }
                        
                    } closeBlock:^(MapInfoModel *closeMapInfo) {
                        
                    }];
                }
            }];
        } else {
            [self appealLocationAndDataStatus:Enum_needRelocation];
        }
    }];
}

- (void)requestMyFavStore
{
    if (QWGLOBALMANAGER.loginStatus == NO) {
        return;
    }
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        self.lblMyFavNoNetWork.text = k_NONETWORK_MYFAV;
        return;
    }
    if (self.curPage == 1) {
        [self.arrMyFavList removeAllObjects];
    }
    FavoriteModelR *modelR = [[FavoriteModelR alloc] init];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.currPage = [NSString stringWithFormat:@"%ld",(long)self.curPage];
    modelR.pageSize = [NSString stringWithFormat:@"%ld",(long)self.pageSize];
    [Favorite queryStoreCollectListWithParams:modelR
                                      success:^(id resultObj){
                                          MyFavListModel *modelFavList = (MyFavListModel *)resultObj;
                                          [self.arrMyFavList addObjectsFromArray:modelFavList.list];
                                          if (self.arrMyFavList.count > 0) {
                                              
                                              
                                              self.tbViewMyFav.hidden = NO;
                                              self.lblMyFavNoNetWork.hidden = YES;
                                              [self.tbViewMyFav reloadData];
                                          } else {
                                              self.tbViewMyFav.hidden = YES;
                                              self.lblMyFavNoNetWork.text = K_NODATA_MYFAV;
                                              self.lblMyFavNoNetWork.hidden = NO;
                                          }
                                          [self.tbViewMyFav footerEndRefreshing];
                                      }
                                      failure:^(HttpException *e){
                                          self.tbViewMyFav.hidden = YES;
                                          self.lblMyFavNoNetWork.text = k_NONETWORK_MYFAV;
                                          self.lblMyFavNoNetWork.hidden = NO;
                                          [self.tbViewMyFav footerEndRefreshing];
                                      }];

}

- (void)requestForNearPharmacyList:(CLLocation *)location withCity:(NSString *)strCity withProvince:(NSString *)strProvince
{
    StoreOfferNameModelR *modelR = [[StoreOfferNameModelR alloc] init];
    modelR.latitude = [NSString stringWithFormat:@"%.6f",location.coordinate.latitude];
    modelR.longitude = [NSString stringWithFormat:@"%.6f",location.coordinate.longitude];
    modelR.city = strCity;
    modelR.province = strProvince;
    modelR.size = @"5";
    modelR.type = @"0";
    [Store getPharmacyNearbyWithPara:modelR success:^(id result) {
        StoreNearByListModel *model = result;
        if (model.list.count > 0) {
            self.modelListNearBy = model;
            [self appealLocationAndDataStatus:Enum_DataNormal];
            if (model.list.count >= 2) {
                [self.setSelected addObject:@0];
                [self.setSelected addObject:@1];
            } else if (model.list.count >= 1) {
                [self.setSelected addObject:@0];
            }
            [self.tbViewContent reloadData];
        } else {
            [self appealLocationAndDataStatus:Enum_noData];
        }
    } failure:^(HttpException *err) {
        NSLog(@"err is %@", err);
        [self appealLocationAndDataStatus:Enum_noData];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self getCurrentLocation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)loadLocalPharmacyList
{
//    [self.viewModelConsult getCachedNearPharmacyList];
//    if (self.viewModelConsult.arrNearPharmacyList.count <= 0) {
//        [self appealLocationAndDataStatus:Enum_noData];
//    } else {
//        [self appealLocationAndDataStatus:Enum_DataNormal];
//        [self.setSelected addObject:@0];
//        [self.setSelected addObject:@1];
//        [self.tbViewContent reloadData];
//    }
    
}
#pragma mark - Location methods

- (void)startUserLocation
{
}

#pragma mark - UITableView methods
- (BOOL)containSelectInSet:(NSInteger)indexObj isMyFav:(BOOL)isMyFav
{
    if (isMyFav) {
        BOOL isExisted = NO;
        if ([self.setMyFavSelected containsObject:[NSNumber numberWithInt:indexObj]]) {
            isExisted = YES;
        }
        return isExisted;
    } else {
        BOOL isExisted = NO;
        if ([self.setSelected containsObject:[NSNumber numberWithInt:indexObj]]) {
            isExisted = YES;
        }
        return isExisted;
    }
}

- (void)operateSelectInSet:(NSInteger)indexObj isMyFav:(BOOL)isMyFav
{
    if (isMyFav) {
        if (![self containSelectInSet:indexObj isMyFav:YES]) {
            [self.setMyFavSelected addObject:[NSNumber numberWithInt:indexObj]];
        } else {
            [self.setMyFavSelected removeObject:[NSNumber numberWithInt:indexObj]];
        }
    } else {
        if (![self containSelectInSet:indexObj isMyFav:NO]) {
            [self.setSelected addObject:[NSNumber numberWithInt:indexObj]];
        } else {
            [self.setSelected removeObject:[NSNumber numberWithInt:indexObj]];
        }
    }
}

- (NSString *)checkStr:(id)obj
{
    if (([obj isKindOfClass:[NSString class]])&&[(NSString *)obj length]>0) {
        return (NSString *)obj;
    } else {
        return @"";
    }
}

- (void)configureCell:(ConsultMedicineCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    StoreNearByModel *model = [self.modelListNearBy.list objectAtIndex:indexPath.row];
    cell.lblTitle.text = [self checkStr:model.shortName].length > 0 ? [self checkStr:model.shortName] : [self checkStr:model.name];
    cell.lblDistance.text = [NSString stringWithFormat:@"%@ KM",model.distance];
}

- (void)configureMyFavCell:(ConsultMedicineMyFavCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    MyFavStoreModel *model = self.arrMyFavList[indexPath.row];
    cell.lblTitle.text = [self checkStr:model.shortName].length > 0 ? [self checkStr:model.shortName] : [self checkStr:model.name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tbViewContent) {
        ConsultMedicineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultMedicineCell"];
        StoreNearByModel *model = [self.modelListNearBy.list objectAtIndex:indexPath.row];
        [cell setCell:model];
        if ([self containSelectInSet:indexPath.row isMyFav:NO]) {
            cell.imgSelect.hidden = NO;
            cell.lblTitle.textColor = RGBHex(kColor3);//UICOLOR(69, 192, 26);
            cell.contentView.backgroundColor = [UIColor clearColor];
        } else {
            cell.imgSelect.hidden = YES;
            cell.lblTitle.textColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    } else {
        ConsultMedicineMyFavCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsultMedicineMyFavCell"];
        MyFavStoreModel *model = self.arrMyFavList[indexPath.row];
        [cell setCell:model];
        if ([self containSelectInSet:indexPath.row isMyFav:YES]) {
            cell.imgSelect.hidden = NO;
            cell.lblTitle.textColor = RGBHex(kColor3);
            cell.contentView.backgroundColor = [UIColor clearColor];
        } else {
            cell.imgSelect.hidden = YES;
            cell.lblTitle.textColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tbViewContent) {
        static ConsultMedicineCell *sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [tableView dequeueReusableCellWithIdentifier:@"ConsultMedicineCell"];
        });
        StoreNearByModel *model = [self.modelListNearBy.list objectAtIndex:indexPath.row];
        [sizingCell setCell:model];
        sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
        [sizingCell setNeedsLayout];
        [sizingCell layoutIfNeeded];
        CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return sizeFinal.height+1.0f;
    } else {
        static ConsultMedicineMyFavCell *sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sizingCell = [tableView dequeueReusableCellWithIdentifier:@"ConsultMedicineMyFavCell"];
        });
        MyFavStoreModel *model = self.arrMyFavList[indexPath.row];
        [sizingCell setCell:model];
        sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
        [sizingCell setNeedsLayout];
        [sizingCell layoutIfNeeded];
        CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return sizeFinal.height+1.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tbViewMyFav) {
        return self.arrMyFavList.count;
    }
    return self.modelListNearBy.list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tbViewContent) {
        [self operateSelectInSet:indexPath.row isMyFav:NO];
        ConsultMedicineCell *selectCell = (ConsultMedicineCell *)[tableView cellForRowAtIndexPath:indexPath];
        if ([self containSelectInSet:indexPath.row isMyFav:NO]) {
            selectCell.imgSelect.hidden = NO;
            selectCell.lblTitle.textColor = RGBHex(kColor3);
            selectCell.contentView.backgroundColor = [UIColor clearColor];
        } else {
            selectCell.imgSelect.hidden = YES;
            selectCell.lblTitle.textColor = [UIColor blackColor];
            selectCell.contentView.backgroundColor = [UIColor whiteColor];
        }
    } else {
        [self operateSelectInSet:indexPath.row isMyFav:YES];
        ConsultMedicineMyFavCell *selectCell = (ConsultMedicineMyFavCell *)[tableView cellForRowAtIndexPath:indexPath];
        if ([self containSelectInSet:indexPath.row isMyFav:YES]) {
            selectCell.imgSelect.hidden = NO;
            selectCell.lblTitle.textColor = RGBHex(kColor3);
            selectCell.contentView.backgroundColor = [UIColor clearColor];
        } else {
            selectCell.imgSelect.hidden = YES;
            selectCell.lblTitle.textColor = [UIColor blackColor];
            selectCell.contentView.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)checkLogin
{
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)btnPressed_choosePharmacySource:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn == self.btnChooseMyFav) {
        if (self.btnChooseMyFav.selected == YES) {
            return;
        } else {
            if (![self checkLogin]) {
                return;
            }
            self.btnChooseMyFav.selected = YES;
            self.btnChooseAround.selected = NO;
            self.imgMyFav.highlighted = YES;
            self.imgAround.highlighted = NO;
            self.viewFavPharmacy.hidden = NO;
            self.viewNearPharmacy.hidden = YES;
            if (self.arrMyFavList.count > 0) {
                return;
            }
            self.lblMyFavNoNetWork.text = K_NODATA_MYFAV;
            [self requestMyFavStore];
        }
    } else {
        if (self.btnChooseAround.selected == YES) {
            return;
        } else {
            self.btnChooseAround.selected = YES;
            self.btnChooseMyFav.selected = NO;
            self.imgMyFav.highlighted = NO;
            self.imgAround.highlighted = YES;
            self.viewFavPharmacy.hidden = YES;
            self.viewNearPharmacy.hidden = NO;
        }
    }
}

- (IBAction)btnPressed_updateLocation:(id)sender {
    self.progressWait = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressWait.mode = MBProgressHUDModeIndeterminate;
    self.progressWait.labelText = @"正在重新定位";
    [self startUserLocation];
}

- (void)showAlertWithMsg:(NSString *)strMsg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:strMsg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)btnPressed_submit:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        return;
    }
    if (![self checkLogin]) {
        return;
    }
    __block NSMutableArray *selectedArr = [@[] mutableCopy];
    __block NSMutableArray *selectedFavArr = [@[] mutableCopy];
    for (NSNumber *num in self.setSelected) {
        StoreNearByModel *model = self.modelListNearBy.list[[num integerValue]];
        [selectedArr addObject:model];
    }
    if (self.arrMyFavList.count > 0) {
        
        [self.setMyFavSelected enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            NSNumber *num = obj;
            MyFavStoreModel *modelFav = self.arrMyFavList[[num integerValue]];
            BOOL exist = NO;
            for (int i = 0; i < selectedArr.count; i++) {
                StoreNearByModel *modelExist = selectedArr[i];
                if ([modelFav.accountId isEqualToString:modelExist.accountId]) {
                    exist = YES;
                }
            }
            if (exist == NO) {
                [selectedFavArr addObject:modelFav];
            } else {
            }
        }];
    }
    if (selectedArr.count + selectedFavArr.count <= 0) {
        [self showError:kWarning27];
        return;
    }
    if (selectedArr.count + selectedFavArr.count > 5) {
        [self showError:kWarning28];
        return;
    }
    [self.setSelected removeAllObjects];
    [self.setMyFavSelected removeAllObjects];
    __block NSDate *date = [NSDate date];
    NSLog(@"comment content is %@, selected arr is %@",self.dicConsult,selectedArr);
    NSMutableArray *arrAccountID = [@[] mutableCopy];
    for (StoreNearByModel *model in selectedArr) {
        [arrAccountID addObject:model.accountId];
    }
    for (MyFavStoreModel *modelFav in selectedFavArr) {
        [arrAccountID addObject:modelFav.accountId];
    }
    [arrAccountID enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *accountID = (NSString *)obj;
        NSString *UUID = [XMPPStream generateUUID];
        
        QWMessage * msg = [[QWMessage alloc] init];
        msg.direction = [NSString stringWithFormat:@"%.0ld",(long)XHBubbleMessageTypeSending];
        msg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
        msg.UUID = UUID;
        msg.star = @"0";
        msg.avatorUrl = @"";
        msg.sendname = QWGLOBALMANAGER.configure.passPort;
        msg.recvname = accountID;
        msg.issend = [NSString stringWithFormat:@"%d",SendFailure];
        msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeText];
        msg.isRead = @"0";
        msg.richbody = @"";
        msg.body = self.dicConsult[@"consult_content"];
        [QWMessage saveObjToDB:msg];
        
        HistoryMessages *historymsg = [[HistoryMessages alloc] init];
        historymsg.relatedid = msg.recvname;
        historymsg.timestamp = msg.timestamp;
        historymsg.body = msg.body;
        historymsg.direction = msg.direction;
        historymsg.messagetype = msg.messagetype;
        historymsg.UUID = msg.UUID;
        historymsg.issend = msg.issend;
        historymsg.avatarurl = @"";
        //保存到历史列表
        [HistoryMessages updateObjToDB:historymsg WithKey:historymsg.relatedid];

        double timeDouble = [date timeIntervalSince1970] * 1000;
        if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
        {
            [self showError:kWarning12];
            return;
        }
    }];

    MessageBoxViewController *messageBoxViewController = [[MessageBoxViewController alloc] initWithNibName:@"MessageBoxViewController" bundle:nil];
    [self.navigationController pushViewController:messageBoxViewController animated:YES];
    
    
}

@end
