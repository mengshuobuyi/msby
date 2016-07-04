//
//  ConsultPTP.h
//  APP
//
//  Created by carret on 15/6/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "HttpClient.h"
#import "ConsultPTPModel.h"
#import "ConsultPTPR.h"

@interface ConsultPTP : NSObject
//p2p  全量拉取消息
+ (void)getByPhar:(GetByPharModelR *)param
          success:(void (^)(CustomerSessionDetailList *responModel))succsee
          failure:(void (^)(HttpException *e))failure;

// 全量获取P2P列表
+ (void)getAllSessionList:(GetAllSessionModelR *)param
                  success:(void (^)(MessageList *responModel))success
                  failure:(void (^)(HttpException *e))failure;
// 增量获取P2P列表
+ (void)getNewSessionList:(GetNewSessionModelR *)param
                  success:(void (^)(CustomerSessionList *responModel))success
                  failure:(void (^)(HttpException *e))failure;
//p2p增量拉取消息
+ (void)pollBySessionId:(PollBySessionidModelR *)param
                success:(void (^)(CustomerSessionDetailList *responModel))succsee
                failure:(void (^)(HttpException *e))failure;
+ (void)ptpMessagetCreate:(PTPCreate *)param
                  success:(void (^)(DetailCreateResult *responModel))succsee
                  failure:(void (^)(HttpException *e))failure;
+ (void)ptpMessagetRead:(PTPRead *)param
                success:(void (^)(ApiBody *responModel))succsee
                failure:(void (^)(HttpException *e))failure;
+ (void)ptpMessagetRemove:(PTPRemove *)param
                  success:(void (^)(ApiBody *responModel))succsee
                  failure:(void (^)(HttpException *e))failure;

//   /api/message/removeByType 消息盒子删除：按类型全部删除
+ (void)removeByType:(RemoveByTypeR *)param
                  success:(void (^)(ApiBody *responModel))succsee
                  failure:(void (^)(HttpException *e))failure;
@end
