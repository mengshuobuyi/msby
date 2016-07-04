//
//  MyNewCouponQuanViewController.m
//  APP
//  我的优惠券详情
//  Created by 李坚 on 15/11/16.
//  Copyright © 2015年 carret. All rights reserved.
//


#import "MyNewCouponQuanDetailViewController.h"
#import "Coupon.h"
#import "Promotion.h"
#import "CouponUseViewController.h"
#import "SVProgressHUD.h"
#import "MyCouponQuanViewController.h"
#import "LoginViewController.h"
#import "VFourCouponQuanTableViewCell.h"
#import "myConsultTableViewCell.h"
#import "SuitableDrugViewController.h"
#import "ChatViewController.h"
#import "swiftModule-swift.h"
#import "MyEvaluationViewController.h"

static NSString * const BranchIdentifier = @"myConsultTableViewCell";
static NSString * const UITableViewIdentifier = @"UITableViewCell";
static NSString * const CommentCellIdentifier = @"CommentCell";
static NSString * const CouponDetailTableViewCellIdentifier = @"CouponDetailTableViewCell";
static NSString * const CouponQuanTableViewCellIdentifier = @"VFourCouponQuanTableViewCell";

@interface MyNewCouponQuanDetailViewController ()<UITableViewDataSource,UITableViewDelegate,myConsultTableViewCellDelegate,UIWebViewDelegate,UIAlertViewDelegate>{
    float myCommentStar;
    MyCouponDetailVoListModel *couponDetail;
    BOOL firstPushed;
    NSArray *item;
    NSMutableArray *conditionArray;
    UIView *conditionView;
}

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) CGFloat floatCouponDetailHeight;
@property (nonatomic, strong) NSMutableArray *costPharmacies;
@property (nonatomic, strong) NSMutableArray *arrPharmacies;
@property (nonatomic, assign) NSInteger curPharmacyPage;
@property (nonatomic, assign) BOOL isShowDrugs;//是否显示适用商品
//@property (nonatomic, strong) UIWebView *webViewCouponCondition;

@end

@implementation MyNewCouponQuanDetailViewController
- (instancetype)init{
    
    if(self == [super init]){
        firstPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"优惠券";
    self.costPharmacies = [[NSMutableArray alloc]init];
    self.arrPharmacies = [[NSMutableArray alloc]init];
    self.curPharmacyPage = 1;
    conditionArray = [NSMutableArray array];
//    item = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(sharClick)];
    
    
    UIView *ypDetailBarItems=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 55)];
    UIButton * zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomButton setFrame:CGRectMake(23, -2, 55,55)];
    [zoomButton addTarget:self action:@selector(sharClick) forControlEvents:UIControlEventTouchUpInside];
    [zoomButton setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [zoomButton setImage:[UIImage imageNamed:@"icon_share_click"] forState:UIControlStateHighlighted];
    [ypDetailBarItems addSubview:zoomButton];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    item=@[fixed,[[UIBarButtonItem alloc]initWithCustomView:ypDetailBarItems]];
    
    
    [self setupTableView];
    [self GetMyCoupon];
}

#pragma mark - 初始化TableView的UI
- (void)setupTableView{
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView addStaticImageHeader];
    
    self.mainTableView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    couponDetail = [MyCouponDetailVoListModel new]; //备用全局变量
//    self.webViewCouponCondition = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, APP_W, self.floatCouponDetailHeight)];
//    self.webViewCouponCondition.delegate = self;
//    UIScrollView *tempView=(UIScrollView *)[self.webViewCouponCondition.subviews objectAtIndex:0];
//    tempView.scrollEnabled=NO;
    //预加载四种Cell
    [self.mainTableView registerNib:[UINib nibWithNibName:@"myConsultTableViewCell" bundle:nil] forCellReuseIdentifier:BranchIdentifier];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CommentCellIdentifier];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewIdentifier];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CouponDetailTableViewCellIdentifier];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"VFourCouponQuanTableViewCell" bundle:nil] forCellReuseIdentifier:CouponQuanTableViewCellIdentifier];
}

