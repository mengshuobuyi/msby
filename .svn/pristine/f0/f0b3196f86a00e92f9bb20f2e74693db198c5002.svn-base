//
//  OnceDrugChatBubbleView.m
//  APP
//
//  Created by YYX on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "OnceDrugChatBubbleView.h"
#import "UIImageView+WebCache.h"

NSString *const kRouterEventOnceDrugBubbleTapEventName = @"kRouterEventOnceDrugBubbleTapEventName";

@implementation OnceDrugChatBubbleView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.sendButton.layer.borderColor = RGBHex(qwColor2).CGColor;
    self.sendButton.layer.borderWidth = 1.0;
    self.sendButton.layer.cornerRadius = 4.0;
    self.sendButton.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
//    UIImage *resizeImage = [UIImage imageNamed:@"ic_btn_send.png"];
//    resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 30, 20, 30) resizingMode:UIImageResizingModeStretch];
//    [self.sendButton setBackgroundImage:resizeImage forState:UIControlStateNormal];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
//    [self addGestureRecognizer:tap];
    
    UIView * topSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    topSeparateLine.backgroundColor = RGBHex(qwColor10);
    [self addSubview:topSeparateLine];
    
    UIView * bottomSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, APP_W, 0.5)];
    bottomSeparateLine.backgroundColor = RGBHex(qwColor10);
    [self addSubview:bottomSeparateLine];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - setter
-(void)setMessageModel:(MessageModel *)messageModel
{
    [super setMessageModel:messageModel];
    [self.drugImageView setImageWithURL:[NSURL URLWithString:messageModel.activityUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"] completed:nil];
    self.specLabel.text = messageModel.spec;
    self.drugName.text = messageModel.text;
}


#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventOnceDrugBubbleTapEventName userInfo:@{KMESSAGEKEY:self.messageModel}];
}

+(CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGSize bubbleSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 130);
    return bubbleSize;
}


- (IBAction)sendDrugAction:(id)sender
{
    [self bubbleViewPressed:nil];
}
@end
