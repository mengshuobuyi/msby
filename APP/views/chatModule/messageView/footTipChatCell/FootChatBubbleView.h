//
//  FootChatBubbleView.h
//  APP
//
//  Created by caojing on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseChatBubbleView.h"
extern NSString *const kRouterEventFootChat;
@interface FootChatBubbleView : BaseChatBubbleView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *consultImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end
