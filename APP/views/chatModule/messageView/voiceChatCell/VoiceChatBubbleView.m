//
//  VoiceChatBubbleView.m
//  APP
//
//  Created by 李坚 on 15/7/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "VoiceChatBubbleView.h"
#import "FileManager.h"
#import "MessageCenter.h"
#import "PrivateMessageCenter.h"
NSString *const kRouterEventOfVoice = @"kRouterEventOfVoice";

@implementation VoiceChatBubbleView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor clearColor];
    self.VoiceImageView.backgroundColor = [UIColor clearColor];

    self.playEnable = NO;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
    [self.VoiceImageView addGestureRecognizer:tap];
    [self addGestureRecognizer:tap];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setMessageModel:(MessageModel *)messageModel{
    [super setMessageModel:messageModel];
    if(messageModel.audioPlaying) {
        self.playEnable = YES;
        [self playAnimation];
    }else{
        [self stopVoice];
    }
    CGSize size;
    float length = floorf([messageModel.voiceDuration floatValue]);
    
    if(length < 35){
        float width = (VoiceMaxWidth - VoiceMinWidth)  * (length / 35);
        size = CGSizeMake(VoiceMinWidth + width, self.frame.size.height);
    }else{
        size = CGSizeMake(VoiceMaxWidth, self.frame.size.height);
    }
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
    if(messageModel.messageDeliveryType == MessageTypeSending){
        self.LeftSpace.constant = size.width - 35;
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
        self.VoiceImageView.transform = transform;
    }
    if(messageModel.messageDeliveryType == MessageTypeReceiving){
        self.LeftSpace.constant = 15;
    }
}


- (void)bubbleViewPressed:(id)sender
{
    if(_messageModel.voicePath && _messageModel.voicePath.length > 0) {
        NSMutableArray *conpoment = [[_messageModel.voicePath componentsSeparatedByString:@"/"] mutableCopy];
        conpoment = [conpoment subarrayWithRange:NSMakeRange(conpoment.count - 4, 4)];
        NSString *audioPath = [NSHomeDirectory() stringByAppendingPathComponent:[conpoment componentsJoinedByString:@"/"]];
        if(audioPath) {
            NSFileManager *manager = [NSFileManager defaultManager];
            if([manager fileExistsAtPath:audioPath])
            {
                self.playEnable = YES;
                [self playAnimation];
            }
        }
    }
    [self routerEventWithName:kRouterEventOfVoice userInfo:@{KMESSAGEKEY:self.messageModel}];
}

//停止语音播放
- (void)stopVoice{
    
    [self.VoiceImageView stopAnimating];
    self.VoiceImageView.image = [UIImage imageNamed:@"voice3"];
    self.playEnable = NO;
}

//计算规则,35s前比例增长,超过以后达到最大长度不变
+ (CGSize)sizeForBubbleWithObject:(MessageModel *)object{
    CGSize size;
    float length = floorf([object.voiceDuration floatValue]);
    
    if(length < 35){
        float width = (VoiceMaxWidth - VoiceMinWidth)  * (length / 35);
        size = CGSizeMake(VoiceMinWidth + width, 35);
    }else{
        size = CGSizeMake(VoiceMaxWidth, 35);
    }
    return size;
}

//下载语音文件
- (void)downLoadVoiceFile{
    NSString *name = [NSString stringWithFormat:@"%@",self.messageModel.UUID];
    self.messageModel.download = MessageFileState_Downloading;
    MessageCenter *center = (MessageCenter*)self.delegateMsgCenter;
    [center updateAMessage:self.messageModel];
    [FileManager downloadFile:self.messageModel.voiceUrl name:name success:^(NSString *savePath) {
        self.messageModel.voicePath = savePath;
        self.messageModel.download = MessageFileState_Downloaded;
        if (self.cellChat) {
            if ([self.delegateMsgCenter isKindOfClass:[MessageCenter class]] || [self.delegateMsgCenter isKindOfClass:[PrivateMessageCenter class]]) {
                MessageCenter *center = (MessageCenter*)self.delegateMsgCenter;
                [center updateAMessage:self.messageModel];
            }
            [self.cellChat refreshCellChat:VoiceDownloadSuccess];
        }
    } failure:^(HttpException *e) {
        self.messageModel.download = MessageFileState_Failure;
        if (self.cellChat) {
            if ([self.delegateMsgCenter isKindOfClass:[MessageCenter class]] || [self.delegateMsgCenter isKindOfClass:[PrivateMessageCenter class]]) {
                MessageCenter *center = (MessageCenter*)self.delegateMsgCenter;
                [center updateAMessage:self.messageModel];
            }
            [self.cellChat refreshCellChat:VoiceDownloadFail];
        }
    }];
}

- (void)playAnimation{
    
    NSMutableArray  *arrayM=[NSMutableArray array];
    [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"voice1"]]];
    [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"voice2"]]];
    [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"voice3"]]];
    //设置动画数组
    [self.VoiceImageView setAnimationImages:arrayM];
    //设置动画播放次数
    [self.VoiceImageView setAnimationRepeatCount:0];
    //设置动画播放时间
    [self.VoiceImageView setAnimationDuration:1.5f];
    //开始动画
    [self.VoiceImageView startAnimating];
}

@end
