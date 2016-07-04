//
//  OnceCouponChatBubbleView.h
//  APP
//
//  Created by YYX on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseChatBubbleView.h"

extern NSString *const kRouterEventOnceCouponBubbleTapEventName;

@interface OnceCouponChatBubbleView : BaseChatBubbleView

@property (weak, nonatomic) IBOutlet UILabel *couponTitle;
@property (weak, nonatomic) IBOutlet UIImageView *couponImageView;
@property (weak, nonatomic) IBOutlet UILabel *couponContent;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)sendCouponAction:(id)sender;

@end
