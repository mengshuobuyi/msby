//
//  InfoMsgModelR.h
//  APP
//
//  Created by PerryChen on 1/7/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "BaseModel.h"

@interface InfoMsgModelR : BaseModel

@end

@interface InfoMsgListModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *channelID;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;
@end

@interface InfoMsgQueryUserChannelModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *device;
@end

@interface InfoMsgUpdateUserChannelModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *list;
@end

@interface InfoMsgQueryUserNotAddChannelModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *device;
@end

@interface InfoCircleMsgListModelR: InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *point;
@property (nonatomic, strong) NSString *view;
@property (nonatomic, strong) NSString *viewType;
@end

@interface InfoCircleNewMsgListModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@end

@interface InfoCircleRemoveCircleModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *sessionId;
@end

@interface InfoCircleAllReadModelR : InfoMsgModelR
@property (nonatomic, strong) NSString *token;
@end