#pragma mark - 上拉加载更多数据
- (void)footerRereshing{
    
    if(self.curPharmacyPage == -1){
        [self.mainTableView.footer endRefreshing];
        [self.mainTableView.footer setCanLoadMore:NO];
    }else{
        self.curPharmacyPage += 1;
        [self getCouponPharmaciesFromMyCoupon];
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(couponDetail == nil){
        return 0;
    }
    if([couponDetail.suitableProductCount intValue]>0){
        if([couponDetail.status intValue] == 3){
            if(self.fromMicroMall){
                return 4;
            }else{
                return 5;
            }
        }else{
            return 4;
        }
    }else{
        if([couponDetail.status intValue] == 3){
            if(self.fromMicroMall){
                return 3;
            }else{
                return 4;
            }
        }else{
            return 3;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        return [VFourCouponQuanTableViewCell getCellHeight:nil] + 10;
    }
    if(indexPath.section == 1){
        if([couponDetail.suitableProductCount intValue]>0){
            return 38.0f;
        }else{
            if([couponDetail.status intValue] == 3 || [couponDetail.status intValue] == 4){
                return 0.0f;
            }else{
                return [self getConditionHeight];
            }
        }
    }
    if(indexPath.section == 2){
        if([couponDetail.suitableProductCount intValue]>0){
            if([couponDetail.status intValue] == 3 || [couponDetail.status intValue] == 4){
                return 0.0f;
            }else{
                return [self getConditionHeight];
            }
        }else{
            return [myConsultTableViewCell getCellHeight:nil];
        }
    }
    if(indexPath.section == 3){
        if([couponDetail.suitableProductCount intValue]>0){
            return [myConsultTableViewCell getCellHeight:nil];
        }else{
            return 44.0f;
        }
    }
    if(indexPath.section == 4){
        return 44.0f;
    }
    return 0.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if([couponDetail.suitableProductCount intValue]>0){
        if(section == 3){
            if([couponDetail.status intValue] != 3){
                return self.arrPharmacies.count;
            }else{
                return self.costPharmacies.count;
            }
        }else{
            return 1;
        }
    }else{
        if(section == 2){
            if([couponDetail.status intValue] != 3){
                return self.arrPharmacies.count;
            }else{
                return self.costPharmacies.count;
            }
        }else{
            return 1;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        VFourCouponQuanTableViewCell *cell = (VFourCouponQuanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CouponQuanTableViewCellIdentifier];
        MyCouponVoModel *model = [[MyCouponVoModel alloc] initWithMyCouponVoModel:couponDetail];
        [cell setMyCouponQuan:model];
        
        if([couponDetail.status intValue] == 3){
            //当券为已使用时，隐藏待评价/已评价章，3.0需求
            if(!self.fromMicroMall){
                cell.statusImage.hidden = NO;
            }else{
                cell.statusImage.hidden = YES;
            }
        }else{
            cell.statusImage.hidden = NO;
        }
        
        //status 1.待使用 2.快过期 3.已使用 4.已过期
        if([couponDetail.status intValue] == 3){//还有使用了才有消费时间
            if (couponDetail.use != nil) {
                cell.dateLabel.text = [NSString stringWithFormat:@"消费时间:%@",couponDetail.use];
            }else{
                cell.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",couponDetail.begin,couponDetail.end];
            }
        }else if([couponDetail.status intValue] == 0) {
                cell.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",couponDetail.begin,couponDetail.end];
        }

        return cell;
    }
    if(indexPath.section == 1){
        if([couponDetail.suitableProductCount intValue]>0){
            return [self getTextCell:tableView WithTitle:@"适用商品" andTitleColor:RGBHex(qwColor6)];
        }else{
            if([couponDetail.status intValue] == 3 || [couponDetail.status intValue] == 4){
                return [tableView dequeueReusableCellWithIdentifier:UITableViewIdentifier];
            }else{
                return [self getCouponDetailCell:tableView WithTitle:@"优惠细则"];
            }
        }
    }
    if(indexPath.section == 2){
        if([couponDetail.suitableProductCount intValue]>0){
            if([couponDetail.status intValue] == 3 || [couponDetail.status intValue] == 4){
                return [tableView dequeueReusableCellWithIdentifier:UITableViewIdentifier];
            }else{
                return [self getCouponDetailCell:tableView WithTitle:@"优惠细则"];
            }
        }else{
            return [self getBranchCell:tableView withIndexPath:indexPath];
        }
    }
    if(indexPath.section == 3){
        if([couponDetail.suitableProductCount intValue]>0){
            return [self getBranchCell:tableView withIndexPath:indexPath];
        }else{
            if([couponDetail.status intValue] == 3){
                if([couponDetail.evaluated intValue] == 1){
                    return [self getCommentCell:tableView];
                }else{
                    return [self getTextCell:tableView WithTitle:@"去评价" andTitleColor:RGBHex(qwColor6)];
                }
            }
        }
    }
    if(indexPath.section == 4){
        if([couponDetail.status intValue] == 3){
            if([couponDetail.evaluated intValue] == 1){
                return [self getCommentCell:tableView];
            }else{
                return [self getTextCell:tableView WithTitle:@"去评价" andTitleColor:RGBHex(qwColor6)];
            }
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:UITableViewIdentifier];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([couponDetail.suitableProductCount intValue]>0){
        if(section == 3){
            //cj
            if([couponDetail.status intValue] != 3 && [couponDetail.suitableBranchCount intValue] == 0){
                return 0.0f;
            }else{
                return 36.0f;
            }
        }else{
            if(section != 0){
                return 7.0f;
            }else{
                return 0.0f;
            }
        }
    }else{
        if(section == 2){
            //cj
            if([couponDetail.status intValue] != 3 && [couponDetail.suitableBranchCount intValue] == 0){
                return 0.0f;
            }else{
                return 36.0f;
            }
        }else{
            if(section != 0){
                return 7.0f;
            }else{
                return 0.0f;
            }
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if([couponDetail.suitableProductCount intValue]>0){
        if(section == 3){
            return [self branchHeaderView];
        }else{
            if(section != 0){
                return [self headerViewLine];
            }else{
                return nil;
            }
        }
    }else{
        if(section == 2){
            return [self branchHeaderView];
        }else{
            if(section != 0){
                return [self headerViewLine];
            }else{
                return nil;
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([couponDetail.suitableProductCount intValue]>0){
        if(indexPath.section == 1){
            [self jumpSuitableDrug];
        }
        if(indexPath.section == 3){
            [self jumpStoreDetail:indexPath];
        }
        if(indexPath.section == 4){
            [self jumpComment];
        }
    }else{
        if(indexPath.section == 2){
            [self jumpStoreDetail:indexPath];
        }
        if(indexPath.section == 3){
            [self jumpComment];
        }
    }
}

#pragma mark - 优惠细则cell
- (UITableViewCell *)getCouponDetailCell:(UITableView *)tableView WithTitle:(NSString *)title
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CouponDetailTableViewCellIdentifier];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.userInteractionEnabled = NO;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, 200, 21)];
    label.font = fontSystem(kFontS4);
    label.textColor = RGBHex(qwColor6);
    label.text = title;
    [cell.contentView addSubview:label];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35 - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell.contentView addSubview:line];
    
    
//    self.webViewCouponCondition.frame = CGRectMake(0, 35.0f, APP_W, self.floatCouponDetailHeight);
//    [cell.contentView addSubview:self.webViewCouponCondition];
    [conditionView removeFromSuperview];
    [cell.contentView addSubview:[self setupConditionView]];
  
    
    return cell;
}

- (UIView *)setupConditionView{
    
    if(conditionArray.count == 0)
        return [[UIView alloc]init];
    if(conditionView)
        return conditionView;
    
    conditionView = [[UIView alloc]initWithFrame:CGRectMake(0, 35.0f, APP_W, [self getConditionHeight])];
    
    int strCount = 0;
    CGFloat viewY = 10.0f;

    for(NSString *str in conditionArray){
        
        UIImageView *point = [[UIImageView alloc]initWithFrame:CGRectMake(15, viewY + 5.0f, 6, 6)];
        point.image = [UIImage imageNamed:@"img_point"];
        [conditionView addSubview:point];
        
        CGSize size = [QWGLOBALMANAGER sizeText:str font:fontSystem(kFontS5) limitWidth:APP_W - 34.0f];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(27.0f, viewY,  APP_W - 34.0f, size.height)];
        label.numberOfLines = 0;
        label.font = fontSystem(kFontS5);
        label.textColor = RGBHex(qwColor6);
        label.text = str;
        [conditionView addSubview:label];
        viewY = viewY + label.frame.size.height;
        
        viewY += 8.0f;
        strCount ++;
    }
    
    return conditionView;
}

- (CGFloat)getConditionHeight{
    
    CGFloat conditionHeight = 10.0f;
    for(NSString *str in conditionArray){
        CGSize size = [QWGLOBALMANAGER sizeText:str font:fontSystem(kFontS5) limitWidth:APP_W - 34.0f];
        conditionHeight += size.height;
        conditionHeight += 8.0f;
    }
    return conditionHeight + 47.0f;
}

#pragma mark - 普通Cell(适用商品、去评价)
-(UITableViewCell*)getTextCell:(UITableView*)tableView WithTitle:(NSString*)title andTitleColor:(UIColor *)titleColor
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewIdentifier];
    for (UIView *subView in cell.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 11.5, 200, 21)];
    label.font = fontSystem(14.0f);
    label.textColor = titleColor;
    label.text = title;
    [cell addSubview:label];
    
    UIImageView *im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_btn_listarrow"]];
    im.frame = CGRectMake(0, 0, 15, 15);
    cell.accessoryView = im;
    return  cell;
}

