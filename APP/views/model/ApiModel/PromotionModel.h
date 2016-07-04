//
//  PromotionModel.h
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIModel.h"


@interface PromotionModel : NSObject

@end


@interface NearByPromotionListModel : BaseModel

@property (strong, nonatomic) NSString *apiStatus;
@property (strong, nonatomic) NSString *apiMeeage;
@property (strong, nonatomic) NSArray *list;

@end

@interface DrugVo : BaseModel

@property (strong, nonatomic) NSString *productId;//商品Id
@property (strong, nonatomic) NSString *promotionId;//促销活动Id
@property (strong, nonatomic) NSString *proId;//商品ID,
@property (strong, nonatomic) NSString *proName;//商品名称
@property (strong, nonatomic) NSString *pid;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *spec;
@property (strong, nonatomic) NSString *signCode;
@property (strong, nonatomic) NSString *factoryname;
@property (strong, nonatomic) NSString *factory;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *gift;
@property (strong, nonatomic) NSString *discount;
@property (strong, nonatomic) NSString *voucher;
@property (strong, nonatomic) NSString *special;
@property (strong, nonatomic) NSString *beginDate;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *multiPromotion;//是否参与多个优惠活动

@end

@interface TagFilterList : BaseModel

@property (strong, nonatomic) NSArray *list;

@end

@interface TagFilterVo : BaseModel

@property (strong, nonatomic) NSString *tagCode;
@property (strong, nonatomic) NSString *tagName;

@end

@interface GroupFilterList : BaseModel

@property (strong, nonatomic) NSArray *list;

@end

@interface GroupFilterListVo : BaseAPIModel

@property (strong, nonatomic) NSArray *groups;

@end

@interface GroupVoList : BaseModel

@property (strong, nonatomic) NSArray *groupVoList;

@property (strong, nonatomic) NSString *factoryName;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *proId;
@property (strong, nonatomic) NSString *proName;
@property (strong, nonatomic) NSString *signCode;
@property (strong, nonatomic) NSString *spec;

@end

@interface GroupFilterVo : BaseModel

@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSString *groupName;

@end

@interface GroupVo : BaseModel

@property (strong, nonatomic) NSString *pid;
@property (strong, nonatomic) NSString *branchName;
@property (strong, nonatomic) NSString *branchCount;
@property (strong, nonatomic) NSString *label;

@end

@interface DrugGetVo : BaseModel

@property (strong, nonatomic) NSString *apiMessage;
@property (strong, nonatomic) NSString *apiStatus;
@property (strong, nonatomic) NSString *proDrugId;

@end

@interface OrderCreateVo : BaseModel

@property (strong, nonatomic) NSString *apiMessage;
@property (strong, nonatomic) NSString *apiStatus;
@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *verifyCode;

@end

@interface CommentVo : BaseModel

@property (strong, nonatomic) NSString *apiMessage;
@property (strong, nonatomic) NSString *apiStatus;
@property (strong, nonatomic) NSString *star;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *time;

@end

@interface LoopCheckVo : BaseAPIModel

@property (strong, nonatomic) NSString  *presentType;       // 赠送类型。Q\P
@property (strong, nonatomic) NSArray   *presentPromotions; //赠送商品列表
@property (strong, nonatomic) NSArray   *presentCoupons;    //赠送优惠券列表
@property (strong, nonatomic) NSString  *desc;
@property (strong, nonatomic) NSString  *quantity;
@property (strong, nonatomic) NSString  *proName;
@property (strong, nonatomic) NSString  *branchName;
@property (strong, nonatomic) NSArray   *gifts;
@property (strong, nonatomic) NSString  *promotionTitle;
@property (strong, nonatomic) NSString  *pid;
@property (strong, nonatomic) NSString  *proId;
@property (strong, nonatomic) NSString  *proImgUrl;

@end



@interface PromotionProductArrayVo : BaseAPIModel

@property (strong, nonatomic) NSArray *hotPromotionList;
@property (strong, nonatomic) NSArray *normalPromotionList;

@end




