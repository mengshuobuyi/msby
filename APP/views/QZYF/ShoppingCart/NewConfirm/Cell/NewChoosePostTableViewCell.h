//
//  NewChoosePostTableViewCell.h
//  APP
//
//  Created by qw_imac on 16/3/28.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallCartModel.h"
typedef NS_ENUM(NSInteger,DeliverType) {
    DeliverTypeQuhuo = 1,
    DeliverTypeSonghuo,
    DeliverTypeKuaidi,
};
@interface NewChoosePostTableViewCell : UITableViewCell
//到店取货
@property (weak, nonatomic) IBOutlet UIView *quhuoView;
@property (weak, nonatomic) IBOutlet UILabel *serveTime;//营业时间
@property (weak, nonatomic) IBOutlet UIButton *quhuoBtn;
@property (weak, nonatomic) IBOutlet UILabel *quhuoType;

//同城快递
@property (weak, nonatomic) IBOutlet UIView *kuaidiView;
@property (weak, nonatomic) IBOutlet UILabel *postFee;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UILabel *manTip;//包邮提示
@property (weak, nonatomic) IBOutlet UILabel *deliverTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *postHeight;
@property (weak, nonatomic) IBOutlet UILabel *postType;

//送货上门
@property (weak, nonatomic) IBOutlet UIView *songhuoView;
@property (weak, nonatomic) IBOutlet UILabel *notManLabel;
@property (weak, nonatomic) IBOutlet UILabel *peisongFe;
@property (weak, nonatomic) IBOutlet UILabel *songhuoTime;
@property (weak, nonatomic) IBOutlet UILabel *songhuoFreeTip;
@property (weak, nonatomic) IBOutlet UIButton *songhuoBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *songhuoHeight;
@property (weak, nonatomic) IBOutlet UILabel *songhuoType;
//蒙层
@property (weak, nonatomic) IBOutlet UIView *cover;
@property (nonatomic,strong) UIButton *btn;
//-(void)setCellWith:(DeliveryTypeVoModel *)model;
-(void)setCell:(DeliveryTypeVoModel *)model with:(BOOL)haveAddress and:(BOOL)chooseSonghuo;

@end