#pragma mark - 已评价Cell
-(UITableViewCell*)getCommentCell:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
    
    for(UIView *view in cell.subviews){
        if([view isKindOfClass:[UILabel class]]){
            [view removeFromSuperview];
        }
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 11.5, 70, 21)];
    label.font = fontSystem(14.0f);
    label.textColor = RGBHex(qwColor6);
    label.text = @"我的评价";
    [cell addSubview:label];
    
    RatingView *ratView = [[RatingView alloc]initWithFrame:CGRectMake(90, 15.5, 80, 21)];
    ratView.userInteractionEnabled = NO;
    [ratView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
    float star = myCommentStar/2;
    [ratView displayRating:star];
    [cell addSubview:ratView];
    UIImageView *im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_btn_listarrow"]];
    im.frame = CGRectMake(0, 0, 15, 15);
    cell.accessoryView = im;
    
    return cell;
}
#pragma mark - 药房Cell
// 适用药房的cell
-(UITableViewCell*)getBranchCell:(UITableView*)tableView withIndexPath:(NSIndexPath *)indexp
{

    myConsultTableViewCell *cell = (myConsultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:BranchIdentifier];
    
    CouponBranchVoModel *model;
    if([couponDetail.status intValue] == 3){
        model = self.costPharmacies[indexp.row];
    }else{
        model = self.arrPharmacies[indexp.row];
    }
    
    cell.cellDelegate = self;
    cell.useButton.tag = indexp.row;
    [cell.useButton addTarget:self action:@selector(useAction:) forControlEvents:UIControlEventTouchUpInside];
    if([couponDetail.status intValue] == 1 || [couponDetail.status intValue] == 2){
        //表示可以使用
        cell.useButton.hidden = NO;
        [cell.useButton setTitle:@"立即使用" forState:UIControlStateNormal];
        [cell.useButton setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
        cell.useButton.layer.borderColor = RGBHex(qwColor2).CGColor;
    }else if([couponDetail.status intValue] == 0){
        //还未开始
        cell.useButton.hidden = NO;
        [cell.useButton setTitle:@"还未开始" forState:UIControlStateNormal];
        [cell.useButton setTitleColor:RGBHex(qwColor9) forState:UIControlStateNormal];
        cell.useButton.layer.borderColor = RGBHex(qwColor9).CGColor;
    }else{
        //已使用或已过期
        cell.useButton.hidden = YES;
    }
    
    
    [cell setCell:model];
    if([couponDetail.status intValue] == 3){
        cell.distance.hidden = YES;
    }else{
        cell.distance.hidden = NO;
    }
    cell.chatButton.hidden = YES;
    cell.branchImage.hidden = YES;
    cell.viewSeparateLine.hidden = YES;
    return cell;
}

- (void)useAction:(UIButton *)sender{
    
    if([couponDetail.status intValue] == 1 || [couponDetail.status intValue] == 2){
        CouponBranchVoModel *model = self.arrPharmacies[sender.tag];
        if([model.type intValue] == 3){
            if([couponDetail.scope integerValue] == 7){
                [self GoUseQuanHTTP];
            }else{
                [QWGLOBALMANAGER pushBranchDetail:model.branchId withType:model.type navigation:self.navigationController];
            }
            
        }else{
            [self GoUseQuanHTTP];
        }
    }else{
        return;
    }
}

#pragma mark - 获取适用药房数据
- (void)getCouponPharmaciesFromMyCoupon
{
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        //2.2.3 获取适用药房
        CouponNewBranchSuitableModelR *newModelR = [CouponNewBranchSuitableModelR new];
        newModelR.couponId = couponDetail.couponId;
        newModelR.page = [NSString stringWithFormat:@"%ld",self.curPharmacyPage];
        newModelR.pageSize = @"10";
        if(mapInfoModel == nil){
            newModelR.lng = @"120.730435";
            newModelR.lat = @"31.273391";
//            newModelR.city = @"苏州";
        }else{
            newModelR.lng = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.longitude];
            newModelR.lat = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.latitude];
//            newModelR.city = mapInfoModel.city;
        }
        
        HttpClientMgr.progressEnabled = NO;
        [Coupon getMyCouponPharmacy:newModelR success:^(id obj) {
            
            CouponBranchVoListModel *couponPharModel = (CouponBranchVoListModel *)obj;
            
            
            if (couponPharModel.suitableBranchs.count == 0) {
                self.curPharmacyPage = -1;
            }
            if (self.curPharmacyPage == 1) {
                [self.arrPharmacies removeAllObjects];
                self.arrPharmacies = [couponPharModel.suitableBranchs mutableCopy];
                [self.mainTableView.footer endRefreshing];
            } else {
                [self.arrPharmacies addObjectsFromArray:couponPharModel.suitableBranchs];
                [self.mainTableView.footer endRefreshing];
            }
            [self.mainTableView reloadData];

        } failure:^(HttpException *e) {
            self.curPharmacyPage -= 1;
            [self.mainTableView.footer endRefreshing];
        }];
    }];
}

