//
//  QWDevicePluginExt.m
//  APP
//
//  Created by PerryChen on 9/7/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWDevicePluginExt.h"
#define SUCCESS 0
#define UNKNOWN_ERROR 1
#define OPEN_SMS_FAIL_ERROR 2
@implementation QWDevicePluginExt
-(void)getDeviceInfo:(NSArray *)arguments withDict:(NSDictionary *)options
{
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    DDLogVerbose(@"teh str params is %@",options);
    DeviceInfoWebModel *modelInfo = [DeviceInfoWebModel new];
    modelInfo.uuid = QWGLOBALMANAGER.deviceToken;
    modelInfo.platform = @"1";
    modelInfo.appVersion = APP_VERSION;
    [self callBackSuccess:modelInfo];
}

- (void)callBackSuccess:(DeviceInfoWebModel*)model
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self writeScript:self.jsCallbackId_ messageString:[self message:model state:YES] state:SUCCESS keepCallback:NO];
        
    });
}

- (NSString*)message:(DeviceInfoWebModel*)model state:(BOOL)state{
    NSMutableDictionary *dd=[NSMutableDictionary dictionary];
    if (model.uuid) dd[@"uuid"]=model.uuid;
    if (model.platform) dd[@"platform"]=model.platform;
    if (model.appVersion) dd[@"appVersion"]=model.appVersion;
    
    NSString *jsonString = nil;
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dd options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil) {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    return jsonString;
}

@end
