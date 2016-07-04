//
//  CouponPromotionTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"

@protocol expandDelegate <NSObject>

-(void)expandCell:(NSIndexPath *)typeCell;

@end


@interface MutableActivityPromotionTableViewCell : QWBaseCell

@property (weak, nonatomic) IBOutlet UIImageView *doteline;

@property (weak, nonatomic) IBOutlet UIImageView *ImagUrl;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *spec;

@property (weak, nonatomic) IBOutlet UIImageView *discount;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *special;
@property (weak, nonatomic) IBOutlet UILabel *specialLabel;
@property (weak, nonatomic) IBOutlet UIImageView *voucher;
@property (weak, nonatomic) IBOutlet UILabel *voucherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gift;
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *UpDownImg;
@property (weak, nonatomic) IBOutlet UIButton *spreadBtn;

@property (nonatomic,strong)  NSIndexPath *selectedCell;

@property(nonatomic,assign)id<expandDelegate> expandDele;


//+(float)getStoreCellHeight:(id)data;

- (void)setupCell:(id)data;

//- (void)setstoreCell:(id)data;
@end