#pragma mark - 我的优惠券列表页面进入HTTPRequest
- (void)GetMyCoupon{
    
    [self showInfoView:@"" image:nil];
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
    
        [self myCouponRequest:mapInfoModel];

    }];
}

#pragma mark - 我的评价星星请求
- (void)getStar:(NSString *)orderId{
    
    commnetModelR *modelR = [commnetModelR new];
    modelR.orderId = orderId;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    
    [Promotion checkMyComment:modelR success:^(id obj) {
        
        CommentVo *vo = obj;
        
        if([vo.apiStatus intValue] == 1){
            
        }else{
            myCommentStar = [vo.star floatValue];
        }
        [self.mainTableView reloadData];
    } failure:^(HttpException *e) {
        [self.mainTableView reloadData];
    }];
}

#pragma mark - 去使用(消费)HTTP以及VC入口
- (void)GoUseQuanHTTP{
    
    CouponShowModelR *modelR = [CouponShowModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.myCouponId = couponDetail.myCouponId;
    
    [Coupon couponShow:modelR success:^(UseMyCouponVoModel *model) {
        if([model.apiStatus integerValue] == 0)
        {
            CouponUseViewController *couponUseViewController = [[CouponUseViewController alloc] initWithNibName:@"CouponUseViewController" bundle:nil];
            couponUseViewController.useModel = model;
            [self.navigationController pushViewController:couponUseViewController animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.8];
        }
    } failure:^(HttpException *e) {
        
    }];
}

#pragma mark - 商品下架/冻结背景提示UI
//背景提示需要自定义增加控件,所有和父类方法混用(例外特殊)
-(void)showMyInfoView:(NSString *)text image:(NSString*)imageName tag:(NSInteger)tag
{
    UIView *vInfo = [super showInfoView:text image:imageName tag:tag];
    UIView *lblInfo = [vInfo viewWithTag:101];
    UIButton *checkButton = [[UIButton alloc]initWithFrame:CGRectMake(APP_W - 120, lblInfo.frame.origin.y + lblInfo.frame.size.height + 52, 100, 21) ];
    checkButton.titleLabel.font = fontSystem(kFontS4);
    [checkButton setTitle:@"查看我的优惠" forState:UIControlStateNormal];
    [checkButton setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(pushToMyQuan:) forControlEvents:UIControlEventTouchUpInside];
    [vInfo addSubview:checkButton];
    
}

#pragma mark - 进入适用商品
-(void)jumpSuitableDrug
{
    SuitableDrugViewController *vc = [[SuitableDrugViewController alloc]init];
    vc.couponId = couponDetail.couponId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 去评价/我的评价
-(void)jumpComment
{
    if([couponDetail.evaluated intValue] == 0){
        //去评价
        EvaluateCouponViewController *evaluateCouponViewController = [[EvaluateCouponViewController alloc] initWithNibName:@"EvaluateCouponViewController" bundle:nil];
        CouponOrderCheckVo *model = [CouponOrderCheckVo new];
        model.orderId = couponDetail.orderId;
        model.branchName = couponDetail.groupName;
        evaluateCouponViewController.orderCheckModel = model;
        [self.navigationController pushViewController:evaluateCouponViewController animated:YES];
    }else{
        //我的评价
        MyEvaluationViewController *myEvaluationView = [[MyEvaluationViewController alloc]initWithNibName:@"MyEvaluationViewController" bundle:nil];
        myEvaluationView.orderId = couponDetail.orderId;
        [self.navigationController pushViewController:myEvaluationView animated:YES];
    }
}

#pragma mark - 进入我的优惠券，从药房详情/IM/推送进入领取成功后进入我的优惠券
- (void)pushToMyQuan:(id)sender{
    if(QWGLOBALMANAGER.loginStatus){
        for(UIViewController *view in self.navigationController.viewControllers){
            
            if([view isKindOfClass:[MyCouponQuanViewController class]]){
                [self.navigationController popToViewController:view animated:YES];
                return;
            }
        }
        MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
        myCouponQuan.popToRootView = NO;
        [self.navigationController pushViewController:myCouponQuan animated:YES];
        
    }else{
        LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginView animated:YES];
    }
}

#pragma mark - 展示Button(未到使用期/去使用/隐藏)
- (void)showUseButton:(NSInteger)tag{
    
    if(tag == 0 || tag == 1){
        //未开始/待使用/快过期
        self.mainTableView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H - 50);
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, APP_H - NAV_H - 47.5, APP_W - 20, 45.0f)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4.5f;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(GoUseQuanHTTP) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if(tag == 0){
            [btn setBackgroundColor:RGBHex(qwColor9)];
            [btn setTitle:@"未到使用期" forState:UIControlStateNormal];
            btn.enabled = NO;
        }
        if(tag == 1){
            [btn setBackgroundColor:RGBHex(qwColor2)];
            [btn setTitle:@"去使用(到店消费)" forState:UIControlStateNormal];
            btn.enabled = YES;
        }
    }else{
        self.mainTableView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H);
    }
}

