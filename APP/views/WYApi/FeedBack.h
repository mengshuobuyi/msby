//
//  FeedBack.h
//  APP
//
//  Created by qwfy0006 on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
@class FeedBackModelR;

@interface FeedBack : NSObject

/**
 *  添加意见反馈
 *
 */
+ (void)SubmitFeedbackWithParams:(FeedBackModelR *)param
                         success:(void (^)(id))success
                         failure:(void (^)(HttpException *))failure;

@end
