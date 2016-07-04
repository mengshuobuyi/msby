//
//  UsePromotionSuccessViewController.m
//  APP
//
//  Created by 李坚 on 15/8/26.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "UsePromotionSuccessViewController.h"
#import "RatingView.h"
#import "EvaluatingPromotionViewController.h"
#import "MyCouponDrugViewController.h"
#import "PromotionCustomAlertView.h"
#import "GiftVoucherAlertView.h"
#import "CouponModel.h"
#import "MyCouponQuanViewController.h"
#import "MyCouponDrugViewController.h"
#import "WebDirectViewController.h"

@interface UsePromotionSuccessViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *label;
//@property (weak, nonatomic) IBOutlet RatingView *starView;
//@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation UsePromotionSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [QWGLOBALMANAGER appUseGoods];//成功使用过一次优惠商品
    self.title = @"使用成功";
    self.view.backgroundColor=[UIColor whiteColor];
//    self.starView.userInteractionEnabled = YES;
//    [self.starView setImagesDeselected:@"star_none_big" partlySelected:@"star_half_big" fullSelected:@"star_full_big" andDelegate:nil];
//    self.starView.viewDelegate = self;
//    
//    if([self isEmpty:self.checkModel.branchName] || [self isEmpty:self.checkModel.proName]){
//        
//        self.label.text = @"";
//    }else{
//        
//        self.label.text = [NSString stringWithFormat:@"您已成功使用优惠，购买%d件%@",[self.checkModel.quantity intValue],self.checkModel.proName];
//    }
//
//    if(self.checkModel.gifts && self.checkModel.gifts.count != 0){
//        [self performSelector:@selector(showGiftAlertView) withObject:nil afterDelay:1.0];
//    }else{
//        [self performSelector:@selector(showShareAlertView) withObject:nil afterDelay:1.0];
//    }
//    //设置赠送Button的UI
//    [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    if(self.checkModel && self.checkModel.presentType && ![self.checkModel.presentType isEqualToString:@""]){
//        
//        if([self.checkModel.presentType isEqualToString:@"Q"]){
//            //送优惠券
//            self.btn.hidden = NO;
//            [self.btn setTitle:@"问药君送您一张优惠券哟，快来查看吧" forState:UIControlStateNormal];
//        }
//        if([self.checkModel.presentType isEqualToString:@"P"]){
//            //送优惠商品
//            self.btn.hidden = NO;
//            [self.btn setTitle:@"问药君送您一份优惠商品哟，快来查看吧" forState:UIControlStateNormal];
//        }
//    }else{
//        self.btn.hidden = YES;
//    }
    
}

//#pragma mark - 赠送券Btn点击事件
//- (void)btnClick{
//    
//    if([self.checkModel.presentType isEqualToString:@"Q"] && self.checkModel.presentCoupons.count >0){
//        
//        //跳转我的优惠券
//        MyCouponQuanViewController *VC = [[MyCouponQuanViewController alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }
//    if([self.checkModel.presentType isEqualToString:@"P"] && self.checkModel.presentPromotions.count >0){
//
//        //跳转我的优惠商品
//        MyCouponDrugViewController *VC = [[MyCouponDrugViewController alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }
//}
//
//
//- (BOOL)isEmpty:(NSString *)str{
//    if(StrIsEmpty(str)){
//        return YES;
//    }else{
//        return NO;
//    }
//}
//
//
//#pragma mark - 大礼包Alert
//- (void)showGiftAlertView{
//    
//    CouponGiftVoModel *model = self.checkModel.gifts[0];
//    
//    [GiftVoucherAlertView showAlertViewAtView:self.view withVoucher:model.name andCount:[model.quantity integerValue] andImageName:model.imgUrl callBack:^(id obj) {
//        
//        [self showShareAlertView];
//        
//    }];
//}
//
//#pragma mark - 分享Alert
//- (void)showShareAlertView{
//
//    
//    [PromotionCustomAlertView showCustomAlertViewAtView:self.view withTitle:@"分享给小伙伴，大家一起抢优惠！" andCancelButton:@"挥泪放弃" andConfirmButton:@"分享" highLight:YES showImage:YES andCallback:^(NSInteger obj) {
//        if(obj == 1){
//            //点击分享  由原来的使用后的分享大礼包更改为使用前的分享优惠券  cj
//            ShareContentModel *modelShare = [[ShareContentModel alloc] init];
//            modelShare.typeShare    = ShareTypeMyDrug;
//            NSArray *arrParams      = @[self.checkModel.proId ,self.checkModel.pid];
//            modelShare.shareID      = modelShare.shareID = [arrParams componentsJoinedByString:SeparateStr];
//            modelShare.title        = self.checkModel.promotionTitle;
//            modelShare.content      = self.checkModel.desc;
//            modelShare.imgURL       = self.checkModel.proImgUrl;
//            
//            ShareSaveLogModel *modelR = [ShareSaveLogModel new];
//            MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
//            if(mapInfoModel) {
//                modelR.city = mapInfoModel.city;
//                modelR.province = mapInfoModel.province;
//            }else{
//                modelR.city = @"苏州市";
//                modelR.province = @"江苏省";
//            }
//            modelR.shareObj = @"2";
//            modelR.shareObjId = self.checkModel.pid;
//            modelShare.modelSavelog = modelR;
//            [self popUpShareView:modelShare];
//        }else{
//            
//        }
//    }];
//}
//
//#pragma mark - RatingViewDelegate
//-(void)ratingChanged:(float)newRating{
//    
//}
//
//- (void)ratingChangeEnded:(float)newRating{
//    
//    EvaluatingPromotionViewController *evaluationPromotionView = [[EvaluatingPromotionViewController alloc]initWithNibName:@"EvaluatingPromotionViewController" bundle:nil];
//    evaluationPromotionView.didPopToRootView = YES;
//    evaluationPromotionView.star = newRating;
//    evaluationPromotionView.orderId = self.orderId;
//    evaluationPromotionView.branchName = self.checkModel.branchName;
//    [self.navigationController pushViewController:evaluationPromotionView animated:YES];
//}
//
#pragma mark - popViewController
- (IBAction)popVCAction:(id)sender{
    
    for(UIViewController *view in self.navigationController.viewControllers){
        if([view isKindOfClass:[MyCouponDrugViewController class]]){
            MyCouponDrugViewController *vc = (MyCouponDrugViewController *)view;
            vc.shouldJump = YES;
            [self.navigationController popToViewController:view animated:YES];
            return;
        }
    }
    MyCouponDrugViewController * myCouponDrug = [[MyCouponDrugViewController alloc]init];
    myCouponDrug.shouldJump = YES;
    [self.navigationController pushViewController:myCouponDrug animated:NO];
}

@end
