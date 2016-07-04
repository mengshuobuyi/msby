//
//  LinePharmacistChatBubbleView.h
//  APP
//
//  Created by YYX on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseChatBubbleView.h"

extern NSString *const kRouterEventLinePharmacistBubbleTapEventName;

@interface LinePharmacistChatBubbleView : BaseChatBubbleView

@property (weak, nonatomic) IBOutlet UILabel *linePharmacistText;

@end
