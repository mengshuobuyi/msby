//**********************************************
//             药店相关API发送请求Model          //
//**********************************************

//统一继承自StoreModelR

#import "BaseModel.h"

@interface StoreModelR : BaseModel


@end


/**
 *  @brief 开通城市检查
 *
 *  add by Meng
 */

@interface StoreSearchOpenCityCheckModelR : StoreModelR

@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSString *city;


@end
/**
 *  @brief 区域范围内搜索药店
 *
 *  add by Meng
 */
@interface StoreSearchRegionModelR : StoreModelR

@property (nonatomic ,strong) NSString *check;
@property (nonatomic ,strong) NSString *keyword;
@property (nonatomic ,strong) NSNumber *page;
@property (nonatomic ,strong) NSNumber *pageSize;
@property (nonatomic ,strong) NSString *city;
@property (nonatomic ,strong) NSNumber *latitude;
@property (nonatomic ,strong) NSNumber *longitude;
@property (nonatomic ,strong) NSString *province;
@property (nonatomic ,strong) NSNumber *sort;
@property (nonatomic ,strong) NSString *county;
@property (nonatomic ,strong) NSString *tags;
@property (nonatomic ,strong) NSNumber *distance;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSNumber *active;

@end

/**
 *  @brief 药房搜索 add by lijian 2.2.0
 */
@interface searchStoreModelR : StoreModelR

@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;

@end

/**
 *  @brief 首页推荐药房列表
 */
@interface StoreOfferNameModelR : StoreModelR

@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *type;

@end

@interface StoreSearchModelR : StoreModelR

@property (nonatomic ,strong) NSString *groupId;

@end

@interface StoreComplaintTypeModelR : StoreModelR

@end

//投诉药店的内容
@interface StoreComplainModelR : StoreModelR

@property (nonatomic ,strong) NSString *groupId;
@property (nonatomic ,strong) NSString *type;
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,strong) NSString *token;

@end