#pragma mark - 适用/消费药房HeaderView
- (UIView *)branchHeaderView{
    //cj
    if([couponDetail.status intValue] != 3 && [couponDetail.suitableBranchCount intValue] == 0){
        return nil;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 36.0f)];
    view.backgroundColor = RGBHex(qwColor4);
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    topLine.backgroundColor = RGBHex(qwColor10);
    [view addSubview:topLine];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 16.0f)];
//    label.backgroundColor = [UIColor grayColor];
    label.text = [NSString stringWithFormat:@"适用药房(%d)",[couponDetail.suitableBranchCount intValue]];
    label.textColor = RGBHex(qwColor6);
    label.font = fontSystem(kFontS4);
    if([couponDetail.status intValue] == 3){
        label.text = @"消费药房";
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,35.5f, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [view addSubview:line];
    [view addSubview:label];
    
    return view;
}
#pragma mark - 分割线HeaderView
- (UIView *)headerViewLine{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 7.0f)];
    view.backgroundColor = RGBHex(qwColor11);
    return view;
}

#pragma mark - 聊天按钮点击事件
- (void)takeTalk:(NSString *)branchId name:(NSString *)branchName{
    ChatViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ChatViewController"];
    consultViewController.sendConsultType = Enum_SendConsult_Common;
    consultViewController.branchId = branchId;
    consultViewController.branchName = branchName;
    [self.navigationController pushViewController:consultViewController animated:YES];
}

