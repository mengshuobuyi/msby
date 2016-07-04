//
//  CustomInfoAlertView.m
//  APP
//
//  Created by PerryChen on 9/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "ChangeStoreAlertView.h"
#import "QWGlobalManager.h"
static CGFloat kDur= .25;
@interface ChangeStoreAlertView()
{
    IBOutlet UIButton *btnCancel;
    IBOutlet UIButton *btnDirect;
    IBOutlet UIView *vShow;
}
@end

@implementation ChangeStoreAlertView
+(id)instance
{
    static id sharedInstance;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ChangeStoreAlertView" owner:nil options:nil];
        sharedInstance = [nibView objectAtIndex:0];
    });
    
    return sharedInstance;
}

//添加自己的view层
- (void)addToWindow{
    [super addToWindow];
    vShow.layer.cornerRadius=8;
}

- (void)close{
    [UIView animateWithDuration:kDur animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (IBAction)actionCancel:(id)sender {
    [self removeAlert];
    if (self.blockCancel != nil) {
        self.blockCancel(YES);
    }
    [self close];
}

- (IBAction)actionDirect:(id)sender {
    [self removeAlert];
    if (self.blockDirect != nil) {
        self.blockDirect(YES);
    }
    [self removeFromSuperview];
}


@end
