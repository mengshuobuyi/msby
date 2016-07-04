//
//  XHMessage.m
//  MessageDisplayExample
//
//  Created by qtone-1 on 14-4-24.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHMessage.h"

@implementation XHMessage

- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                   timestamp:(NSDate *)timestamp
                        UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeText;
    }
    return self;
}

- (instancetype)initWithMedicineShowOnce:(NSString *)text
                               productId:(NSString *)productId
                                imageUrl:(NSString *)imageUrl
                                  sender:(NSString *)sender
                               timestamp:(NSDate *)timestamp
                                    UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.richBody = productId;
        self.activityUrl = imageUrl;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeMedicineShowOnce;
    }
    return self;
}

- (instancetype)initWithMedicine:(NSString *)text
                       productId:(NSString *)productId
                        imageUrl:(NSString *)imageUrl
                          sender:(NSString *)sender
                       timestamp:(NSDate *)timestamp
                            UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.richBody = productId;
        self.activityUrl = imageUrl;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeMedicine;
    }
    return self;
}

- (instancetype)initWithSpecialOffersShowOnce:(NSString *)text
                                      content:(NSString *)content
                                  activityUrl:(NSString *)activityUrl
                                   activityId:(NSString *)activityId
                                       sender:(NSString *)sender
                                    timestamp:(NSDate *)timestamp
                                         UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = content;
        self.activityUrl = activityUrl;
        self.title = text;
        self.isMarked = YES;
        self.richBody = activityId;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce;
    }
    return self;
}

- (instancetype)initWithSpecialOffers:(NSString *)text
                              content:(NSString *)content
                          activityUrl:(NSString *)activityUrl
                           activityId:(NSString *)activityId
                               sender:(NSString *)sender
                            timestamp:(NSDate *)timestamp
                                 UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = content;
        self.activityUrl = activityUrl;
        self.title = text;
        self.isMarked = YES;
        self.richBody = activityId;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeMedicineSpecialOffers;
    }
    return self;
}

- (instancetype)initWithAutoSubscription:(NSString *)text
                                  sender:(NSString *)sender
                               timestamp:(NSDate *)timestamp
                                    UUID:(NSString *)messageUUID
                                 tagList:(NSArray *)tagList
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeAutoSubscription;
        self.tagList = tagList;
    }
    return self;
}

- (instancetype)initWithPurchaseMedicine:(NSString *)text
                                  sender:(NSString *)sender
                               timestamp:(NSDate *)timestamp
                                    UUID:(NSString *)messageUUID
                                 tagList:(NSArray *)tagList
                                   title:(NSString *)title
                        subTitle:(NSString *)subTitle
                                 fromTag:(NSInteger)fromTag;
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.title = title;
        self.fromTag = fromTag;
        self.subTitle = subTitle;
        self.messageMediaType = XHBubbleMessageMediaTypePurchaseMedicine;
        self.tagList = tagList;
    }
    return self;
}

- (instancetype)initWithLocation:(NSString *)text
                        latitude:(NSString *)latitude
                       longitude:(NSString *)longitude
                          sender:(NSString *)sender
                       timestamp:(NSDate *)timestamp
                            UUID:(NSString *)messageUUID
{
    self.text = text;
    self.location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
    self.sender = sender;
    self.timestamp = timestamp;
    _UUID = messageUUID;
    self.messageMediaType = XHBubbleMessageMediaTypeLocation;
    return self;
}



- (instancetype)initWithDrugGuide:(NSString *)text
                            title:(NSString *)title
                           sender:(NSString *)sender
                        timestamp:(NSDate *)timestamp
                             UUID:(NSString *)messageUUID
                          tagList:(NSArray *)tagList
                         subTitle:(NSString *)subTitle
                          fromTag:(NSInteger)fromTag
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.title = title;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.subTitle= subTitle;
        self.fromTag = fromTag;
        self.messageMediaType = XHBubbleMessageMediaTypeDrugGuide;
        self.tagList = tagList;
    }
    return self;
}
- (instancetype)initWithSpreadHint:(NSString *)text
                            title:(NSString *)title
                           sender:(NSString *)sender
                        timestamp:(NSDate *)timestamp
                             UUID:(NSString *)messageUUID
                          tagList:(NSArray *)tagList
                              fromTag:(NSUInteger )fromTag
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.title = title;
        self.sender = sender;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeSpreadHint;
        self.tagList = tagList;
        self.fromTag = fromTag;
    }
    return self;
}
- (instancetype)initInviteEvaluate:(NSString *)text
                            sender:(NSString *)sender
                         timestamp:(NSDate *)timestamp
                              UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.sender = sender;
        self.timestamp = timestamp;
        _UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeStarStore;
    }
    return self;
}

