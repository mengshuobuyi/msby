//
//  Problem.h
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "ProblemModel.h"
#import "ProblemModelR.h"

@class ProblemModuleR;
@class ProblemListModelR;
@class ProblemDetailModelR;

@interface Problem : NSObject

//问题类型
+ (void)moduleClassWithParams:(ProblemModuleR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;

//首页问题模块
+ (void)moduleHomeClassWithParams:(ProblemHomeModuleR *)param
                      success:(void (^)(id array))success
                      failure:(void (^)(HttpException *))failure;

//常见用药问题列表
+ (void)listWithParams:(ProblemListModelR *)param
               success:(void (^)(id))success
               failure:(void (^)(HttpException *))failure;

//问题详情
+ (void)detailWithParams:(ProblemDetailModelR *)param
                 success:(void (^)(id))success
                 failure:(void (^)(HttpException *))failure;

//+ (void)spmAssociationDiseaseWithParams:(id)param
//                                success:(void (^)(id resultOBJ))success
//                                failure:(void (^)(HttpException *))failure;

/**
 *  大家都在问列表 新接口
 *
 */
+ (void)ProblemListByModuleWithParams:(NSDictionary *)param
                              success:(void(^)(id obj))success
                              failure:(void(^)(HttpException * e))failure;

@end
