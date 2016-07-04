//
//  QWPointExt.m
//  APP
//
//  Created by PerryChen on 9/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWPointExt.h"
#import "SVProgressHUD.h"

@implementation QWPointExt
-(void)getPointInfo:(NSArray *)arguments withDict:(NSDictionary *)options
{
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    NSString *strTrackID = options[@"key"];
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    if (options[@"property"]!=nil) {
        NSDictionary *dicProperty = options[@"property"];
        if ([dicProperty isKindOfClass:[NSDictionary class]]) {
            tdParams = (NSMutableDictionary *)dicProperty;
        } else {
            tdParams = [NSMutableDictionary dictionaryWithObject:dicProperty forKey:@"KEY"];
        }
        
    }
    
    [QWGLOBALMANAGER statisticsEventId:strTrackID withLable:@"H5" withParams:tdParams];

}
@end
