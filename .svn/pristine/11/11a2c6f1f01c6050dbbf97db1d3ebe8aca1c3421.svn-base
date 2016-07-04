//
//  ConsultCouponTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponView.h"
#import "CouponModel.h"
@protocol ConsultCouponTableViewCellDelegate <NSObject>

- (void)didSelectedCouponView:(pharmacyCouponQuan *)obj;

@end


@interface ConsultCouponTableViewCell : UITableViewCell<CouponViewDelegate>{
    
    NSArray *dataArray;
}

@property (assign, nonatomic) id<ConsultCouponTableViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;



- (void)setScrollView:(NSArray *)array;

@end