- (instancetype)initEvaluate:(CGFloat)star
                        text:(NSString *)text
                      sender:(NSString *)sender
                   timestamp:(NSDate *)timestamp
                        UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.isMarked = YES;
        self.starMark = star;
        self.sender = sender;
        self.timestamp = timestamp;
        _UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeStarClient;
    }
    return self;
}

/**
 *  初始化图片类型的消息
 *
 *  @param photo          目标图片
 *  @param thumbnailUrl   目标图片在服务器的缩略图地址
 *  @param originPhotoUrl 目标图片在服务器的原图地址
 *  @param sender         发送者
 *  @param date           发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithPhoto:(UIImage *)photo
                 thumbnailUrl:(NSString *)thumbnailUrl
               originPhotoUrl:(NSString *)originPhotoUrl
                       sender:(NSString *)sender
                    timestamp:(NSDate *)timestamp {
    self = [super init];
    if (self) {
        self.photo = photo;
        self.thumbnailUrl = thumbnailUrl;
        self.originPhotoUrl = originPhotoUrl;
        
        self.sender = sender;
        self.timestamp = timestamp;
        
        self.messageMediaType = XHBubbleMessageMediaTypePhoto;
    }
    return self;
}
- (instancetype)initWithPhoto:(UIImage *)photo
                 thumbnailUrl:(NSString *)thumbnailUrl
               originPhotoUrl:(NSString *)originPhotoUrl
                       sender:(NSString *)sender
                    timestamp:(NSDate *)timestamp
                         UUID:(NSString *)messageUUID
                     richBody:(NSString *)richbody
{
    self = [super init];
    if (self) {
        if (!photo) {
            //            NSData *dat = [NSData dataWithContentsOfURL:[NSURL URLWithString: thumbnailUrl]];
            self.photo  = [UIImage  imageWithData:[[XHCacheManager shareCacheManager] localCachedDataWithURL:[NSURL URLWithString:originPhotoUrl]] ];
            if (!self.photo) {
                self.photo=    [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:messageUUID];
            }
            //            self.photo = [UIImage imageWithData:dat];
        }else
        {
            self.photo =photo;
        }
        //        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        //        [imgView setImageWithURL:[NSURL URLWithString:thumbnailUrl] placeholer:nil showActivityIndicatorView:NO completionBlock:^(UIImage *image, NSURL *url, NSError *error) {
        //            if ([url.absoluteString isEqualToString:thumbnailUrl]) {
        //                image = [image resizedImage:CGSizeMake(CGRectGetWidth(weakSelf.bounds) * 2, CGRectGetHeight(weakSelf.bounds) * 2) interpolationQuality:1.0];
        //                if (image) {
        //                    dispatch_async(dispatch_get_main_queue(), ^{
        //                        CGSize  bubbleSize = CGSizeZero;
        //                        bubbleSize = image.size;
        //
        //                        CGFloat width = MAX_SIZE / bubbleSize.height * bubbleSize.width;
        //                        bubbleSize.width = width;
        //                        bubbleSize.height = MAX_SIZE;
        //                        weakSelf.messagePhoto = image;
        //                        [weakSelf setFrame:CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y
        //                                                      , width, MAX_SIZE)];
        //                        DDLogVerbose(@"--------weakSelf--->%@",NSStringFromCGSize(weakSelf.frame.size));
        //                        //
        //                        [weakSelf.activityIndicatorView stopAnimating];
        //
        //                        //                        [weakSelf sizeToFit];
        //
        //                        //                        self = [self imageWithImage:messagePhoto scaledToSize:<#(CGSize)#>];
        //                    });
        //                }
        //            }
        //        }];
        
        self.thumbnailUrl = thumbnailUrl;
        self.originPhotoUrl = originPhotoUrl;
        _UUID = messageUUID;
        self.sender = sender;
        self.timestamp = timestamp;
        
        self.messageMediaType = XHBubbleMessageMediaTypePhoto;
    }
    return self;
}

/**
 *  初始化视频类型的消息
 *
 *  @param videoConverPhoto 目标视频的封面图
 *  @param videoPath        目标视频的本地路径，如果是下载过，或者是从本地发送的时候，会存在
 *  @param videoUrl         目标视频在服务器上的地址
 *  @param sender           发送者
 *  @param date             发送时间
 *
 *  @return 返回Message model 对象
 */

