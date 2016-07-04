//
//  QWGetTokenExt.m
//  APP
//
//  Created by PerryChen on 9/21/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWGetTokenExt.h"
#define SUCCESS 0
#define UNKNOWN_ERROR 1
#define OPEN_SMS_FAIL_ERROR 2
@implementation QWGetTokenExt
-(void)getTokenInfo:(NSArray *)arguments withDict:(NSDictionary *)options
{
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    DDLogVerbose(@"teh str params is %@",options);
    NSString *strToken = @"";
    if (QWGLOBALMANAGER.configure.userToken.length > 0) {
        strToken = QWGLOBALMANAGER.configure.userToken;
    }
    [self callBackSuccess:strToken];
}

- (void)callBackSuccess:(NSString *)token
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self writeScript:self.jsCallbackId_ messageString:[self message:token state:YES] state:SUCCESS keepCallback:NO];
        
    });
}

- (NSString*)message:(NSString *)strToken state:(BOOL)state{
    NSString *strPassport = @"";
    if (QWGLOBALMANAGER.configure.passPort.length > 0) {
        strPassport = QWGLOBALMANAGER.configure.passPort;
    }
    NSString *strPhone = @"";
    if (QWGLOBALMANAGER.configure.mobile.length > 0) {
        strPhone = QWGLOBALMANAGER.configure.mobile;
    }
    
    NSMutableDictionary *dd=[NSMutableDictionary dictionary];
    dd[@"token"]=strToken;
    dd[@"passportId"]=strPassport;
    dd[@"mobile"]=strPhone;
    NSString *jsonString = nil;
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dd options:NSJSONWritingPrettyPrinted error:&error];
    if([jsonData length] > 0 && error == nil) {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    return jsonString;
}

@end
