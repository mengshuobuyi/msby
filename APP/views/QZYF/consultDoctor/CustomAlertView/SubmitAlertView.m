//
//  SubmitAlertView.m
//  APP
//
//  Created by PerryChen on 8/25/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "SubmitAlertView.h"
#import "QWGlobalManager.h"
static CGFloat kDur= .25;
@interface SubmitAlertView()
{
    IBOutlet UIButton *btnFillup,*btnSubmit;
    IBOutlet UIView *vShow;
}

@end
@implementation SubmitAlertView
+(id)instance
{
    static id sharedInstance;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SubmitAlertView" owner:nil options:nil];
        sharedInstance = [nibView objectAtIndex:0];
    });
    
    return sharedInstance;
}

//- (void)show{
//    [super show];
//    
//    
//    self.backgroundColor=RGBAHex(kColor1, 0);
//    vShow.alpha=0;
//    [UIView animateWithDuration:kDur animations:^{
//        
//        vShow.alpha=1;
//    } completion:^(BOOL finished) {
//        
//    }];
//}

//添加自己的view层
- (void)addToWindow{
        [super addToWindow];
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
//    CGRect frm=win.bounds;
//    self.frame=frm;
//    [win addSubview:self];
//    [win bringSubviewToFront:self];
    
    
    vShow.layer.cornerRadius=4;
    
    
    btnFillup.layer.cornerRadius = 3;
    btnFillup.layer.borderWidth = 1;
    btnFillup.layer.borderColor=RGBHex(qwColor2).CGColor;
    
    btnSubmit.layer.cornerRadius = 3;
    btnSubmit.layer.borderWidth = 1;
    btnSubmit.layer.borderColor=RGBHex(qwColor2).CGColor;
    
//    [btnOK setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
//    [btnOK setTitleColor:RGBHex(qwColor2) forState:UIControlStateHighlighted];
    [btnFillup setBackgroundImage:[self imageWithColor:RGBHex(qwColor2)] forState:UIControlStateNormal];
    [btnFillup setBackgroundImage:[self imageWithColor:RGBHex(qwColor4)] forState:UIControlStateHighlighted];
    btnFillup.clipsToBounds   = YES;
    
//    [btnNO setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
//    [btnNO setTitleColor:RGBHex(qwColor4) forState:UIControlStateHighlighted];
    [btnSubmit setBackgroundImage:[self imageWithColor:RGBHex(qwColor4)] forState:UIControlStateNormal];
    [btnSubmit setBackgroundImage:[self imageWithColor:RGBHex(qwColor2)] forState:UIControlStateHighlighted];
    btnSubmit.clipsToBounds   = YES;
}

- (void)close{
    [UIView animateWithDuration:kDur animations:^{
//        self.backgroundColor=RGBAHex(kColor1, 0);
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



- (IBAction)fillupAction:(id)sender{
    [self removeAlert];
    
//    [QWGLOBALMANAGER appCommentClick];
    if ([self.alertDelegate respondsToSelector:@selector(actionFillup)]) {
        [self.alertDelegate actionFillup];
    }
    [self close];
}

- (IBAction)submitAction:(id)sender{
    [self removeAlert];
    if ([self.alertDelegate respondsToSelector:@selector(actionSubmit)]) {
        [self.alertDelegate actionSubmit];
    }
//    [QWGLOBALMANAGER appCommentClick];
    
    [self removeFromSuperview];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/wen-yao-bi-yi-sheng-geng-dong/id901262090?mt=8"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
