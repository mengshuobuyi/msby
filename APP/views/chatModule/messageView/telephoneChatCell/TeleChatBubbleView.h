//
//  TeleChatBubbleView.h
//  APP
//
//  Created by caojing on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseChatBubbleView.h"
extern NSString *const kRouterEventTeleChat;
@interface TeleChatBubbleView : BaseChatBubbleView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIImageView *telephoneImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rihgtCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCon;
@end
