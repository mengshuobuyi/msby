//
//  InfoMsg.m
//  APP
//
//  Created by PerryChen on 1/8/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "InfoMsg.h"
#import "QWGlobalManager.h"
@implementation InfoMsg
+ (void)getAddedHealthInfoChannelList:(InfoMsgQueryUserChannelModelR *)param
              success:(void (^)(MsgChannelListVO *model))success
              failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    DDLogVerbose(@"the params is %@",param);
//    [QWGLOBALMANAGER syncInfoChannelList];
    [[HttpClient sharedInstance] getWithSecretWithUrl:InfoQueryUserChannel params:[param dictionaryModel] success:^(id obj) {
        MsgChannelListVO *listModel = [MsgChannelListVO parse:obj Elements:[MsgChannelVO class] forAttribute:@"list"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)getNotAddedHealthInfoChannelList:(InfoMsgQueryUserNotAddChannelModelR *)param
                                 success:(void (^)(MsgChannelListVO *model))success
                                 failure:(void (^)(HttpException *))failure
{
//    [QWGLOBALMANAGER syncInfoChannelList];
    HttpClientMgr.progressEnabled = NO;
    DDLogVerbose(@"the params is %@",param);
    [[HttpClient sharedInstance] getWithSecretWithUrl:InfoQueryAllChannel params:[param dictionaryModel] success:^(id obj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([MsgChannelVO class])];
        [keyArr addObject:NSStringFromClass([MsgChannelVO class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"list"];
        [valueArr addObject:@"listNoAdd"];
        MsgChannelListVO *listModel = [MsgChannelListVO parse:obj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)getMsgListWithChannelID:(InfoMsgListModelR *)param
                        success:(void (^)(MsgArticleListVO *model))success
                        failure:(void (^)(HttpException *))failure
{
//    [QWGLOBALMANAGER syncInfoChannelList];
    DDLogVerbose(@"the params is %@",param);
    [[HttpClient sharedInstance] get:InfoGetMsgList params:[param dictionaryModel] success:^(id obj) {
        MsgArticleListVO *listModel = [MsgArticleListVO parse:obj Elements:[MsgArticleVO class] forAttribute:@"list"];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)updateUserMsgList:(InfoMsgUpdateUserChannelModelR *)param
                  success:(void (^)(MsgChannelListVO *model))success
                  failure:(void (^)(HttpException *))failure
{
    HttpClientMgr.progressEnabled = NO;
    DDLogVerbose(@"the params is %@",param);
    [[HttpClient sharedInstance] post:InfoUpdateUserChannel params:[param dictionaryModel] success:^(id obj) {
        NSMutableArray *keyArr = [NSMutableArray array];
        [keyArr addObject:NSStringFromClass([MsgChannelVO class])];
        [keyArr addObject:NSStringFromClass([MsgChannelVO class])];
        
        NSMutableArray *valueArr = [NSMutableArray array];
        [valueArr addObject:@"list"];
        [valueArr addObject:@"listNoAdd"];
        MsgChannelListVO *listModel = [MsgChannelListVO parse:obj ClassArr:keyArr Elements:valueArr];
        if (success) {
            success(listModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
@end
