//
//  ConsultModel.h
//  APP
//
//  Created by chenzhipeng on 5/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseAPIModel.h"
#import "BasePrivateModel.h"
@interface ConsultModel : BaseAPIModel

@end

@interface ConsultCustomerListModel : BaseAPIModel
@property (nonatomic, strong) NSArray   *consults;
@property (nonatomic, strong) NSString  *lastTimestamp;         //更新时间
@end


@interface ConsultCustomerModel : ConsultModel
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *consultTitle;
@property (nonatomic, strong) NSString *consultCreateTime;
@property (nonatomic, strong) NSString *consultFormatCreateTime;
@property (nonatomic, strong) NSString *consultFormatShowTime;
@property (nonatomic, strong) NSString *consultStatus;      // 消息状态
@property (nonatomic, strong) NSString *consultMessage;
@property (nonatomic, strong) NSString *consultLatestTime;
@property (nonatomic, strong) NSString *pharAvatarUrl;
@property (nonatomic, strong) NSString *pharShortName;
@property (nonatomic, strong) NSString *pharPassport;
@property (nonatomic, strong) NSString *pharType;           // 2是明星商家
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *systemUnreadCounts;
@property (nonatomic, strong) NSString *isSpred;
@property (nonatomic, strong) NSString *spreadMessage;
@property (nonatomic, strong) NSString *consultType;        // 咨询类型：1群发、2指定

@end

@interface CustomerConsultVoModel : BasePrivateModel
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *branchName;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *consultTitle;
@property (nonatomic, strong) NSString *consultCreateTime;
@property (nonatomic, strong) NSString *consultFormatCreateTime;
@property (nonatomic, strong) NSString *consultFormatShowTime;
@property (nonatomic, strong) NSString *consultStatus;      // 消息状态
@property (nonatomic, strong) NSString *consultMessage;
@property (nonatomic, strong) NSString *consultLatestTime;
@property (nonatomic, strong) NSString *pharAvatarUrl;
@property (nonatomic, strong) NSString *pharShortName;
@property (nonatomic, strong) NSString *pharPassport;
@property (nonatomic, strong) NSString *pharType;           // 2是明星商家
@property (nonatomic, strong) NSString *unreadCounts;
@property (nonatomic, strong) NSString *systemUnreadCounts;
@property (nonatomic, strong) NSString *isSpred;
@property (nonatomic, strong) NSString *spreadMessage;
@property (nonatomic, strong) NSString *consultType;        // 咨询类型：1群发、2指定
@property (nonatomic, strong) NSString *consultShowTitle;   // 用于消息盒子的显示标题
@end


@interface ContentJson : BaseModel

@property (nonatomic, strong) NSString *spec;//商品规格
@property (nonatomic, strong) NSString *branchId;//门店ID
@property (nonatomic, strong) NSString *branchProId;//门店商品ID

@property (nonatomic, strong) NSString *actId;
@property (nonatomic, strong) NSString *actImgUrl;
@property (nonatomic, strong) NSString *actTitle;
@property (nonatomic, strong) NSString *actContent;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *speText;
@property (nonatomic, strong) NSString *speUrl;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *platform;

//优惠药品
@property (nonatomic, strong) NSString *pmtLabe;
@property (nonatomic, strong) NSString *pmtId;

//优惠券
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *couponValue;
@property (nonatomic, strong) NSString *couponTag;
@property (nonatomic, strong) NSString *begin;
@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *top;

//优惠活动
@property (nonatomic, strong) NSString *branchLogo;//商户图片
@end

@interface CustomerConsultDetailList : BaseAPIModel

@property (strong, nonatomic) NSArray  *details;
@property (strong, nonatomic) NSString *serverTime;
@property (strong, nonatomic) NSString *consultCreateTime;
@property (strong, nonatomic) NSString *consultType;
@property (strong, nonatomic) NSString *consultStatus;
@property (strong, nonatomic) NSString *consultRaceTime;
@property (strong, nonatomic) NSString *consultRemainTime;
@property (assign, nonatomic) BOOL     evaluated;
@property (strong, nonatomic) NSString *consultMessage;
@property (strong, nonatomic) NSString *spreadMessage;
@property (strong, nonatomic) NSString *detailId;
@property (strong, nonatomic) NSString *consultId;
@property (strong, nonatomic) NSString *branchId;
@property (strong, nonatomic) NSString *customerIndex;
@property (strong, nonatomic) NSString *pharAvatarUrl;
@property (strong, nonatomic) NSString *pharShortName;
@property (strong, nonatomic) NSString *isSpred;

@end

@interface ConsultDetail : BaseModel

@property (strong, nonatomic) NSString *detailId;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *contentJson;
@property (strong, nonatomic) NSString *contentType;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *readStatus;

@end

@interface ConsultDetailCreateModel : BaseAPIModel

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *UUID;
@end

@interface ConsultDetailCustomerDetailListModel : ConsultModel

@property (nonatomic ,assign) int consultType;
@property (nonatomic ,strong) NSArray *details;
@property (nonatomic ,strong) NSString *pharAvatarUrl;
@property (nonatomic ,assign) double serverTime;

@end

@interface ConsultDetailCustomerDetailModel : BaseModel

@property (nonatomic ,strong) NSString *contentJson;
@property (nonatomic ,strong) NSString *contentType;
@property (nonatomic ,assign) double createTime;
@property (nonatomic ,assign) long int detailId;
@property (nonatomic ,strong) NSString *readStatus;
@property (nonatomic ,strong) NSString *type;

@end

////

@interface PharConsultDetail : BaseAPIModel

@property (strong, nonatomic) NSArray  *details;
@property (strong, nonatomic) NSString *serverTime;
@property (strong, nonatomic) NSString *consultCreateTime;
@property (strong, nonatomic) NSString *consultType;
@property (strong, nonatomic) NSString *evaluated;

@property (strong, nonatomic) NSString *consultStatus;
@property (strong, nonatomic) NSString *consultRaceTime;
@property (strong, nonatomic) NSString *consultRemainTime;
@property (strong, nonatomic) NSString *consultMessage;
@property (strong, nonatomic) NSString *spreadMessage;
@property (strong, nonatomic) NSString *detailId;
@property (strong, nonatomic) NSString *consultId;
@property (strong, nonatomic) NSString *branchId;
@property (strong, nonatomic) NSString *customerIndex;
@property (strong, nonatomic) NSString *pharAvatarUrl;
@property (strong, nonatomic) NSString *pharShortName;
@property (strong, nonatomic) NSString *isSpred;

@end



//@interface ConsultDetailCustomerDetailListModel : ConsultModel
//
//@property (nonatomic ,assign) int consultType;
//@property (nonatomic ,strong) NSArray *details;
//@property (nonatomic ,strong) NSString *pharAvatarUrl;
//@property (nonatomic ,assign) double serverTime;
//
//@end
//
//@interface ConsultDetailCustomerDetailModel : BaseModel
//
//@property (nonatomic ,strong) NSString *contentJson;
//@property (nonatomic ,strong) NSString *contentType;
//@property (nonatomic ,assign) double createTime;
//@property (nonatomic ,assign) long int detailId;
//@property (nonatomic ,strong) NSString *readStatus;
//@property (nonatomic ,strong) NSString *type;
//
//@end

