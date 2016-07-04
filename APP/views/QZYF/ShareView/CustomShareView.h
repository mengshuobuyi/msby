//
//  CustomShareView.h
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomShareView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnDismissShareView;
@property (weak, nonatomic) IBOutlet UIButton *btnShareWeChatTimeline;
@property (weak, nonatomic) IBOutlet UIButton *btnShareWeChatSession;
@property (weak, nonatomic) IBOutlet UIButton *btnShareQZone;
@property (weak, nonatomic) IBOutlet UIButton *btnShareSina;
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;
@property (weak, nonatomic) IBOutlet UIView *viewShareContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintContentTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSinaLeadToPre;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSinaLeadToSuper;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *wechatTimeline;
@property (weak, nonatomic) IBOutlet UIView *wechatSession;
@property (weak, nonatomic) IBOutlet UIView *Sina;
@property (weak, nonatomic) IBOutlet UIView *QQZone;
@end
