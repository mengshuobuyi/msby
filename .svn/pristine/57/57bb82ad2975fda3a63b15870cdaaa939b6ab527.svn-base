//
//  ConsultModelR.h
//  APP
//
//  Created by chenzhipeng on 5/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"
#import "BasePrivateModel.h"
@interface ConsultModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@end

@interface ConsultCustomerModelR : ConsultModelR

@end

@interface XPCreate : BaseModel //请求用model
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *contentJson;
@property (nonatomic, strong) NSString *UUID;
@end

@interface XPRead : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *detailIds;
@end

@interface XPRemove : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *detailId;
@end


@interface ConsultCustomerNewModelR : ConsultModelR
@property (nonatomic, strong) NSString *consultIds;
@property (nonatomic, strong) NSString *lastTimestamp;//最后的更新时间
@end

@interface ConsultDetailCreateModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *UUID;
@property (nonatomic, strong) NSString *contentJson;
@end

@interface ConsultDetailRemoveModelR : BasePrivateModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *detailId;
@end

@interface ConsultItemReadModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *detailIds;

@end

@interface ConsultExpiredModelR : BaseModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *point;

@end


@interface ConsultSpreadModelR : ConsultModelR

@property (nonatomic ,strong) NSString *consultId;

@end

@interface ConsultDetailCustomerModelR : ConsultModelR

@property (nonatomic ,strong) NSString *consultId;

@end

@interface ConsultSetUnreadNumModelR : ConsultModelR

@property (nonatomic, strong) NSString *num;

@end


@interface RemoveByCustomerR : BaseModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@end