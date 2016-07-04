//
//  AppCover.m
//  wenyao-store
//
//  Created by qwyf0006 on 15/2/9.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "AppCover.h"
#import "Constant.h"
#import "AppDelegate.h"

@implementation AppCover

- (id)init
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.8;
        UIImageView *imageView = [[UIImageView alloc] init];
        frame.origin.y += 20;
        frame.size.height -= 20;
        imageView.frame = frame;
        if (HIGH_RESOLUTION) {
            imageView.image = [UIImage imageNamed:@"640-1096(2)"];
        }else
        {
//            imageView.image = [UIImage imageNamed:@"640-920"];
        }
        
        [self addSubview:imageView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"showCover"];
    }];
}

@end
void ShowAppCover()
{
    {
        if (HIGH_RESOLUTION) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            if([[userDefault objectForKey:@"showCover"] boolValue]){
                return;
            }
            AppCover* cover = [[AppCover alloc] init];
            [[UIApplication sharedApplication].keyWindow addSubview:cover];
        }
    }
    
}

