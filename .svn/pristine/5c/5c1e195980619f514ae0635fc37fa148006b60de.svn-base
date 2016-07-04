//
//  BranchPromotionView.h
//  APP
//
//  Created by 李坚 on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coupon.h"
#import "LoginViewController.h"
typedef void (^disMissCallback) (CouponBranchVoModel *obj,NSString *type);//type:0是没有类型区分 1 是领取优惠券

typedef enum BranchCouponDetailViewType{
    Enum_CouponDetail = 0, //我的优惠券详情
    Enum_CouponCenter = 1, //领券中心优惠券详情
    
}BranchCouponDetailViewType;

@interface BranchCouponDetailView : UIView<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UITableView *bpTableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCoupon;
@property (weak, nonatomic) IBOutlet UILabel *lblRemindNum;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footviewheight;

@property (nonatomic, strong) NSMutableArray  *dataArray;//传进来的叠加重新请求的
@property (nonatomic, assign) NSInteger curPage;//当前的分页
@property (nonatomic, strong) NSString  *couponId;//优惠券的Id
@property (nonatomic, assign) BranchCouponDetailViewType viewType;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainConstant;

@property (copy,nonatomic) disMissCallback dismissCallback;

+ (BranchCouponDetailView *)showInView:(UIWindow *)blackView withTitle:(NSString *)title model:(OnlineCouponDetailVo *)message list:(NSArray *)dataArr withSelectedIndex:(NSInteger)index  withType:(BranchCouponDetailViewType)type andCallBack:(disMissCallback)callBack;
+ (BranchCouponDetailView *)showMyInView:(UIWindow *)blackView withTitle:(NSString *)title model:(MyCouponDetailVo *)message list:(NSArray *)dataArr withSelectedIndex:(NSInteger)index  withType:(BranchCouponDetailViewType)type andCallBack:(disMissCallback)callBack;
- (void)hideView;

@end
