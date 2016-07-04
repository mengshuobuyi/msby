//
//  SplashVIew.m
//  APP
//
//  Created by 李坚 on 15/9/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "SplashView.h"
@implementation SplashView

+ (SplashView *)showSplashViewAtWindow:(UIWindow *)window WithBlock:(jumpBlock)callBack{
    
    [QWGLOBALMANAGER statisticsEventId:@"x_qdy_cx" withLable:@"启动页-出现" withParams:nil];
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SplashView" owner:nil options:nil];
    
    SplashView *splashView = [nibView objectAtIndex:0];
    splashView.jump = callBack;
    splashView.frame = CGRectMake(0, 0, APP_W, APP_H + 20);
    splashView.tag = 1001;
    [window addSubview:splashView];
    
    return splashView;
}



- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
    
    
    self.SplashImage = [[UIImageView alloc]init];
    CGRect rect = self.SplashImage.frame;
    rect.origin.x = 0.0f;
    rect.origin.y = 0.0f;
    rect.size.width = APP_W;
    rect.size.height = APP_H + 20;
    self.SplashImage.frame = rect;
    [self addSubview:self.SplashImage];
    
    self.jumpView = [[UIView alloc]init];
    CGRect rec = self.jumpView.frame;
    rec.origin.x = APP_W - 51.0f;
    rec.origin.y = 25.0f;
    rec.size.width = 36;
    rec.size.height = 36;
    self.jumpView.frame = rec;
    self.jumpView.backgroundColor = [UIColor blackColor];
    self.jumpView.alpha = 0.4f;
    self.jumpView.layer.masksToBounds = YES;
    self.jumpView.layer.cornerRadius = 18.0f;
    [self addSubview:self.jumpView];
    
    UILabel *jumpLabel = [[UILabel alloc]init];
    jumpLabel.frame = CGRectMake(0, 3, 36, 18);
    jumpLabel.text = @"跳过";
    jumpLabel.textAlignment = NSTextAlignmentCenter;
    jumpLabel.textColor = [UIColor whiteColor];
    jumpLabel.font = fontSystem(11.0f);
    [self.jumpView addSubview:jumpLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.frame = CGRectMake(0, 16, 36, 18);
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = fontSystem(9.0f);
    [self.jumpView addSubview:self.timeLabel];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(jumpDisMiss) forControlEvents:UIControlEventTouchUpInside];
    [self.jumpView addSubview:btn];
    
    UIImageView *bottomImage = [[UIImageView alloc]init];
    
    if (IS_IPHONE_6P || IS_IPHONE_6){
        bottomImage.frame = CGRectMake(0, rect.size.height - 108.5, APP_W, 108.5);
    }else{
        bottomImage.frame = CGRectMake(0, rect.size.height - 65.5, APP_W, 65.5);
    }
    bottomImage.contentMode = UIViewContentModeScaleAspectFill;
    bottomImage.image = [UIImage imageNamed:@"home_img_1"];
    [self addSubview:bottomImage];
    
    _count = [QWUserDefault getDoubleBy:APP_LAUNCH_DURATION];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d秒",(int)_count];
    UIImage* image = [QWUserDefault getObjectBy:APP_LAUNCH_IMAGE];
    
    self.SplashImage.backgroundColor = [UIColor greenColor];
    
    if (image) {
        
        [self.SplashImage setImage:image];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddeView:)];
        [self addGestureRecognizer:tap];
        
    }else{
        [self.SplashImage setImage:[UIImage imageNamed:@"启动页960"]];
    }
    
    if([QWUserDefault getDoubleBy:APP_LAUNCH_DURATION] <= 1.00 || [QWUserDefault getObjectBy:APP_LAUNCH_IMAGE] == nil){
        
        [self performSelector:@selector(dismissTimer) withObject:nil afterDelay:1.0f];
        
    }else{
        
        timer = [NSTimer timerWithTimeInterval:1.0  target:self selector:@selector(dismissTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    
}

- (void)hiddeView:(UITapGestureRecognizer *)tap{
    NSString *url = [QWUserDefault getStringBy:APP_LAUNCH_URL];
    //if(url && ![url isEqualToString:@""]){
    if(!StrIsEmpty(url)){
        if (self.jump) {
            
            [self removeFromSuperview];
            [timer invalidate];
            self.jump();
        }
    }
}

- (void)jumpDisMiss{
    [QWGLOBALMANAGER statisticsEventId:@"x_qdy_tg" withLable:@"启动页-跳过" withParams:nil];
    [self removeView];
}

- (void)dismissTimer{
    
    if(_count == 0){
        [self removeView];
    }
    else
    {
        self.timeLabel.text = [NSString stringWithFormat:@"%d秒",(int)_count];
    }
    
    _count --;
}

- (void)removeView{
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.alpha = 0.0f;
        [timer invalidate];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if([[userDefault objectForKey:@"showGuide"] boolValue] == NO) {
            [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"showGuide"];
            [userDefault synchronize];
            [QWGLOBALMANAGER postNotif:NotifAppCheckVersion data:nil object:self];
        }
        [QWGLOBALMANAGER postNotif:NotiMessageOPLaunchingScreenDisappear data:nil object:nil];
    }];
}

@end

