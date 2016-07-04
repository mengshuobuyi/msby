//
//  StoreModel.h
//  APP
//
//  Created by chenzhipeng on 3/6/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseAPIModel.h"
#import "BasePrivateModel.h"

@interface StoreModel : BaseAPIModel
@property (nonatomic, strong) NSMutableArray *list;
@end

@interface StoreNearByListModel : BaseAPIModel
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageSum;
@property (nonatomic, strong) NSString *totalRecords;
@property (nonatomic, strong) NSString *dataStatus;

@end

@interface StoreNearByModel : BasePrivateModel

@property (nonatomic, strong) NSString *mshopStar;//星级 V3.2.0
@property (nonatomic, assign) BOOL spelled;
@property (nonatomic, strong) NSString *type;//类型：1.未开通微商药房 2.社会药房 3.开通微商药房
@property (nonatomic, assign) NSInteger pageIndex;//该条数据显示于那个tab，0为优惠药房，1为全部药房

@property (nonatomic, strong) NSString *accType;
@property (nonatomic, strong) NSString *accountId;//药店关联的通行证帐号id 药店聊天专用
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *avgStar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *consult;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *firm;
@property (nonatomic, strong) NSString *branchId;         //药店id 数据库唯一标识
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *isStar;
@property (nonatomic ,strong) NSString *isTopStar;
@property (nonatomic ,strong) NSString *promotionSign;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *brandImgUrl;

@property (nonatomic ,strong) NSString *promotionType;//优惠形式
@property (nonatomic ,strong) NSString *promotionDesc;//优惠数目
@end

@interface StoreNearByTagModel : BaseAPIModel
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *tag;
@end


/**
 *  @brief 开通城市检查
 *
 *  add by Meng
 */

@interface StoreSearchOpenCityCheckModel : BaseAPIModel

@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSString *cityName;
@property (nonatomic ,strong) NSString *code;
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *open;
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *provinceName;
@property (nonatomic ,strong) NSString *remark;


@end


/**
 *  @brief 区域范围内搜索药店
 *
 *  add by Meng
 */
@interface StoreSearchRegionModel : BaseAPIModel

@property (nonatomic ,strong) NSArray *list;
@property (nonatomic ,strong) NSString *page;
@property (nonatomic ,strong) NSString *pageSize;
@property (nonatomic ,strong) NSString *pageSum;
@property (nonatomic ,strong) NSString *totalRecords;

@end

/**
 *  @brief 用于及时更新聊天时商家的头像和昵称
 *
 *  add by Jiao
 */
@interface GroupModel : BaseAPIModel

@property (nonatomic ,strong) NSString *accountId;
@property (nonatomic ,strong) NSString *groupId;
@property (nonatomic ,strong) NSString *groupName;
@property (nonatomic ,strong) NSString *groupType;
@property (nonatomic ,strong) NSString *groupUrl;
@property (nonatomic ,strong) NSString *shortName;

@end

@interface SearchStorehModel : BaseAPIModel

@property (nonatomic, copy) NSString *branchId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *promotion;
@property (nonatomic, copy) NSString *type;

@end


@interface StoreNearBySearchModel : BaseAPIModel
@property (nonatomic, strong) NSString *accType;
@property (nonatomic, strong) NSString *accountId;//药店关联的通行证帐号id 药店聊天专用
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *avgStar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *consult;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *firm;
@property (nonatomic, strong) NSString *id;         //药店id 数据库唯一标识
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *isStar;
@end


@interface StoreComplaintTypeModel : BaseModel
@property (nonatomic, assign) BOOL selectFlag;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@end



@interface RecommendStoreModel : BaseAPIModel
@property (nonatomic, strong) NSString *accType;
@property (nonatomic, strong) NSString *accountId;//药店关联的通行证帐号id 药店聊天专用
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *avgStar;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *consult;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *firm;
@property (nonatomic, strong) NSString *id;         //药店id 数据库唯一标识
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *isStar;
@property (nonatomic ,strong) NSString *isTopStar;
@property (nonatomic ,strong) NSString *promotionSign;

@end