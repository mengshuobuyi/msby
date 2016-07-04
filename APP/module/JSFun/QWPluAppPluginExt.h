//
//  QWPluAppPluginExt.h
//  APP
//
//  Created by PerryChen on 8/25/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWJSExtension.h"
/**
 h5请求拨打电话，替换标题，弹框，获取分享内容的插件
 */
@class WebDirectViewController;
@interface QWPluAppPluginExt : QWJSExtension
@property (nonatomic, copy) NSString *jsCallbackId_;
-(void)startAppPlugin:(NSArray *)arguments withDict:(NSDictionary *)options;

@end
