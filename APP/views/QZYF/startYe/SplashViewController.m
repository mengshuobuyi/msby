//
//  SplashViewController.m
//  APP
//
//  Created by qw on 15/9/2.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "SplashViewController.h"

@implementation SplashViewController

+ (SplashViewController *)showSplashViewAtWindow:(UIWindow *)window WithBlock:(jumpBlock)callBack WithDismissBlock:(jumpBlock)callBackDismiss{
    
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SplashViewController" owner:nil options:nil];
    SplashViewController *splashView = [nibView objectAtIndex:0];
    splashView.jump = callBack;
    splashView.dismissJump = callBackDismiss;
    splashView.frame = CGRectMake(0, 0, APP_W, APP_H + 20);
    splashView.tag = 1008;
    
    [window addSubview:splashView];
    
    return splashView;
}


- (void)awakeFromNib{
    
    self.jumpView.layer.masksToBounds = YES;
    self.jumpView.layer.cornerRadius = 25.0f;

    _count = [QWUserDefault getDoubleBy:APP_LAUNCH_DURATION];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d秒",(int)_count];
    
    UIImage* image = [QWUserDefault getObjectBy:APP_LAUNCH_IMAGE];
    if (image) {
        [self.imageSplash setImage:image];
        self.imageSplash.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddeView:)];
      
        [self addGestureRecognizer:tap];
    }
    else
    {
        [self.imageSplash setImage:[UIImage imageNamed:@"启动页960"]];
    }
    
    if([QWUserDefault getDoubleBy:APP_LAUNCH_DURATION] <= 1.00 || [QWUserDefault getObjectBy:APP_LAUNCH_IMAGE] == nil){
        
        [self performSelector:@selector(doJump:) withObject:nil afterDelay:1.0f];
    }else{
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissTimer) userInfo:nil repeats:YES];
    }

}


//引导页消息
- (void)dismissTimer
{
    _count--;
    self.timeLabel.text = [NSString stringWithFormat:@"%d秒",(int)_count];
    
    if (_count == 0) {
        [UIView animateWithDuration:0.6 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (self.dismissJump) {
                self.dismissJump();
            }
            [self removeFromSuperview];
        }];
    }
}

//跳转到外链事件
- (void)hiddeView:(UITapGestureRecognizer *)tap
{
    NSString *url = [QWUserDefault getStringBy:APP_LAUNCH_URL];
    if(url && ![url isEqualToString:@""]){
        if (self.jump) {
            [self removeFromSuperview];
            self.jump();
            
        }
    }
}

//按钮跳转到首页事件
- (IBAction)doJump:(id)sender {
    
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.dismissJump) {
            self.dismissJump();
        }
        [self removeFromSuperview];
    }];
    
}

@end
