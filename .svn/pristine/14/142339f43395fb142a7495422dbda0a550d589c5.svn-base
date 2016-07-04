//
//  LevelUpAlertView.m
//  APP
//
//  Created by qw_imac on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "LevelUpAlertView.h"
@implementation LevelUpModel


@end

@implementation LevelUpAlertView

+(LevelUpAlertView *)levelUpAlertViewWith:(LevelUpModel *)levelUpModel {
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"LevelUpAlertView" owner:nil options:nil];
    LevelUpAlertView *View = (LevelUpAlertView *)[nibView objectAtIndex:0];
   // View.frame = CGRectMake(0, 0, APP_W, APP_H);
    if (levelUpModel.level < 6) {
        View.messageLabel.text = [NSString stringWithFormat:@"恭喜您升至V%d，系统会每月奖励您%d积分，升至V%d，积分会更多哦，赶紧升级吧~",levelUpModel.level,levelUpModel.integral,levelUpModel.level+1];
    }else {
        View.messageLabel.text = [NSString stringWithFormat:@"恭喜您升至V6，系统会每月奖励您200积分!"];
    }
    View.alertView.layer.cornerRadius = 5.0;
    View.btn.layer.cornerRadius = 5.0;
    View.alertView.layer.masksToBounds = YES;
    View.btn.layer.masksToBounds = YES;
    View.frame = CGRectMake(0, 0, APP_W, APP_H);
    
    return View;
}


- (IBAction)dismissFromView:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.bkView.alpha = 0.0;
        self.alpha = 0.0;
        self.alertView.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
