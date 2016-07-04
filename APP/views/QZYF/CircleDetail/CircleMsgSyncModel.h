//
//  CircleMsgSyncModel.h
//  APP
//
//  同步圈子消息的文件
//
//  Created by PerryChen on 3/25/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleModel.h"
#import "InfoMsgModelR.h"
@interface CircleMsgSyncModel : NSObject

@property (nonatomic, strong) NSArray *arrCircleMsg;            // 圈子消息列表

+ (CircleMsgSyncModel *)sharedInstance;

/**
 *  同步圈子消息列表
 *
 *  @param arrList
 */
- (void)syncCircleMsgList:(NSArray *)arrList;

/**
 *  获取全部的圈子消息缓存
 *
 *  @return
 */
- (NSArray *)getAllCircleMsgList;

/**
 *  轮询拉取圈子消息
 */
- (void)pullNewCircleMsgListWithParams:(InfoCircleNewMsgListModelR *)param
                               Success:(void(^)(CircleMsgListModel *model))success
                               failure:(void(^)(HttpException * e))failure;

/**
 *  全量拉取圈子消息
 */
- (void)pullAllCicleMsgListWithParams:(InfoCircleMsgListModelR *)param
                              Success:(void(^)(CircleMsgListModel *model))success
                              failure:(void(^)(HttpException * e))failure;

/**
 *  缓存最新的圈子消息
 *
 *  @param arrTeam
 */
- (void)saveCircleTeamMsg:(NSArray *)arrTeam;

/**
 *  获取最新的圈子消息
 *
 *  @return
 */
- (NSArray *)getNewestTeamMsg;

/**
 *  设置所有圈子消息已读
 */
- (void)updateAllMsgReadWithSuccess:(void(^)(BaseModel *model))success
                            failure:(void(^)(HttpException * e))failure;;

@end
