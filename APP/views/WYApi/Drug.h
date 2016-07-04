/*!
 @header Drug.h
 @abstract 药品相关接口
 @author .
 @version 1.00 2015/03/06  (1.00)
 */

#import "HttpClient.h"
#import "DrugModel.h"
#import "DrugModelR.h"

/**
 *  接口注释规范
 *
 *  1、头文件要加                             //"注释"
 *  2、实现类里要加                           #pragma mark "注释"
 *  3、接口宏要加同样的注释                     //"注释"
 */

/**
*  接口定义规范
*
*  1、函数名对应接口文档
*  2、请求参数对应接口请求对象（和接口文档数据对应）
*  3、返回数据对应返回数据对象
*/


@interface Drug : NSObject
//----------健康方案---------------------------------------------------------------------------------
/**
 *  3.9.1	健康方案列表
 */
+ (void)queryRecommendClassWithParam:(HealthyScenarioModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;


/**
 *  3.9.2   健康知识
 */
+ (void)queryRecommendKnowledgeWithParam:(HealthyScenarioDiseaseModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;



/**
 *  3.9.3   健康方案的药品列表
 */
+ (void)queryRecommendProductByClassWithParam:(HealthyScenarioDrugModelR *)params success:(void(^)(id))success failure:(void(^)(HttpException *e))failure;



//--------------药品列表
+ (void)queryProductFirstWithParam:(id)model
                             Success:(void(^)(id DFUserModel))success
                             failure:(void(^)(HttpException * e))failure;


/**
 *  @brief (3.3.17) 查询二级商品分类 (2.0接口)  Create By Meng
 */
+(void)queryProductSecondWithParam:(id)model
                           Success:(void(^)(id DFUserModel))success
                           failure:(void(^)(HttpException * e))failure;


//根据classId获取药品列表
+ (void)queryProductByClassWithParam:(id)model
                             Success:(void(^)(id DFUserModel))success
                             failure:(void(^)(HttpException * e))failure;


/**
 *  @brief 根据商品分类ID，查找相应的生产厂家
 */
+ (void)fetchProFactoryByClassWithParam:(id)model
                                Success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;


//商品详情
+(void)queryProductDetailWithParam:(id)model
                               Success:(void (^)(id DFModel))success
                               failure:(void (^)(HttpException *e))failure;



//搜索的接口
/**
 *  快速自查3.3.1	搜索关键字联想(OK)
 */
+ (void)getsearchKeywordsWithParam:(id)model
                           Success:(void(^)(id DFUserModel))success
                           failure:(void(^)(HttpException * e))failure;


//3.3.40	根据关键字ID获取商品列表
+ (void)queryProductByKwIdWithParam:(id)model
                            Success:(void(^)(id DFUserModel))success
                            failure:(void(^)(HttpException * e))failure;


//3.3.15	疾病组方配方用药查询(OK)
+ (void)queryDiseaseFormulaProductListWithParam:(id)model
                                        Success:(void(^)(id DFUserModel))success
                                        failure:(void(^)(HttpException * e))failure;


//3.3.19	疾病相关商品（治疗用药）
+ (void)queryDiseaseProductListWithParam:(id)model
                                 Success:(void(^)(id DFUserModel))success
                                 failure:(void(^)(HttpException * e))failure;

//-----------------------------------------------------------------------------------------------------------------



//**czp的扫码的两个接口************************************************************************************************************

//扫码获取商品信息
+(void)queryProductByBarCodeWithParam:(NSDictionary *)params
                              Success:(void(^)(id DFUserModel))success
                              failure:(void(^)(HttpException * e))failure;

//获取商品的用法用量
+(void)getProductUsageWithParam:(id)model
                        Success:(void(^)(id DFUserModel))success
                        failure:(void(^)(HttpException * e))failure;



//我的用药添加用药时的接口     (已经更换2.0版本 by解)
+ (void)queryProductByKeywordWithParam:(QueryProductByKeywordModelR *)params
                               Success:(void(^)(id DFUserModel))success
                               failure:(void(^)(HttpException * e))failure;


//药店畅销商品 区域畅销商品（附近药店）

+(void)drugSellListWithParam:(id)model
                     Success:(void (^)(id DFModel))success
                     failure:(void (^)(HttpException *e))failure;

//********************************************************************************************************************************


///api/drug/similarDrugs 同效药列表 App2.2.0版本
+(void)similarDrugs:(id)model
                     Success:(void (^)(id DFModel))success
                     failure:(void (^)(HttpException *e))failure;






@end
