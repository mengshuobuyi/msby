//
//  Disease.h
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "DiseaseModel.h"
#import "DiseaseModelR.h"

@interface Disease : NSObject

//3.3.42	根据关键字ID获取疾病列表------------------------------------------------------------------------------------------
+(void)queryDiseasekwIdWithParam:(id)param
                         success:(void (^)(id))success
                         failure:(void (^)(HttpException *))failure;



//疾病分类查询
+ (void)queryDiseaseClassWithParams:(DiseaseClassModelR *)param
                      success:(void (^)(id))success
                      failure:(void (^)(HttpException *))failure;

//疾病百科
+ (void)queryAllDiseaseWithParams:(DiseaseViKiModelR *)param
                            success:(void (^)(id obj))success
                            failure:(void (^)(HttpException *e))failure;

//疾病的详细内容
+ (void)getDiseaseDetailIOSWithParam:(id)param
                             success:(void(^)(id obj))success
                             failure:(void(^)(HttpException *e))failure;

//根据症状关联的可能的疾病
+ (void)queryAssociationDiseaseWithParams:(PossibleDiseaseR *)param
                                  success:(void (^)(id))success
                                  failure:(void (^)(HttpException *))failure;

//------------------------------------------------------------------------------------------







@end
