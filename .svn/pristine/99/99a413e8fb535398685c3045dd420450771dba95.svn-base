//
//  NewUserCenterHeaderView.m
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewUserCenterHeaderView.h"
#import "QWGlobalManager.h"
#import "UIImageView+WebCache.h"
@implementation HeaderViewModel
@end
@implementation NewUserCenterHeaderView
-(void)awakeFromNib {
    self.nickImg.layer.cornerRadius = 40.0;
    self.nickImg.clipsToBounds = YES;
    self.unDoneLabel.layer.cornerRadius = 8;
    self.unDoneLabel.layer.borderWidth = 1;
    self.unDoneLabel.layer.borderColor = RGBHex(qwColor3).CGColor;
    self.unDoneLabel.layer.masksToBounds = YES;
    self.unEvLabel.layer.cornerRadius = 8;
    self.unEvLabel.layer.borderWidth = 1;
    self.unEvLabel.layer.masksToBounds = YES;
    self.unEvLabel.layer.borderColor = RGBHex(qwColor3).CGColor;
    //设置未登录情况下的顶部
    [self setUnloginView];
}

-(void)setUnloginView {
    if(!QWGLOBALMANAGER.loginStatus){
        _loginBeforeView.hidden = NO;
    }else {
        _loginBeforeView.hidden = YES;
        [self.nickImg setImageWithURL:[NSURL URLWithString:QWGLOBALMANAGER.configure.avatarUrl] placeholderImage:[UIImage imageNamed:@"ic_my_pepole"] options:SDWebImageRetryFailed];

        [self jugeName:QWGLOBALMANAGER.configure.nickName tel:QWGLOBALMANAGER.configure.mobile userName:QWGLOBALMANAGER.configure.userName];
    }
}
//显示用户名
-(void)jugeName:(NSString *)nickName tel:(NSString *)tel userName:(NSString *)userName {
    if (nickName.length != 0) {
        _nickName.text = nickName;
    }else if (tel.length != 0) {
        _nickName.text = tel;
    }else {
        if (userName.length != 0) {
            _nickName.text = userName;
        }
    }
}
//移除视图上的手势
-(void)removeGes:(UIView *)view {
    for (UIGestureRecognizer *ges in [view gestureRecognizers]) {
        [view removeGestureRecognizer:ges];
    }
}

-(void)setView:(mbrMemberInfo *)info {
    [self removeGes:_loginBeforeView];
    [self removeGes:_loginAfterView];
    [_allOrdersBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_unDoneOrdersBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_unEvaOrdersBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_signBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_levelBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    if (QWGLOBALMANAGER.loginStatus) {
        _loginBeforeView.hidden = YES;
        [_nickImg setImageWithURL:[NSURL URLWithString:info.headImageUrl] placeholderImage:[UIImage imageNamed:@"ic_my_pepole"]];
        _lvlLabel.text = [NSString stringWithFormat:@"%@会员",info.level];
        [self jugeName:info.nickName tel:info.mobile userName:QWGLOBALMANAGER.configure.userName];        
        if (info.sign) {
            [self.signBtn setBackgroundImage:[UIImage imageNamed:@"ic_my_signback2"] forState:UIControlStateNormal];
        }else {
            [self.signBtn setBackgroundImage:[UIImage imageNamed:@"ic_my_signback"] forState:UIControlStateNormal];
        }
        //未完成订单和待评价订单角标显示
        if(info.unCompleteOrdCounts > 0){
            self.unDoneLabel.hidden = NO;
            self.unDoneLabel.text = [NSString stringWithFormat:@"%li",(long)info.unCompleteOrdCounts];
        }else {
            self.unDoneLabel.hidden = YES;
        }
        if(info.unEvaluateOrdCounts > 0){
            self.unEvLabel.hidden = NO;
            self.unEvLabel.text = [NSString stringWithFormat:@"%li",(long)info.unEvaluateOrdCounts];
        }else {
            self.unEvLabel.hidden = YES;
        }
    }else {
        _loginBeforeView.hidden = NO;
        self.unDoneLabel.hidden = YES;
        self.unEvLabel.hidden = YES;
    }
}


-(void)setHeaderView:(CurrentCityStatus)status {
    HeaderViewModel *model1 = [HeaderViewModel new];
    HeaderViewModel *model2 = [HeaderViewModel new];
    HeaderViewModel *model3 = [HeaderViewModel new];
    switch (status) {
        case CurrentCityStatusUnopenWechatBussness:
            [_unDoneLabel removeFromSuperview];
            [_unEvLabel removeFromSuperview];
            model1.img = @"ic_my_follow";
            model1.title = @"关注的圈子";
            model2.img = @"ic_my_expert";
            model2.title = @"关注的专家";
            model3.img = @"ic_my_collection";
            model3.title = @"关注的收藏";
            break;
            
        case CurrentCityStatusOpenWeChatBussness:
            model1.img = @"icon_all_personal";
            model1.title = @"全部订单";
            model2.img = @"icon_unfinished_personal";
            model2.title = @"未完成";
            model3.img = @"icon_evaluation_personal";
            model3.title = @"待评价";
            break;
    }
    [self setBussnessBtn:@[model1,model2,model3]];
}

-(void)setBussnessBtn:(NSArray *)modelArray {
    for (NSInteger idx = 0; idx < modelArray.count; idx ++) {
        HeaderViewModel *model = modelArray[idx];
        UIImageView *imgView = _imgs[idx];
        UILabel *label = _titles[idx];
        label.text = model.title;
        imgView.image = [UIImage imageNamed:model.img];
    }
}
@end