- (instancetype)initMarketActivity:(NSString *)title
                            sender:(NSString *)sender
                          imageUrl:(NSString *)imageUrl
                           content:(NSString *)content
                           comment:(NSString *)comment
                          richBody:(NSString *)richbody
                         timestamp:(NSDate *)timestamp
                              UUID:(NSString *)messageUUID

{
    self = [super init];
    if (self) {
        self.isMarked = YES;
        self.title = title;
        self.activityUrl = imageUrl;
        self.text = content;
        self.sender = sender;
        self.timestamp = timestamp;
        _UUID = messageUUID;
        self.richBody = richbody;
        self.messageMediaType = XHBubbleMessageMediaTypeActivity;
    }
    return self;
}

/**
 *  初始化语音类型的消息
 *
 *  @param voicePath        目标语音的本地路径
 *  @param voiceUrl         目标语音在服务器的地址
 *  @param voiceDuration    目标语音的时长
 *  @param sender           发送者
 *  @param date             发送时间
 *
 *  @return 返回Message model 对象
 */
- (instancetype)initWithVoicePath:(NSString *)voicePath
                         voiceUrl:(NSString *)voiceUrl
                    voiceDuration:(NSString *)voiceDuration
                           sender:(NSString *)sender
                        timestamp:(NSDate *)timestamp {
    self = [super init];
    if (self) {
        self.voicePath = voicePath;
        self.voiceUrl = voiceUrl;
        self.voiceDuration = voiceDuration;
        
        self.sender = sender;
        self.timestamp = timestamp;
        
        self.messageMediaType = XHBubbleMessageMediaTypeVoice;
    }
    return self;
}





- (instancetype)initWithEmotionPath:(NSString *)emotionPath
                             sender:(NSString *)sender
                          timestamp:(NSDate *)timestamp {
    self = [super init];
    if (self) {
        self.emotionPath = emotionPath;
        
        self.sender = sender;
        self.timestamp = timestamp;
        
        self.messageMediaType = XHBubbleMessageMediaTypeEmotion;
    }
    return self;
}

- (instancetype)initWithLocalPositionPhoto:(UIImage *)localPositionPhoto
                              geolocations:(NSString *)geolocations
                                  location:(CLLocation *)location
                                    sender:(NSString *)sender
                                 timestamp:(NSDate *)timestamp {
    self = [super init];
    if (self) {
        self.localPositionPhoto = localPositionPhoto;
        self.geolocations = geolocations;
        self.location = location;
        
        self.sender = sender;
        self.timestamp = timestamp;
        
        self.messageMediaType = XHBubbleMessageMediaTypeLocalPosition;
    }
    return self;
}

