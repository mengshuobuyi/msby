//
//  NearBranchListViewController.m
//  APP
//  切换药房-附近药房
//  Created by 李坚 on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NearBranchListViewController.h"
#import "ChooseBranchTableViewCell.h"
#import "ConsultStore.h"
#import "QWLocation.h"
#import "SVProgressHUD.h"

static NSString *const ChooseBranchCellIdentifier = @"ChooseBranchTableViewCell";

#define UnopenCityInfo @"您当前所在城市暂未开通服务"
#define NoBranchList   @"暂无测试数据"


@interface NearBranchListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIView *infoView;
}


@property (nonatomic, strong) UIButton *relocationBtn;

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation NearBranchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray new];

    [self setupLocationUI];
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 31.5f, APP_W, APP_H - NAV_H - 66.0f)];
    [_mainTableView registerNib:[UINib nibWithNibName:ChooseBranchCellIdentifier bundle:nil] forCellReuseIdentifier:ChooseBranchCellIdentifier];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
 
    [self loadBranchsDataNeedRelocation:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)setupLocationUI{
    
    self.view.backgroundColor = RGBHex(qwColor4);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 33, 31)];
    label.font = fontSystem(kFontS6);
    label.textColor = RGBHex(qwColor7);
    label.text = @"当前：";
    [self.view addSubview:label];
    
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(53, 0, APP_W - 95, 31)];
    _addressLabel.font = fontSystem(kFontS6);
    _addressLabel.textColor = RGBHex(qwColor7);
    _addressLabel.text = @"重新定位当前位置";
    [self.view addSubview:_addressLabel];
    
    UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(APP_W - 25.5, 8.0f, 15, 15)];
    locationImage.image = [UIImage imageNamed:@"icon_refresh"];
    locationImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:locationImage];
    
    _relocationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, APP_W, 31)];
    [_relocationBtn addTarget:self action:@selector(relocationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_relocationBtn];
    
    
    UIView *sepLine = [[UIView alloc]initWithFrame:CGRectMake(0, 31.0f, APP_W, 0.5f)];
    sepLine.backgroundColor = RGBHex(qwColor10);
    [self.view addSubview:sepLine];
}

#pragma mark - 重新定位事件
- (void)relocationAction:(id)sender{
    
    [QWGLOBALMANAGER statisticsEventId:@"切换药房_附近药房_重新定位" withLable:nil withParams:nil];

    [self loadBranchsDataNeedRelocation:YES];
}


- (void)loadBranchsDataNeedRelocation:(BOOL)flag{
    if(flag) {
        [QWGLOBALMANAGER resetLocationInformation:^(MapInfoModel *mapInfoModel) {
            if(mapInfoModel.locationStatus == LocationSuccess){
                [SVProgressHUD showSuccessWithStatus:@"定位成功"];
                _addressLabel.text = mapInfoModel.formattedAddress;
                [QWGLOBALMANAGER updateMapInfoModelLocation:mapInfoModel];
                [self handleMapInfoModel:mapInfoModel];
            }else{
                [SVProgressHUD showErrorWithStatus:@"定位失败"];
            }
        }];
    }else{
        [QWGLOBALMANAGER readLocationWhetherReLocation:flag block:^(MapInfoModel *mapInfoModel) {
            [self handleMapInfoModel:mapInfoModel];
        }];
    }
}

- (void)handleMapInfoModel:(MapInfoModel *)mapInfoModel
{
    if(mapInfoModel.status == 1){
        [self showInfoView:@"您当前所在城市暂未开通服务" image:@"icon_pharmacy_default"];
        return ;
    }
    NearByStoreModelR *modelR = [NearByStoreModelR new];
    modelR.page = @(1);
    modelR.pageSize = @(8);
    modelR.type = @(0);
    modelR.city = mapInfoModel.city;
    modelR.nearest = 1;
    modelR.eFee = @(0);
    modelR.sale = @(0);
    modelR.sFee = @(0);
    modelR.best = NO;
    
    modelR.longitude = [NSNumber numberWithFloat:mapInfoModel.location.coordinate.longitude];
    modelR.latitude = [NSNumber numberWithFloat:mapInfoModel.location.coordinate.latitude];
    
    [ConsultStore MallBranchs:modelR success:^(MicroMallBranchListVo *model) {
        
        if([model.apiStatus intValue] == 0 && model.branchs.count > 0){
            
            [_dataArr removeAllObjects];
            [self removeInfoView];
            [_dataArr addObjectsFromArray:model.branchs];
            [_mainTableView reloadData];
        }else{
            [self showMyInfoView:@"没有查到您想要的结果" image:@"icon_no result_search"];
        }
        
        [_mainTableView.footer endRefreshing];
        
    } failure:^(HttpException *e) {
        
        [_mainTableView.footer endRefreshing];
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showMyInfoView:kWarning215N26 image:@"icon_no result_search"];
            }else{
                [self showMyInfoView:kWarning39 image:@"icon_no result_search"];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseBranchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseBranchCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MicroMallBranchVo *model = _dataArr[indexPath.row];
    
    [cell setCell:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ChooseBranchTableViewCell getCellHeight:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [QWGLOBALMANAGER statisticsEventId:@"切换药房_点击药房列表" withLable:nil withParams:nil];
    
    [self.navigation popToRootViewControllerAnimated:NO];
    MicroMallBranchVo *model = _dataArr[indexPath.row];
    
    [QWGLOBALMANAGER setMapBranchId:model.branchId branchName:model.branchName];
//    self.pageType，1.来自首页 2.来自分类
    if(self.pageType == 1){
        [QWGLOBALMANAGER postNotif:NotifChangeBranchFromHomePage data:model.branchName object:nil];
    }
    if(self.pageType == 2){
        [QWGLOBALMANAGER postNotif:NotifChangeBranchFromGoodList data:model.branchName object:nil];
    }
}

#pragma mark - 无数据提示
//add by lijian at V4.0
- (void)showMyInfoView:(NSString *)str image:(NSString *)imageName{
    
    if(infoView == nil){
        infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 25.0f, APP_W, self.view.frame.size.height - 25.0f)];
        infoView.backgroundColor = RGBHex(qwColor18);
    }else{
        for(UIView *view in infoView.subviews){
            [view removeFromSuperview];
        }
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((APP_W - image.size.width)/2.0f, 50.0f, image.size.width, image.size.height)];
    imageView.image = image;
    [infoView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, imageView.frame.origin.y + imageView.frame.size.height + 22.0f, APP_W - 20, 18)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = fontSystem(kFontS1);
    label.textColor = RGBHex(qwColor8);
    label.text = str;
    [infoView addSubview:label];
    
    [self.view addSubview:infoView];
}


@end
