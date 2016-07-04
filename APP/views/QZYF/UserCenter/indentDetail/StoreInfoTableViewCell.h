//
//  StoreInfoTableViewCell.h
//  APP
//
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *sellTime;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadspace;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
