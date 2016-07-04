//
//  MedicineSearchResultViewController.m
//  APP
//  首页搜索药品 中间比价页面  3.0.0新增 4.0修改

//  h5/mmall/product/byCode 根据proId获取商品详情，用于显示Header
//  h5/mmall/product/onSaleBranchs 可售药房列表获取，用于比价

//  Created by 李坚 on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MedicineSearchResultViewController.h"
#import "ResultBranchTableViewCell.h"
#import "ReceiverAddressTableViewController.h"
#import "MedicineDetailViewController.h"
#import "SVProgressHUD.h"
#import "XHImageViewer.h"

static NSString *const storeCellIdentifier = @"ResultBranchTableViewCell";

@interface MedicineSearchResultViewController ()<UITableViewDataSource,UITableViewDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,XHImageViewerDelegate,UIScrollViewDelegate>{
    BOOL requestSuccess;
    MedicineSearchHeaderView *headerView;
    XLCycleScrollView *cycleScrollView;
    BranchProductVo *searchModel;
    NSInteger currentPage;
}


@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (nonatomic, strong) NSMutableArray *branchs;

@end

@implementation MedicineSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [QWGLOBALMANAGER statisticsEventId:@"商品比价页面" withLable:nil withParams:nil];
    
    requestSuccess = NO;
     currentPage = 1;
    _mainTableView.contentInset = UIEdgeInsetsMake(22, 0, 0, 0);
    [_mainTableView registerNib:[UINib nibWithNibName:storeCellIdentifier bundle:nil] forCellReuseIdentifier:storeCellIdentifier];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.branchs = [NSMutableArray array];
    [self loadDrugData];
    [self loadBranchData];//可售药房
    [self.mainTableView addFooterWithTarget:self action:@selector(refreshData)];
    self.mainTableView.footerPullToRefreshText = kWarning6;
    self.mainTableView.footerReleaseToRefreshText = kWarning7;
    self.mainTableView.footerRefreshingText = kWarning9;
    self.mainTableView.footerNoDataText = kWarning44;

    if(StrIsEmpty(self.lastPageName)){
        self.lastPageName = @"未知";
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"上级页面"] = self.lastPageName;
    
    [QWGLOBALMANAGER statisticsEventId:@"x_ypbj_cx" withLable:@"药品比价页面出现" withParams:param];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if([scrollView isEqual:_mainTableView]){
        
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat offsetH = 22 + offsetY;
        CGFloat alpha = offsetH / 22;
        
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[RGBHex(qwColor4) colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[RGBHex(qwColor20) colorWithAlphaComponent:alpha]]];
        
        if(alpha > 1.0){
            if(self.LeftItemBtn.alpha != 1.0){
                self.LeftItemBtn.alpha = alpha - 1.0;
                [self.LeftItemBtn setImage:[UIImage imageNamed:@"arrow_slide_details"] forState:UIControlStateNormal];
                [self.LeftItemBtn setImage:[UIImage imageNamed:@"arrow_slide_details"] forState:UIControlStateHighlighted];
            }
        }else{
            [self.LeftItemBtn setImage:[UIImage imageNamed:@"icon_return_details"] forState:UIControlStateNormal];
            [self.LeftItemBtn setImage:[UIImage imageNamed:@"icon_return_details"] forState:UIControlStateHighlighted];
            self.LeftItemBtn.alpha = 1.0 - alpha;
        }
    }
}

#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 底部的分页加载
- (void)refreshData{
    HttpClientMgr.progressEnabled = NO;
    [self loadBranchData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self naviLeftBottonImage:[UIImage imageNamed:@"icon_return_details"] highlighted:[UIImage imageNamed:@"icon_return_details"] action:@selector(popVCAction:)];
    [self setNavigationBarColor:[UIColor clearColor] Shadow:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self setNavigationBarColor:nil Shadow:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"img-shaow"]];
}

- (void)refreshUI{
    [self setupHeaderView];
    [_mainTableView reloadData];
    [cycleScrollView reloadData];
   
}


- (void)setupHeaderView{
    if(headerView == nil){
        headerView = [MedicineSearchHeaderView getView];
        headerView.bannerHeight.constant = APP_W;
        headerView.frame = CGRectMake(0, 0, APP_W, 70.0f + APP_W);
        cycleScrollView = [[XLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_W)];
        cycleScrollView.tag = 1008;
        cycleScrollView.datasource = self;
        cycleScrollView.delegate = self;
        [cycleScrollView setupUIControl];
        CGFloat PCFrameX = (APP_W - cycleScrollView.pageControl.frame.size.width)/2;
        CGRect rect = cycleScrollView.pageControl.frame;
        rect.origin.x = PCFrameX;
        cycleScrollView.pageControl.frame = rect;
        [headerView.topView addSubview:cycleScrollView];
        _mainTableView.tableHeaderView = headerView;
    }
}

#pragma mark - Banner药品图片点击Action
- (void)showFullScreenImage:(NSInteger)currentIndex
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *imageList = [NSMutableArray array];
        for(NSString *imgUrl in searchModel.imgUrls) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,APP_W, cycleScrollView.frame.size.height)];
            [imageView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img_banner_nomal"]];
            [imageList addObject:imageView];
            imageView.tag = [searchModel.imgUrls indexOfObject:imgUrl];
        }
        UIImageView *imageView =  [cycleScrollView.curViews objectAtIndex:1];
        imageView.tag = currentIndex;
        [imageList replaceObjectAtIndex:currentIndex withObject:imageView];
        XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
        imageViewer.delegate = self;
        [imageViewer showWithImageViews:imageList selectedView:imageList[currentIndex]];
    });
}

