//
//  FootAllChatBubbleView.h
//  APP
//
//  Created by YYX on 15/7/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseChatBubbleView.h"
extern NSString *const kRouterEventFootConsultAgainChat;

@interface FootConsultAgainView : BaseChatBubbleView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *consultImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@end
