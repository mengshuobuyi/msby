//
//  CouponProductCell.h
//  APP
//
//  Created by garfield on 16/6/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseCell.h"

@interface CouponProductCell : QWBaseCell

@property (nonatomic, strong) IBOutlet UILabel          *couponProductLabel;
@property (nonatomic, strong) IBOutlet QWButton         *moreButton;
@property (nonatomic, strong) IBOutlet UIImageView      *couponOneImageView;
@property (nonatomic, strong) IBOutlet UILabel          *couponOneNameLabel;
@property (nonatomic, strong) IBOutlet UILabel          *couponOneSpecLabel;
@property (nonatomic, strong) IBOutlet UIImageView      *couponOneLogo;
@property (nonatomic, strong) IBOutlet UILabel          *couponOneSalePriceLabel;
@property (nonatomic, strong) IBOutlet UILabel          *couponOneOriginPriceLabel;

@property (nonatomic, strong) IBOutlet UIImageView      *couponTwoImageView;
@property (nonatomic, strong) IBOutlet UILabel          *couponTwoNameLabel;
@property (nonatomic, strong) IBOutlet UILabel          *couponTwoSpecLabel;
@property (nonatomic, strong) IBOutlet UIImageView      *couponTwoLogo;
@property (nonatomic, strong) IBOutlet UILabel          *couponTwoSalePriceLabel;
@property (nonatomic, strong) IBOutlet UILabel          *couponTwoOriginPriceLabel;

@property (nonatomic, strong) IBOutlet UIView           *containerOne;
@property (nonatomic, strong) IBOutlet UIView           *containerTwo;

@property (nonatomic, strong) IBOutlet QWButton           *buttonBackgroundOne;
@property (nonatomic, strong) IBOutlet QWButton           *buttonBackgroundTwo;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerSepator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *container2Sepator;

- (void)setCouponProductCell:(id)data;
- (void)setOtherProductCell:(id)data;

@end