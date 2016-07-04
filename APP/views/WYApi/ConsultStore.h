//
//  ConsultStore.h
//  APP
//
//  Created by 李坚 on 16/1/5.
//  Copyright © 2016年 carret. All rights reserved.
//
#import "ConsultStoreModelR.h"
#import "ConsultStoreModel.h"
#import "FavoriteModelR.h"

@interface ConsultStore : NSObject
/**
 *  微商店药房详情首页 add by xiezhenghong
 *  V4.0.0
 */
+ (void)MallBranchIndexNew:(CategoryModelR *)model
                   success:(void (^)(MicroMallBranchNewIndexVo *))success
                   failure:(void (^)(HttpException *))failure;
/**
 *  根据商品编码关联药房下是否有售数据请求 add by lijian
 *  V4.0
 */
+ (void)CodeAtBranchIsSale:(BranchProModelR *)model
                   success:(void (^)(BranchProVo *))success
                   failure:(void (^)(HttpException *))failure;
/**
 *  切换药房-附近药房Tab列表数据 add by lijian
 *  V4.0
 */
+ (void)MallBranchs:(NearByStoreModelR *)model
            success:(void (^)(MicroMallBranchListVo *))success
            failure:(void (^)(HttpException *))failure;
/**
 *  切换药房-我的药房Tab列表数据 add by lijian
 *  V4.0
 */
+ (void)CollectedBranchList:(FavoriteModelR *)modelR
                    success:(void(^)(id))success
                    failure:(void(^)(HttpException * e))failure;
/**
 *  切换药房-连锁药房Tab列表数据 add by lijian
 *  V4.0
 */
+ (void)ChainBranchs:(NearByStoreModelR *)model
             success:(void (^)(MicroMallBranchListVo *))success
             failure:(void (^)(HttpException *))failure;
/**
 *  收藏药房(check是否被收藏) add by lijian
 *  V4.0
 */
+ (void)checkCollectBranch:(NSString *)branchId
                   success:(void(^)(id))success
                   failure:(void(^)(HttpException * e))failure;
/**
 *  收藏药房(添加收藏) add by lijian
 *  V4.0
 */
+ (void)CollectBranch:(NSString *)branchId
              success:(void(^)(id))success
              failure:(void(^)(HttpException * e))failure;
/**
 *  收藏药房(取消收藏) add by lijian
 *  V4.0
 */
+ (void)CancelCollectBranch:(NSString *)branchId
                    success:(void(^)(id))success
                    failure:(void(^)(HttpException * e))failure;
/**
 *  切换药房-搜索功能 add by lijian
 *  V4.0
 */
+ (void)MallSearch:(MallSearchModelR *)model success:(void (^)(MicroMallBranchListVo *))success failure:(void (^)(HttpException *))failure;
/**
 *  药房下专家列表 add by lijian
 *  V3.2.0
 */
+ (void)branchExpertList:(GroupModelR *)model success:(void (^)(ExpertListVo *))success failure:(void (^)(HttpException *))failure;
/**
 *  药房详情公告 add by lijian
 *  V3.1
 */
+ (void)branchContent:(CategoryModelR *)model success:(void (^)(BranchNoticeVO *))success failure:(void (^)(HttpException *))failure;
/**
 *  微商店内商品分类List add by lijian
 *  V3.1
 */
+ (void)MallClassifyList:(CategoryModelR *)model success:(void (^)(DrugClassifyList *))success failure:(void (^)(HttpException *))failure;

/**
 *  微商店内商品根据分类获取相关药品列表(普通商品，分页) add by lijian
 *  V3.1
 */
+ (void)MallProductByClassify:(CategoryNormalProductModelR *)model success:(void (^)(BranchProductList *))success failure:(void (^)(HttpException *))failure;
/**
 *  微商店内商品获取套餐列表(不分页) add by lijian
 *  V3.1
 */
+ (void)MallProductByPackage:(CategoryModelR *)model success:(void (^)(CartPackageList *))success failure:(void (^)(HttpException *))failure;
/**
 *  根据编码搜索详情 add by lijian
 *  V3.0
 */
+ (void)MedicineDetailByCode:(ProductByCodeModelR *)model success:(void (^)(BranchProductVo *))success failure:(void (^)(HttpException *))failure;
/**
 *  源生商品详情 add by lijian
 *  V3.0
 */
+ (void)StoreProductDetail:(ProductModelR *)model success:(void (^)(MicroMallBranchProductVo *))success failure:(void (^)(HttpException *))failure;
/**
 *  举报药房原因列表 add by lijian
 *  V3.0
 */
+ (void)reportReasonList:(ReportReasonModelR *)model success:(void (^)(ComplaintReasonList *))success failure:(void (^)(HttpException *))failure;
/**
 *  举报药房提交数据 add by lijian
 *  V3.0
 */
+ (void)reportBranch:(ReportBranchModelR *)model success:(void (^)(BaseAPIModel *))success failure:(void (^)(HttpException *))failure;
/**
 *  微商药房详情 add by lijian
 *  V3.0
 */
+ (void)MallBranchDetail:(MallProductSearchModelR *)model success:(void (^)(BranchDetailVO *))success failure:(void (^)(HttpException *))failure;
/**
 *  比价页面的附近药房
 *  V3.0
 */
+ (void)BranchListByCode:(ProductByCodeBranchModelR *)model success:(void (^)(OnSaleBranchListVo *))success failure:(void (^)(HttpException *))failure;
@end