#pragma mark - 打电话按钮点击事件
- (void)takePhone:(NSString *)telNumber{

    if(!StrIsEmpty(telNumber)){
        [[[UIAlertView alloc]initWithTitle:@"呼叫" message:telNumber delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",alertView.message]]];
    }
}

#pragma mark - 进入药房详情
-(void)jumpStoreDetail:(NSIndexPath *)indexP
{
    //进入药房详情
    
}

#pragma mark - 统计事件
- (void)TrackEvent{
    
    if(firstPushed){
        NSString *type;
        switch([couponDetail.scope intValue]){
            case 1:
                type = @"通用";
                break;
            case 2:
                type = @"慢病";
                break;
            case 4:
                type = @"礼品";
                break;
            default:
                type = @"";
                break;
        }
        firstPushed = NO;
    }
}
#pragma mark - 分享按钮建立
- (void)setUpRightItem:(BOOL)flag{
    if(flag){ 
        self.navigationItem.rightBarButtonItems = item;
    }else{
        self.navigationItem.rightBarButtonItems = nil;
    }
}
#pragma mark - 分享
- (void)sharClick{
    //0.待开始，1.待使用，2.快过期，3.已使用，4.已过期,
    
    //cj---224更改所有的全部分享变成使用前的
    ShareContentModel *modelShare = [[ShareContentModel alloc] init];
    modelShare.typeShare    = ShareTypeMyCoupon;
    NSArray *arrParams      = @[couponDetail.couponId,couponDetail.groupId];
    if([couponDetail.scope intValue] == 4){
        modelShare.imgURL   = couponDetail.giftImgUrl;
    }
    modelShare.shareID      = modelShare.shareID = [arrParams componentsJoinedByString:SeparateStr];
    modelShare.title        = couponDetail.couponTitle;
    modelShare.content      = couponDetail.desc;
    
    ShareSaveLogModel *modelR = [ShareSaveLogModel new];
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    if(mapInfoModel) {
        modelR.city = mapInfoModel.city;
        modelR.province = mapInfoModel.province;
    }else{
        modelR.city = @"苏州市";
        modelR.province = @"江苏省";
    }
    modelR.shareObj = @"1";
    modelR.shareObjId = couponDetail.couponId;
    modelShare.modelSavelog = modelR;
    [self popUpShareView:modelShare];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 2.2.0 优惠券详情(现在使用的)
- (void)myCouponRequest:(MapInfoModel *)mapInfoModel{
    
    CouponGetModelR *modelR = [CouponGetModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.myCouponId = self.myCouponId;
    
    if(mapInfoModel == nil){
        modelR.longitude = @(120.730435);
        modelR.latitude = @(31.273391);
        modelR.city = @"苏州";
    }else{
        modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
        modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
        modelR.city = mapInfoModel.city;
    }
    
    [Coupon couponGetMyCoupon:modelR success:^(id obj) {
        couponDetail = obj;
        [self getCouponSuccess];
    } failure:^(HttpException *e) {
        [self getCouponFail:e];
    }];
}
//#pragma mark - 2.2.3 优惠券详情
//- (void)newMyCouponRequest:(MapInfoModel *)mapInfoModel{
//    
//    GetNewOnlineCouponModelR *modelRNew = [GetNewOnlineCouponModelR new];
//    modelRNew.token = QWGLOBALMANAGER.configure.userToken;
//    modelRNew.couponId = self.couponId;
//    modelRNew.myCouponId = self.myCouponId;
//    if(mapInfoModel == nil){
//        modelRNew.longitude = @(120.730435);
//        modelRNew.latitude = @(31.273391);
//        modelRNew.city = @"苏州";
//    }else{
//        modelRNew.longitude = @(mapInfoModel.location.coordinate.longitude);
//        modelRNew.latitude = @(mapInfoModel.location.coordinate.latitude);
//        modelRNew.city = mapInfoModel.city;
//    }
//    
//    [Coupon getNewOnlineCoupon:modelRNew success:^(MyCouponDetailVoListModel *obj) {
//        couponDetail = obj;
//        [self getCouponSuccess];
//    } failure:^(HttpException *e) {
//        [self getCouponFail:e];
//    }];
//}

#pragma mark - getMyCopon请求成功处理
- (void)getCouponSuccess{
    
    [self removeInfoView];
    if([couponDetail.apiStatus intValue] == 0){
        [self TrackEvent];
        [self setUpRightItem:YES];
        if([couponDetail.frozen intValue] == 1 && [couponDetail.status intValue] != 3){
            [self showMyInfoView:couponDetail.apiMessage image:@"ic_img_cry" tag:0];
            [self setUpRightItem:NO];
            return;
        }
        
        //cj
        if([couponDetail.status intValue] != 3 && [couponDetail.suitableBranchCount intValue] != 0){
            [self.mainTableView addFooterWithTarget:self action:@selector(footerRereshing)];
        }else{
            [self.mainTableView removeFooter];
            [self.costPharmacies removeAllObjects];
            [self.costPharmacies addObjectsFromArray:couponDetail.suitableBranchs];
        }
        if([couponDetail.evaluated intValue] == 1){
            [self getStar:couponDetail.orderId];
        }
//        if([couponDetail.status intValue] == 0){
//            //未开始，展示未到使用期Button
//            [self showUseButton:0];
//        }
//        if([couponDetail.status intValue] == 1 || [couponDetail.status intValue] == 2){
//            //待使用或是快过期，展示去使用Button
//            [self showUseButton:1];
//        }
//        if([couponDetail.status intValue] == 3 || [couponDetail.status intValue] == 4){
//            //已使用或已过期，隐藏去使用Button
//            [self showUseButton:2];
//        }
        if(!couponDetail.open || [couponDetail.status intValue] == 4 || !couponDetail.canUserShare){//非公开券,该优惠券已过期,用户端是否能够分享
            [self setUpRightItem:NO];
        }
    }else{
        [self setUpRightItem:NO];
        [self showMyInfoView:couponDetail.apiMessage image:@"ic_img_cry" tag:0];
        return;
    }
    //获取优惠细则的个数
    CouponConditionModelR *modelRCondition = [CouponConditionModelR new];
    modelRCondition.type = @"1";
    modelRCondition.id = couponDetail.couponId;
    
    
    [Coupon getCouponCondition:modelRCondition success:^(id couponConditions) {
        CouponConditionVoListModel *modelCondition = (CouponConditionVoListModel *)couponConditions;
        [conditionArray addObject:modelCondition.title];
        [conditionArray addObjectsFromArray:modelCondition.conditions];
   
        [self.mainTableView reloadData];
    } failure:^(HttpException *e) {
        
    }];
    
    [self.mainTableView reloadData];
//    [self.webViewCouponCondition loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/help/condition.html?type=%@&id=%@",HTML5_DIRECT_URL,@"1",couponDetail.couponId]]]];
    //获取优惠药房
    //cj
    if ([couponDetail.suitableBranchCount intValue] > 0 && [couponDetail.status intValue] != 3) {
        [self getCouponPharmaciesFromMyCoupon];
        
    }
}

#pragma mark - getMyCopon请求失败处理
- (void)getCouponFail:(HttpException *)e{
    
    [self setUpRightItem:NO];
    if(e.errorCode!=-999){
        if(e.errorCode == -1001){
            [self showInfoView:kWarning215N26 image:@"ic_img_fail" tag:0];
        }else{
            [self showInfoView:kWarning39 image:@"ic_img_fail" tag:0];
        }
    }
}
@end
