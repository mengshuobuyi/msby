//
//  PayWayTableViewCell.h
//  APP
//
//  Created by qw_imac on 16/3/26.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UILabel *promotionInfo;
@property (weak, nonatomic) IBOutlet UIButton *choosePromotion;
@property (weak, nonatomic) IBOutlet UIButton *message;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UILabel *messageInfo;
@property (weak, nonatomic) IBOutlet UIImageView *arrRight;

@property (weak, nonatomic) IBOutlet UILabel *faceLabel;
@end
