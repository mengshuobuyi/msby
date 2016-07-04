//
//  PackageScrollView.h
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"
#import "ConsultStoreModel.h"

@class PackageScrollView;
@protocol PackageScrollViewDelegate <NSObject>

@optional
- (void)didSelectedPackageView:(PackageScrollView *)packageView withBranchProId:(NSString *)branchProId;

@end

@interface PackageScrollView : UIView<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>{
    int drugCount;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currViewWidthConstant;
@property (weak, nonatomic) IBOutlet UIView *priceOutView;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIView *currPageView;
@property (weak, nonatomic) IBOutlet UIView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *priceView;

@property (assign, nonatomic) id<PackageScrollViewDelegate>delegate;

@property (strong, nonatomic) XLCycleScrollView *cycleScroll;

@property (nonatomic, strong) ComboVo *combo;
- (void)reloadData;
- (void)initCycleScrollView;
@end
