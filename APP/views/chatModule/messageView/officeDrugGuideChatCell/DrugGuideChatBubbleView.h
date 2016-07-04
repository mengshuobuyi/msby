//
//  DrugGuideChatBubbleView
//  APP
//
//  Created by caojing on 15/5/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseChatBubbleView.h"
#import "MLEmojiLabel.h"

extern NSString *const kRouterEventOfficeDrugGuideChat;

@interface DrugGuideChatBubbleView : BaseChatBubbleView<MLEmojiLabelDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLable;

@property (weak, nonatomic) IBOutlet MLEmojiLabel *contentLable;


@end
