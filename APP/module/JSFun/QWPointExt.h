//
//  QWPointExt.h
//  APP
//
//  Created by PerryChen on 9/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWJSExtension.h"
/**
 h5返回统计id的插件
 */
@interface QWPointExt : QWJSExtension
@property (nonatomic, copy) NSString *jsCallbackId_;
-(void)getPointInfo:(NSArray *)arguments withDict:(NSDictionary *)options;
@end
