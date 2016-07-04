//
//  FeedBack.m
//  APP
//
//  Created by qwfy0006 on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FeedBack.h"
#import "FeedBackModelR.h"

@implementation FeedBack

+ (void)SubmitFeedbackWithParams:(FeedBackModelR *)param
                         success:(void (^)(id))success
                         failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:NW_submitFeedback
                               params:[param dictionaryModel]
                              success:^(id resultObj) {
                                  
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}



@end
