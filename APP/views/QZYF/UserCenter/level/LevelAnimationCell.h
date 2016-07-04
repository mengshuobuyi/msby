//
//  LevelAnimationCell.h
//  APP
//
//  Created by qw_imac on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditModel.h"
@interface LevelAnimationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backgroundImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FirstCloudMove;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondCloudMove;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdCloudMove;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *treeGrow;
@property (weak, nonatomic) IBOutlet UIImageView *treeImage;
@property (weak, nonatomic) IBOutlet UIImageView *levelImage;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *treeHeight;

@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *knowBtn;
@property (nonatomic,strong)NSTimer *timer;

-(void)setUiWithVip:(NSInteger)vip;
-(void)setAlertViewWith:(BOOL)isClick;

-(void)setAlertViewWithVo:(MyLevelDetailVo *)vo;
+(CGFloat)cellHeight;
@end
