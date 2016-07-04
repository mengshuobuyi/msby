//
//  QWCallbackPluginExt.h
//  APP
//
//  Created by PerryChen on 8/28/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWJSExtension.h"
#import "WebDirectMacro.h"

/**
 h5需要回调，并且native回调给h5的插件
 */

@interface QWCallbackPluginExt : QWJSExtension
@property (nonatomic, copy) NSString *jsCallbackId_;
-(void):(NSArray *)arguments withDict:(NSDictionary *)options;
-(void)runExtWithCallBackId:(CallbackType)callbackType;
-(void)runExtWithCallBackPageType:(NSString *)strPageType;
@end
