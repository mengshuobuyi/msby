//
//  NewUserCenterHeaderView.h
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MbrModel.h"
typedef NS_ENUM(NSInteger,CurrentCityStatus) {
    CurrentCityStatusOpenWeChatBussness,
    CurrentCityStatusUnopenWechatBussness,
};

@interface HeaderViewModel : NSObject
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *title;
@end

@interface NewUserCenterHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *loginAfterView;
@property (weak, nonatomic) IBOutlet UIImageView *nickImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;

@property (weak, nonatomic) IBOutlet UIView *loginBeforeView;
@property (weak, nonatomic) IBOutlet UIImageView *nickPlaceHolderImg;
@property (weak, nonatomic) IBOutlet UIButton *levelBtn;

@property (weak, nonatomic) IBOutlet UIButton *allOrdersBtn;
@property (weak, nonatomic) IBOutlet UIButton *unDoneOrdersBtn;
@property (weak, nonatomic) IBOutlet UIButton *unEvaOrdersBtn;

@property (weak, nonatomic) IBOutlet UILabel *unDoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *unEvLabel;
@property (weak, nonatomic) IBOutlet UILabel *lvlLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titles;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgs;

-(void)setView:(mbrMemberInfo *)info;
-(void)setHeaderView:(CurrentCityStatus)status;
@end
