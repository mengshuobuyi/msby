//
//  LevelUpAlertView.h
//  APP
//
//  Created by qw_imac on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LevelUpModel:NSObject
@property (nonatomic,assign)NSInteger level;
@property (nonatomic,assign)NSInteger integral;
@end


@interface LevelUpAlertView : UIView
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (strong, nonatomic) IBOutlet UIView *bkView;
@property (strong, nonatomic) IBOutlet UIButton *btn;

+(LevelUpAlertView *)levelUpAlertViewWith:(LevelUpModel *)model;
@end
