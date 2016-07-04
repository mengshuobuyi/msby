//
//  ShoppingCartTableViewCell.h
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"

typedef NS_ENUM(NSInteger,ShoppingProductPromotion) {
    ProductShowInsufficient,
    ProductShowPresentGift,
    ProductNotShowPresentGift,
    ProductShowDiscount,
    ProductNotShowDiscount,
    ProductNotShowMinus,
    ProductShowMinus,
    ProductShowNotShowSpecialoffer,
    ProductShowSpecialoffer,
    ProductShowNotGrabActivity,
    ProductShowGrabActivity,
};


@interface ShoppingCartTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productNum;
@property (weak, nonatomic) IBOutlet QWButton *decreaseButton;
@property (weak, nonatomic) IBOutlet QWButton *increaseButton;

@property (weak, nonatomic) IBOutlet QWButton *decreaseBigButton;
@property (weak, nonatomic) IBOutlet QWButton *increaseBigButton;

@property (weak, nonatomic) IBOutlet QWButton *chooseButton;
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UILabel *insufficientLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *knockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *promotionIcon;
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;
@property (weak, nonatomic) IBOutlet UIView *topColorCover;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;

@property (weak, nonatomic) IBOutlet UITextField *ProNumText;

- (void)associateWithModel:(id)model
                    target:(id)target
                 indexPath:(NSIndexPath *)indexPath;

@end
