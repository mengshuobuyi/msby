//
//  BaseShoppingCartVC.h
//  APP
//
//  Created by garfield on 16/3/23.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "CombosTopCartTableViewCell.h"
#import "CombosMiddleCartTableViewCell.h"
#import "CombosBottomCartTableViewCell.h"
#import "CombosShowOneCartTableViewCell.h"
#import "RedemptionCartTableViewCell.h"
#import "MallCart.h"

typedef NS_ENUM(NSInteger,ShoppingCartStatus) {
    NormalShoppingCartStatus,
    EmptyShoppingCartStatus,
    NotOpenNoReportedStatus,
    NotOpenReportedStatus
};

static NSString *const CellIdentifier = @"ShoppingCartTableViewCellIdentifier";
static NSString *const CombosTopCartTableViewCellIdentifier = @"CombosTopCartTableViewCellIdentifier";
static NSString *const CombosMiddleCartTableViewCellIdentifier = @"CombosMiddleCartTableViewCellIdentifier";
static NSString *const CombosBottomCartTableViewCellIdentifier = @"CombosBottomCartTableViewCellIdentifier";
static NSString *const CombosShowOneCartTableViewCellIdentifier = @"CombosShowOneCartTableViewCellIdentifier";
static NSString *const RedemptionCartTableViewCellIdentifier = @"RedemptionCartTableViewCellIdentifier";



@interface BaseShoppingCartVC : QWBaseVC

@property (strong, nonatomic) UIView         *backGroundStausView;
@property (nonatomic, strong) UIImageView    *hintImageView;
@property (nonatomic, strong) UILabel           *hintLabel;
@property (nonatomic, strong) UIButton          *hintButton;
@property (nonatomic, strong) NSMutableArray    *shoppingList;
@property (nonatomic, assign) NSInteger         pageType;//区分带返回的跟tab上的
- (UIView *)createDynamicHeaderView:(NSInteger)section;
- (double)calculateTotalPrice:(double *)retMinusPrice;
- (double)calculatePriceOnly:(CartBranchVoModel *)branchModel;
//购物车没数据时,背景状态处理
- (void)showShoppingCartBackgroundStatus:(ShoppingCartStatus)status;
- (void)initializeUI;
- (void)checkBackGroundStatus;
- (void)syncOnlineShoppingCart;
- (NSMutableArray *)sortCombosProdcut:(NSArray *)combos;
//同步未读数
- (void)syncUnreadNum;
- (void)jointProductModel:(NSArray *)productList addArray:(NSMutableArray *)jsonArray;
- (BOOL)checkChooseAll:(CartBranchVoModel *)model;

@end
