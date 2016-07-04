//
//  MedicineListCell.h
//  wenyao
//
//  Created by Meng on 14-9-28.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"
@interface MedicineListCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specWidthLayout;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet QWLabel *proName;


@property (weak, nonatomic) IBOutlet QWLabel *spec;


@property (weak, nonatomic) IBOutlet QWLabel *factory;


@property (weak, nonatomic) IBOutlet QWLabel *tagLabel;
@property (weak, nonatomic) IBOutlet QWImageView *coupnFlag;

@property (weak, nonatomic) IBOutlet UIImageView *giftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foldLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pledgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *specialLabel;





+ (CGFloat)getCellHeight:(id)data;
- (void)setSenaioCell:(id)data;
- (void)setCouponCell:(id)data;
- (void)setMyFavCell:(id)data;
- (void)setSearchCell:(id)data;
//组方
- (void)setFoumalCell:(id)data;
- (void)setFactoryProductCell:(id)data;
@end
