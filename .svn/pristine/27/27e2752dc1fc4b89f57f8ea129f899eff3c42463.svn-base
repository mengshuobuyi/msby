//
//  InfoMsg.h
//  APP
//
//  Created by PerryChen on 1/8/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthinfoModel.h"
#import "InfoMsgModelR.h"
@interface InfoMsg : NSObject
+ (void)getAddedHealthInfoChannelList:(InfoMsgQueryUserChannelModelR *)param
              success:(void (^)(MsgChannelListVO *model))success
              failure:(void (^)(HttpException *))failure;
+ (void)getNotAddedHealthInfoChannelList:(InfoMsgQueryUserNotAddChannelModelR *)param
                              success:(void (^)(MsgChannelListVO *model))success
                              failure:(void (^)(HttpException *))failure;
+ (void)getMsgListWithChannelID:(InfoMsgListModelR *)param
                        success:(void (^)(MsgArticleListVO *model))success
                        failure:(void (^)(HttpException *))failure;
+ (void)updateUserMsgList:(InfoMsgUpdateUserChannelModelR *)param
                  success:(void (^)(MsgChannelListVO *model))success
                  failure:(void (^)(HttpException *))failure;

@end
