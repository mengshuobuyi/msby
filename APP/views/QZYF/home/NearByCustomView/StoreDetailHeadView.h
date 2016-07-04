//
//  StoreDetailHeadView.h
//  APP
//
//  Created by Meng on 15/6/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWRatingView.h"
#import "MLEmojiLabel.h"
@interface StoreDetailHeadView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewWidth;

@property (weak, nonatomic) IBOutlet UIImageView *VImage;

@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;


@property (weak, nonatomic) IBOutlet QWRatingView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;


@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;


- (void)layoutTagsWith:(NSArray *)tagArray;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

//add by lijian
- (void)UITags:(NSArray *)tags;

@end
