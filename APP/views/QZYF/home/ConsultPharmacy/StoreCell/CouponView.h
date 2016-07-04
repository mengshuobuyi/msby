//
//  CouponView.h
//  APP
//
//  Created by 李坚 on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CouponViewDelegate <NSObject>

- (void)didSelectedAtIndex:(NSInteger)index;

@end

@interface CouponView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *giftImage;
@property (weak, nonatomic) IBOutlet UILabel *couponValue;
@property (weak, nonatomic) IBOutlet UILabel *couponTag;
@property (weak, nonatomic) IBOutlet UILabel *couponMark;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@property (nonatomic, assign) id<CouponViewDelegate>delegate;

@end
