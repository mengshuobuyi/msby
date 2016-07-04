//
//  BranchPromotionView.m
//  APP
//
//  Created by 李坚 on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BranchCouponDetailView.h"
#import "otherPharmcyTableViewCell.h"
#import "QWGlobalManager.h"


static NSString *const storeCellIdentifier = @"otherPharmcyTableViewCell";

@implementation BranchCouponDetailView
//领券中心的优惠券详情，按钮停留在底部
+ (BranchCouponDetailView *)showInView:(UIWindow *)blackView withTitle:(NSString *)title model:(OnlineCouponDetailVo *)message list:(NSArray *)dataArr withSelectedIndex:(NSInteger)index  withType:(BranchCouponDetailViewType)type andCallBack:(disMissCallback)callBack{
    //UI层
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BranchCouponDetailView" owner:self options:nil];
    BranchCouponDetailView *bpView = [nibView objectAtIndex:0];
    bpView.footView.hidden=NO;
    bpView.footviewheight.constant=50;
    
    
    bpView.frame = CGRectMake(0, 0, APP_W, APP_H + 20);
    bpView.viewType = type;
    bpView.backView.alpha = 0.0f;
    CGRect rect = bpView.mainView.frame;
    rect.origin.y = APP_H + 20;
    bpView.mainView.frame = rect;
    
    if(!bpView.superview) {
        [blackView addSubview:bpView];
    }
    [blackView bringSubviewToFront:bpView];
    
    //设置按钮
    [bpView setButton:message];
    
    
    [bpView layoutIfNeeded];
    //数据层的展示
    bpView.dismissCallback = callBack;
    if(type == Enum_CouponCenter){
        [bpView.bpTableView registerNib:[UINib nibWithNibName:storeCellIdentifier bundle:nil] forCellReuseIdentifier:storeCellIdentifier];
        bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
        bpView.mainLabel.text = title;
    }
    bpView.dataArray = [NSMutableArray arrayWithArray:dataArr];
    bpView.curPage=2;
    bpView.couponId=message.couponId;
    [bpView.bpTableView reloadData];
    
    
    //动画的效果
    [UIView animateWithDuration:0.5 animations:^{
        
        bpView.backView.alpha = 0.3f;
        CGRect rect = bpView.mainView.frame;
        rect.origin.y = APP_H - 325;
        bpView.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
    return bpView;
}


//我的优惠券详情
+ (BranchCouponDetailView *)showMyInView:(UIWindow *)blackView withTitle:(NSString *)title model:(MyCouponDetailVo *)message list:(NSArray *)dataArr withSelectedIndex:(NSInteger)index  withType:(BranchCouponDetailViewType)type andCallBack:(disMissCallback)callBack{
    //UI层
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BranchCouponDetailView" owner:self options:nil];
    BranchCouponDetailView *bpView = [nibView objectAtIndex:0];
    bpView.footView.hidden=YES;
    bpView.footviewheight.constant=0;
    
    
    bpView.frame = CGRectMake(0, 0, APP_W, APP_H + 20);
    bpView.viewType = type;
    bpView.backView.alpha = 0.0f;
    CGRect rect = bpView.mainView.frame;
    rect.origin.y = APP_H + 20;
    bpView.mainView.frame = rect;
    
    if(!bpView.superview) {
        [blackView addSubview:bpView];
    }
    [blackView bringSubviewToFront:bpView];
    
    [bpView layoutIfNeeded];
    //数据层的展示
    bpView.dismissCallback = callBack;
    if(type == Enum_CouponDetail){
        [bpView.bpTableView registerNib:[UINib nibWithNibName:storeCellIdentifier bundle:nil] forCellReuseIdentifier:storeCellIdentifier];
        bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
        bpView.mainLabel.text = title;
    }
    bpView.dataArray = [NSMutableArray arrayWithArray:dataArr];
    bpView.curPage=2;
    bpView.couponId=message.couponId;
    [bpView.bpTableView reloadData];
    
    
    //动画的效果
    [UIView animateWithDuration:0.5 animations:^{
        
        bpView.backView.alpha = 0.3f;
        CGRect rect = bpView.mainView.frame;
        rect.origin.y = APP_H - 325;
        bpView.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
    return bpView;
}



-(void)setButton:(OnlineCouponDetailVo*)model{

    if (model.empty) {
        // 该券已抢光
        self.lblRemindNum.text = @"已抢完";
        [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
        self.btnGetCoupon.enabled=NO;
        self.btnGetCoupon.backgroundColor=RGBHex(qwColor10);
    } else {
        // 该券还有
        if ([model.pick intValue] == 0) {
            // 未领取过该券
            self.lblRemindNum.text = [NSString stringWithFormat:@"可领%@次",model.couponNumLimit];
            [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
            self.btnGetCoupon.enabled=YES;
            self.btnGetCoupon.backgroundColor=RGBHex(qwColor2);
        } else {
            // 已领取过该券
            if ([model.couponNumLimit intValue] == 0) {
                // 已经领过优惠券，并且个数为0
                self.lblRemindNum.text = @"已领完";
                [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
                self.btnGetCoupon.enabled=NO;
                self.btnGetCoupon.backgroundColor=RGBHex(qwColor10);
            } else {
                self.lblRemindNum.text = [NSString stringWithFormat:@"还可领%@次",model.couponNumLimit];
                [self.btnGetCoupon setTitle:@"领取优惠" forState:UIControlStateNormal];
                self.btnGetCoupon.enabled=YES;
                self.btnGetCoupon.backgroundColor=RGBHex(qwColor2);
            }
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:rect];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.btnGetCoupon.layer.masksToBounds=YES;
    self.btnGetCoupon.layer.cornerRadius=4.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.backView addGestureRecognizer:tap];
    [self.btnGetCoupon addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.bpTableView.dataSource = self;
    self.bpTableView.delegate = self;
    self.bpTableView.tableFooterView = [[UIView alloc]init];
    self.bpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bpTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}


#pragma mark - 分页加载
- (void)footerRereshing{
    HttpClientMgr.progressEnabled = NO;
    [self loadBranchsData];
}

- (void)loadBranchsData{
    
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        CouponNewBranchSuitableModelR *modelR = [CouponNewBranchSuitableModelR new];
        modelR.couponId = self.couponId;
        modelR.page = [NSString stringWithFormat:@"%ld",(long)self.curPage];
        modelR.pageSize = @"10";
        if(mapInfoModel == nil){
            modelR.lng = @"120.730435";
            modelR.lat = @"31.273391";
        }else{
            modelR.lng = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.longitude];
            modelR.lat = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.latitude];
        }
        if(_viewType == Enum_CouponCenter){
            modelR.city=[QWGLOBALMANAGER getMapInfoModel].branchCityName;
        }
        [Coupon getNewCouponPharmacy:modelR success:^(id obj) {
            
            CouponBranchVoListModel *couponPharModel = (CouponBranchVoListModel *)obj;
            
            if(couponPharModel.suitableBranchs.count>0){
                [self.dataArray addObjectsFromArray:couponPharModel.suitableBranchs];
                [self.bpTableView reloadData];
                self.curPage++;
            }else{
                self.bpTableView.footer.canLoadMore=NO;
            }
            [self.bpTableView footerEndRefreshing]; 
        } failure:^(HttpException *e) {
            [self.bpTableView reloadData];
            self.bpTableView.footer.canLoadMore=NO;
            [self.bpTableView footerEndRefreshing];
        }];
    }];
    
}

//领取优惠的按钮
- (void)confirmAction{
    if(_viewType == Enum_CouponCenter){
        if(self.dismissCallback){
            self.dismissCallback(nil,@"1");
        }
    }else if(_viewType == Enum_CouponDetail){
    //无按钮
    }
    [self hideView];
    
}

- (void)hideView{

    [UIView animateWithDuration:0.5 animations:^{
        
        self.backView.alpha = 0.0f;
        CGRect rect = self.mainView.frame;
        rect.origin.y = APP_H + 20;
        self.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_viewType == Enum_CouponCenter){
        return [otherPharmcyTableViewCell getCellHeight:nil];
    }else if(_viewType == Enum_CouponDetail){
        return [otherPharmcyTableViewCell getCellHeight:nil];
    }
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_viewType == Enum_CouponCenter){
        otherPharmcyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
        CouponBranchVoModel *VO = _dataArray[indexPath.row];
        [cell setCell:VO];
        return cell;
    }else  if(_viewType == Enum_CouponDetail){
        otherPharmcyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
        CouponBranchVoModel *VO = _dataArray[indexPath.row];
        [cell setMyCell:VO];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.dismissCallback){
        self.dismissCallback(self.dataArray[indexPath.row],@"0");
    }
    [self hideView];
}

@end
