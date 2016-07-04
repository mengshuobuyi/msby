//
//  QWLocalNotif.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

/**
 *  设置闹钟，每日/周循环闹钟会反复提示，非循环一次性闹钟，提示后从系统删除，再设置时间也没用
 */

#import <Foundation/Foundation.h>
#import "WYLocalNotifModel.h"

@protocol QWLocalNotifDelegate;

@protocol QWLocalNotifDelegate <NSObject>
@optional
- (void)QWLocalNotifDelegate:(id)LNDelegate;
@end

@interface QWLocalNotif : NSObject

+ (instancetype)instance;

- (NSString*)dateToString:(NSDate*)date format:(NSString*)format;
- (NSDate*)dateFromString:(NSString*)str format:(NSString*)format;
- (NSDate*)dateFromString:(NSString*)str;
- (NSString*)dateToString:(NSDate*)date;

//删除所有闹钟
- (void)removeAllLocalNotif;
//重置闹钟
- (void)setLocalNotifications:(NSArray*)list ok:(void(^)())ok;

//获取闹钟数据
- (NSArray *)getLNList;
//保存闹钟数据
- (void)saveLNList:(NSArray*)arr;
//比对当前时间获取下次闹钟时间
- (NSDate *)getNextLN:(WYLocalNotifModel*)mod;
#pragma mark - 重置闹钟
- (void)resetAllLN;
@end
