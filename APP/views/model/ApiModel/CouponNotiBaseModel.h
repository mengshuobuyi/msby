//
//  CouponNotiBaseModel.h
//  APP
//
//  Created by PerryChen on 8/17/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"
#import "BasePrivateModel.h"
@interface CouponNotiBaseModel : BasePrivateModel

@end

//@interface CouponNotiListModel : CouponNotiBaseModel
//@property (nonatomic, strong) NSString *apiStatus;
//@property (nonatomic, strong) NSString *apiMessage;
//@property (nonatomic, strong) NSString *lastTimestamp;
//@property (nonatomic, strong) NSArray *messages;
//@end

@interface CouponNotiModel : CouponNotiBaseModel
//@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *myCouponId;
@property (nonatomic, strong) NSString *showTitle;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *formatShowTime;
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *showRedPoint;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *objType;
@property (nonatomic, strong) NSString *objId;
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *drugGuideId;
@property (nonatomic, strong) NSString *attentionName;
@end

@interface CouponMessageArrayVo : BaseModel
@property (nonatomic, strong) NSString *apiStatus;
@property (nonatomic, strong) NSString *apiMessage;
@property (nonatomic, strong) NSString *lastTimestamp;
@property (nonatomic, strong) NSArray *messages;

@end



@interface CouponMessageVo : BaseModel
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *myCouponId;
@property (nonatomic, strong) NSString *showTitle;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *formatShowTime;
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *objType;
@property (nonatomic, strong) NSString *objId;
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *drugGuideId;
@property (nonatomic, strong) NSString *attentionName;

@end
