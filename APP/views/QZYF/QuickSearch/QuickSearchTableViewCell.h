//
//  QuickSearchTableViewCell.h
//  APP
//
//  Created by garfield on 15/10/8.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"

@interface QuickSearchTableViewCell : QWBaseCell

@property (nonatomic, strong) IBOutlet UIImageView   *avatarImage;
@property (nonatomic, strong) IBOutlet UILabel       *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel       *subTitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView   *IconImage;

@end