#pragma mark - 附近可售药房请求
- (void)loadDrugData{
    
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) { //add by jxb
        ProductByCodeModelR *modelR = [ProductByCodeModelR new];
        modelR.city = mapInfoModel.city;
        modelR.code = self.productCode;
        modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
        modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
        
        [ConsultStore MedicineDetailByCode:modelR success:^(BranchProductVo *model) {
            //附近无可售药房，背景提示
            if([model.apiStatus intValue] != 0 || model.branchs.count == 0){
                [self showInfoView:@"抱歉，暂无门店销售此药品，敬请期待哟！！" image:@"ic_img_fail"];
                return;
            }
            
            if([model.apiStatus intValue] == 0){
                searchModel=model;
                [self refreshUI];
                requestSuccess = YES;
                headerView.quantityLabel.text=searchModel.spec;
                headerView.proName.text=searchModel.name;
                 _mainTableView.tableHeaderView = headerView;
                [_mainTableView reloadData];
            }else{
                _mainTableView.tableHeaderView = nil;
            }
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }];
    }];
}

#pragma mark - 附近可售药房请求
- (void)loadBranchData{
    
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) { //add by jxb
        ProductByCodeBranchModelR *modelR = [ProductByCodeBranchModelR new];
        modelR.city = mapInfoModel.city;
        modelR.code = self.productCode;
        modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
        modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
        modelR.page = currentPage;
        modelR.pageSize = 10;
        //券的可售药房
        if(!StrIsEmpty(self.couponId)){
              modelR.couponId = self.couponId;
        }
        [ConsultStore BranchListByCode:modelR success:^(OnSaleBranchListVo *model) {
            //附近无可售药房，背景提示
            
            if(currentPage == 1){
                [self.branchs removeAllObjects];
                [self.branchs addObjectsFromArray:model.branchs];
            }else{
                [self.branchs addObjectsFromArray:model.branchs];
            }
            if(model.branchs.count>0){
                currentPage++;
                [self.mainTableView reloadData];
            }else{
                self.mainTableView.footer.canLoadMore = NO;
            }
            [self.mainTableView footerEndRefreshing];
            
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.branchs.count>0){
        return self.branchs.count+1;
    }else{
        return 0;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
       return 40.0f;
    }else{
       return [ResultBranchTableViewCell getCellHeight:self.branchs[indexPath.row-1]];
    }
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        static NSString *SearchIdentifier = @"SearchIdentifier";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:SearchIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, APP_W, 0.5)];
            line.backgroundColor = RGBHex(qwColor10);
            [cell addSubview:line];
        }
        if(!StrIsEmpty(self.couponId)){
         cell.textLabel.text = @"选择适用药房";
        }else{
         cell.textLabel.text = @"选择可售药房";
        }
       
        cell.textLabel.font = fontSystem(kFontS3);
        cell.textLabel.textColor = RGBHex(qwColor6);
        return cell;
    
    }else{
        ResultBranchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
        MicroMallBranchVo *model = self.branchs[indexPath.row-1];
        [cell setCell:model];
        
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [QWGLOBALMANAGER statisticsEventId:@"商品比价页面_选择可售药房" withLable:nil withParams:nil];

        //新药品详情界面
        MicroMallBranchVo *VO = self.branchs[indexPath.row-1];
        if(StrIsEmpty(VO.branchProId)){
//            [SVProgressHUD showErrorWithStatus:@"没有branchProId,怎么跳转？"];
            return;
        }
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"药品名"] = VO.name;
        [QWGLOBALMANAGER statisticsEventId:@"x_pd_ypxq" withLable:@"频道药品比价" withParams:tdParams];
        [QWGLOBALMANAGER statisticsEventId:@"x_sy_yf" withLable:@"定位" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"药房名":VO.branchName}]];
        MedicineDetailViewController *VC = [[MedicineDetailViewController alloc]initWithNibName:@"MedicineDetailViewController" bundle:nil];
        VC.pushFromChatView = _IMPushed;
        VC.lastPageName = @"搜索结果比价页面";
        VC.proId = VO.branchProId;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    
    
}

#pragma mark - XHImageViewerDelegate
- (void)imageViewer:(XHImageViewer *)imageViewer willDismissWithSelectedView:(UIImageView *)selectedView
{
    NSInteger index = selectedView.tag;
    if(index == cycleScrollView.currentPage) {
        return;
    }
    [cycleScrollView scrollAtIndex:index];
}


#pragma mark - XLCycleScrollViewDataSource
- (NSInteger)numberOfPages{
    
    if(searchModel){
        if(searchModel.imgUrls.count == 0){
            return 1;
        }else{
            return searchModel.imgUrls.count;
        }
    }else{
        return 1;
    }
}

- (UIView *)pageAtIndex:(NSInteger)index{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,APP_W, APP_W)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(searchModel){
        if(searchModel.imgUrls.count == 0){
            [imageView setImage:[UIImage imageNamed:@"bg_nomal_two"]];
        }else{
            [imageView setImageWithURL:[NSURL URLWithString:searchModel.imgUrls[index]] placeholderImage:[UIImage imageNamed:@"bg_nomal_two"]];
        }
    }else{
        [imageView setImage:[UIImage imageNamed:@"bg_nomal_two"]];
        
    }
    return imageView;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index{
    [self showFullScreenImage:index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end




@implementation MedicineSearchHeaderView

+ (MedicineSearchHeaderView *)getView{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *xibArray = [bundle loadNibNamed:@"MedicineSearchResultViewController" owner:nil options:nil];
    for(UIView *view in xibArray){
        if([view isKindOfClass:[MedicineSearchHeaderView class]]){
            view.clipsToBounds = YES;
            return (MedicineSearchHeaderView *)view;
        }
    }
    return nil;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}
@end