- (void)dealloc {
    _text = nil;
    
    _photo = nil;
    _thumbnailUrl = nil;
    _originPhotoUrl = nil;
    
    _videoConverPhoto = nil;
    _videoPath = nil;
    _videoUrl = nil;
    
    _voicePath = nil;
    _voiceUrl = nil;
    _voiceDuration = nil;
    
    _emotionPath = nil;
    
    _localPositionPhoto = nil;
    _geolocations = nil;
    _location = nil;
    
    _avator = nil;
    _avatorUrl = nil;
    
    _sender = nil;
    
    _timestamp = nil;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:@"text"];
        
        _photo = [aDecoder decodeObjectForKey:@"photo"];
        _thumbnailUrl = [aDecoder decodeObjectForKey:@"thumbnailUrl"];
        _originPhotoUrl = [aDecoder decodeObjectForKey:@"originPhotoUrl"];
        
        _videoConverPhoto = [aDecoder decodeObjectForKey:@"videoConverPhoto"];
        _videoPath = [aDecoder decodeObjectForKey:@"videoPath"];
        _videoUrl = [aDecoder decodeObjectForKey:@"videoUrl"];
        
        _voicePath = [aDecoder decodeObjectForKey:@"voicePath"];
        _voiceUrl = [aDecoder decodeObjectForKey:@"voiceUrl"];
        _voiceDuration = [aDecoder decodeObjectForKey:@"voiceDuration"];
        
        _emotionPath = [aDecoder decodeObjectForKey:@"emotionPath"];
        
        _localPositionPhoto = [aDecoder decodeObjectForKey:@"localPositionPhoto"];
        _geolocations = [aDecoder decodeObjectForKey:@"geolocations"];
        _location = [aDecoder decodeObjectForKey:@"location"];
        
        _avator = [aDecoder decodeObjectForKey:@"avator"];
        _avatorUrl = [aDecoder decodeObjectForKey:@"avatorUrl"];
        
        _sender = [aDecoder decodeObjectForKey:@"sender"];
        _timestamp = [aDecoder decodeObjectForKey:@"timestamp"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.text forKey:@"text"];
    
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.thumbnailUrl forKey:@"thumbnailUrl"];
    [aCoder encodeObject:self.originPhotoUrl forKey:@"originPhotoUrl"];
    
    [aCoder encodeObject:self.videoConverPhoto forKey:@"videoConverPhoto"];
    [aCoder encodeObject:self.videoPath forKey:@"videoPath"];
    [aCoder encodeObject:self.videoUrl forKey:@"videoUrl"];
    
    [aCoder encodeObject:self.voicePath forKey:@"voicePath"];
    [aCoder encodeObject:self.voiceUrl forKey:@"voiceUrl"];
    [aCoder encodeObject:self.voiceDuration forKey:@"voiceDuration"];
    
    [aCoder encodeObject:self.emotionPath forKey:@"emotionPath"];
    
    [aCoder encodeObject:self.localPositionPhoto forKey:@"localPositionPhoto"];
    [aCoder encodeObject:self.geolocations forKey:@"geolocations"];
    [aCoder encodeObject:self.location forKey:@"location"];
    
    [aCoder encodeObject:self.sender forKey:@"sender"];
    [aCoder encodeObject:self.timestamp forKey:@"timestamp"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    switch (self.messageMediaType) {
        case XHBubbleMessageMediaTypeText:
            return [[[self class] allocWithZone:zone] initWithText:[self.text copy]
                                                            sender:[self.sender copy]
                                                         timestamp:[self.timestamp copy] UUID:[self.UUID copy]];
        case XHBubbleMessageMediaTypePhoto:
            return [[[self class] allocWithZone:zone] initWithPhoto:[self.photo copy]
                                                       thumbnailUrl:[self.thumbnailUrl copy]
                                                     originPhotoUrl:[self.originPhotoUrl copy]
                                                             sender:[self.sender copy]
                                                          timestamp:[self.timestamp copy]
                                                               UUID:[self.UUID copy]
                                                           richBody:@"[图片]"];
        case XHBubbleMessageMediaTypeEmotion:
            return [[[self class] allocWithZone:zone] initWithEmotionPath:[self.emotionPath copy]
                                                                   sender:[self.sender copy]
                                                                timestamp:[self.timestamp copy]];
        case XHBubbleMessageMediaTypeLocalPosition:
            return [[[self class] allocWithZone:zone] initWithLocalPositionPhoto:[self.localPositionPhoto copy]
                                                                    geolocations:self.geolocations
                                                                        location:[self.location copy]
                                                                          sender:[self.sender copy]
                                                                       timestamp:[self.timestamp copy]];
        default:
            return nil;
    }
}



- (instancetype)initWithHeader:(NSString *)text timestamp:(NSDate *)timestamp UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.timestamp = timestamp;
        self.UUID = messageUUID;
        self.messageMediaType = XHBubbleMessageMediaTypeHeader;

    }
    return self;
}
- (instancetype)initWithLine:(NSString *)text timestamp:(NSDate *)timestamp UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.UUID = messageUUID;
        self.timestamp = timestamp;
        self.messageMediaType = XHBubbleMessageMediaTypeLine;
    }
    return self;
}
- (instancetype)initWithFooter:(NSString *)text timestamp:(NSDate *)timestamp UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.UUID = messageUUID;
        self.timestamp = timestamp;
        self.messageMediaType = XHBubbleMessageMediaTypeFooter;
    }
    return self;
}
- (instancetype)initWithPhone:(NSString *)text timestamp:(NSDate *)timestamp UUID:(NSString *)messageUUID
{
    self = [super init];
    if (self) {
        self.text = text;
        self.UUID = messageUUID;
        self.timestamp = timestamp;
        self.messageMediaType = XHBubbleMessageMediaTypePhone;
    }
    return self;
}

@end