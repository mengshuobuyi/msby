//
//  MallBranchTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/6/17.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "ConsultStoreModel.h"

@interface MallBranchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet RatingView *ratView;
@property (weak, nonatomic) IBOutlet UIView *serviceLabel;

+ (CGFloat)getCellHeight:(id)data;
- (void)setCell:(MicroMallBranchVo *)model;

@end
