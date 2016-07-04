//
//  OnlinePayTikTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlinePayTikTableViewCell : UITableViewCell

+ (CGFloat)getCellHeight;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LabelLeftConstant;

@end
