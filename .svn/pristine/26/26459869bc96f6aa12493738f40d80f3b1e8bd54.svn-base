//
//  APPCommentAlert.m
//  APP
//
//  Created by Yan Qingyang on 15/8/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWGlobalManager.h"

static CGFloat kDur= .25;
#import "APPCommentAlert.h"
@interface APPCommentAlert()
{
    IBOutlet UIButton *btnOK,*btnNO;
//    IBOutlet UIView *vShow;
//    UIAlertView *alert;
}
@end
@implementation APPCommentAlert

+(id)instance
{
    static id sharedInstance;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"APPCommentAlert" owner:nil options:nil];
        sharedInstance = [nibView objectAtIndex:0];
    });
    
    return sharedInstance;
}

- (void)UIGlobal{
    [super UIGlobal];
    vBG.layer.cornerRadius=AutoValue(4);
    vBG.clipsToBounds=YES;
}

//添加自己的view层
- (void)addToWindow{
    [super addToWindow];
//    UIWindow *win=[UIApplication sharedApplication].keyWindow;
//    CGRect frm=win.bounds;
//    self.frame=frm;
//    [win addSubview:self];
//    [win bringSubviewToFront:self];
    
    
//    vBG.layer.cornerRadius=4;
    
   
    btnOK.layer.cornerRadius = 3;
    btnOK.layer.borderWidth = 1;
    btnOK.layer.borderColor=RGBHex(qwColor2).CGColor;
    
    btnNO.layer.cornerRadius = 3;
    btnNO.layer.borderWidth = 1;
    btnNO.layer.borderColor=RGBHex(qwColor2).CGColor;
    
    [btnOK setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [btnOK setTitleColor:RGBHex(qwColor2) forState:UIControlStateHighlighted];
    [btnOK setBackgroundImage:[self imageWithColor:RGBHex(qwColor2)] forState:UIControlStateNormal];
    [btnOK setBackgroundImage:[self imageWithColor:RGBHex(qwColor4)] forState:UIControlStateHighlighted];
    btnOK.clipsToBounds   = YES;
    
    [btnNO setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    [btnNO setTitleColor:RGBHex(qwColor4) forState:UIControlStateHighlighted];
    [btnNO setBackgroundImage:[self imageWithColor:RGBHex(qwColor4)] forState:UIControlStateNormal];
    [btnNO setBackgroundImage:[self imageWithColor:RGBHex(qwColor2)] forState:UIControlStateHighlighted];
    btnNO.clipsToBounds   = YES;
}



- (void)close{
    [UIView animateWithDuration:kDur animations:^{
//        self.backgroundColor=RGBAHex(kColor1, 0);
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



- (IBAction)closeAction:(id)sender{
    [self removeAlert];
    
    [QWGLOBALMANAGER appCommentClick];
    
    [self close];
}

- (IBAction)commentAction:(id)sender{
    [self removeAlert];
    
    [QWGLOBALMANAGER appCommentClick];
    
    [self removeFromSuperview];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/wen-yao-bi-yi-sheng-geng-dong/id901262090?mt=8"]];
}


@end
