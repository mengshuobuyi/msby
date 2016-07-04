//
//  BranchPromotionView.h
//  APP
//
//  Created by 李坚 on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^disMissCallback) (NSInteger obj);

typedef enum BranchPromotionViewType{
    Enum_Consult = 0,//附近可售药房
    Enum_Coupon = 1, //商品优惠
    Enum_Change = 2, //换购
    Enum_CouponDetail = 3, //优惠券详情
    
}BranchPromotionViewType;

@interface BranchPromotionView : UIView<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (nonatomic, assign) NSInteger changeGoodNumber;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UITableView *bpTableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *hideBtn;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BranchPromotionViewType viewType;//1.药房 2.优惠

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainConstant;

@property (copy,nonatomic) disMissCallback dismissCallback;

+ (BranchPromotionView *)showInView:(UIWindow *)blackView withTitle:(NSString *)title message:(NSString *)message list:(NSArray *)dataArr withSelectedIndex:(NSInteger)index  withType:(BranchPromotionViewType)type andCallBack:(disMissCallback)callBack;
- (void)hideView;

@end
