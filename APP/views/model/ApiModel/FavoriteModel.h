//
//  FavoriteModel.h
//  APP
//
//  Created by qw on 15/3/5.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIModel.h"

@interface FavoriteModel : BaseAPIModel

@end

@interface MyFavListModel : BaseAPIModel
@property (nonatomic, strong) NSArray  *list;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageSum;
@property (nonatomic, strong) NSString *totalRecords;
@property (nonatomic, strong) NSString *favSomeId;

@end


@interface MyFavStoreModel: BaseModel

@property (nonatomic, strong) NSString *mshopStar;//星级 V3.2.0
@property (nonatomic, strong) NSString *type;//类型：1.未开通微商药房 2.社会药房 3.开通微商药房 4.未开通微商社会药房
@property (nonatomic, strong) NSString *cityOpenStatus;//城市开通状态：1.城市未开通服务 2.城市未开通微商 3.城市开通微商
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *avgStar;
@property (nonatomic, strong) NSString *consult;
@property (nonatomic, strong) NSString *accType;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *accountId;
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *firm;
@property (nonatomic, strong) NSString *isStar;

@property (nonatomic, strong) NSString *favInKey;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *promotionSign;
@end

@interface MyFavStoreTagListModel : BaseModel
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *tag;
@end




@interface MyFavProductListModel : BaseModel
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *proId;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *factory;
@property (nonatomic, strong) NSString *spec;
@property (nonatomic, strong) NSString *promotionType;

@property (nonatomic,strong) NSString *imgUrl;//商品图片的地址
@property (nonatomic, strong) NSString *favProductInKey;
@property (nonatomic, strong) NSString *token;

@property (nonatomic,strong)NSString *gift;
@property (nonatomic,strong)NSString *discount;
@property (nonatomic,strong)NSString *voucher;
@property (nonatomic,strong)NSString *special;
@property (nonatomic,strong)NSString *label;

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *promotionId;
@property (nonatomic,strong)NSString *multiPromotion;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *startDate;
@property (nonatomic,strong)NSString *endDate;
@property (nonatomic,strong)NSString *source;

@end

@interface MyFavSpmListModel : BaseModel
@property (nonatomic, strong) NSString *spmCode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *population;

@property (nonatomic, strong) NSString *favSpmInKey;
@property (nonatomic, strong) NSString *token;
@end

@interface MyFavDiseaseListModel : BaseModel
@property (nonatomic, strong) NSString *diseaseId;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSString *ename;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *favDiseaseInKey;
@property (nonatomic, strong) NSString *token;
@end

@interface MyFavAdviceListModel : BaseModel
@property (nonatomic, strong) NSString *adviceId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *likeNumber;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *readNum;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *pariseNum;


@property (nonatomic, strong) NSString *favAdviceInKey;
@property (nonatomic, strong) NSString *token;
@end

@interface MyFavCoupnListModel : BaseAPIModel
@property (nonatomic) NSString *id;
@property (nonatomic) NSString *imgUrl;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *pushStatus;

@property (nonatomic, strong) NSString *favCoupnInKey;
@property (nonatomic, strong) NSString *token;
@end



@interface CancleResult : BaseAPIModel
@property (nonatomic, strong) NSString *result;
@end

@interface AdviceCollectResult : BaseModel
@property (nonatomic, strong) NSString *pariseVal;
@property (nonatomic, strong) NSString *favoriteVal;
@end

@interface MyFavMsgLists : BaseAPIModel
@property (nonatomic, strong) NSArray *list;
@end

@interface MyFavMsgListModel : BaseAPIModel
@property (nonatomic, strong) NSString *msgID;
@property (nonatomic, strong) NSString *spclID;
@property (nonatomic, strong) NSString *artType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgURl;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *showType;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *isTop;
@end

@interface DelCollectionModel : BaseModel
@property (nonatomic,strong) NSString *result;
@property (nonatomic,strong) NSString *errorCode;
@property (nonatomic,strong) NSString *errorDescription;

@end