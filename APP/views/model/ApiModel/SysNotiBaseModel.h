//
//  SysNotiBaseModel.h
//  APP
//
//  Created by PerryChen on 8/18/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"
#import "BasePrivateModel.h"
@interface SysNotiBaseModel : BasePrivateModel

@end

@interface SystemMessageArrayVo : SysNotiBaseModel
@property (nonatomic, strong) NSString *lastTimestamp;
@property (nonatomic, strong) NSArray *messages;

@end

@interface SystemMessageVo : SysNotiBaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *showTitle;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *formatShowTime;
@property (nonatomic, strong) NSString *unreadCounts;

@end

//@interface SysNotiListModel : SysNotiBaseModel
//@property (nonatomic, strong) NSString *apiStatus;
//@property (nonatomic, strong) NSString *apiMessage;
//@property (nonatomic, strong) NSString *lastTimestamp;
//@property (nonatomic, strong) NSString *messages;
//@end

@interface SysNotiModel : SysNotiBaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *showTitle;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *formatShowTime;
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *showRedPoint;

@end

@interface OrderMessageArrayVo : SysNotiBaseModel
@property (nonatomic, strong) NSString *lastTimestamp;
@property (nonatomic, strong) NSArray *messages;

@end

@interface OrderMessageVo : SysNotiBaseModel

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *content;

@end

@interface OrderNotiModel : BasePrivateModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *showRedPoint;
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *content;
@end

