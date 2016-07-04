//
//  WeiStoreTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "StoreModel.h"
#import "ConsultStoreModel.h"
typedef void (^spellCallback) (NSIndexPath *path);


@interface WeiStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *CouponView;
@property (weak, nonatomic) IBOutlet UIImageView *sepllImage;
@property (weak, nonatomic) IBOutlet UIImageView *VImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgUrlWidthLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstant;

@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet RatingView *ratView;
@property (weak, nonatomic) IBOutlet UIView *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *sepllBtn;

@property (strong, nonatomic) UIView *line;

@property (copy, nonatomic) spellCallback callback;
@property (strong, nonatomic) NSIndexPath *path;

- (IBAction)spellCell:(id)sender;

- (void)setCell:(MicroMallBranchVo *)model withSpell:(spellCallback)callback;
- (void)setNoMiCell:(MicroMallBranchVo *)model withSpell:(spellCallback)callback;

+ (CGFloat)getCellHeight:(MicroMallBranchVo *)sender;

@end
