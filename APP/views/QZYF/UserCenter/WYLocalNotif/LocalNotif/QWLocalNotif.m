//
//  QWLocalNotif.m
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWLocalNotif.h"
#import "Warning.h"
#import "UserDefault.h"
static NSInteger kMaxDays = 90;

@implementation QWLocalNotif

+ (instancetype)instance{
    static id sharedInstance;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)invokeAsyncVoidBlock:(void(^)())block
                     success:(void(^)())success
{
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^(void) {
        if (block) {
            block();
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               if (success) {
                                   success();
                               }
                           });
        }
    });
}

//设置闹钟
- (void)setLocalNotifications:(NSArray*)list ok:(void(^)())ok{
    [self invokeAsyncVoidBlock:^{
        [self setLocalNotifications:list];
    } success:ok];
}

//按列表群加闹钟
- (void)setLocalNotifications:(NSArray*)list{
    if (list == nil || list.count == 0) {
        [self resetLocalNotifList:nil];
        return;
    }
    
    NSMutableArray *arr=[NSMutableArray array];
    for (id obj in list) {
        if ([obj isKindOfClass:[WYLocalNotifModel class]]) {
            WYLocalNotifModel *mode=obj;
            if (!mode.clockEnabled)
                continue;
            
            NSMutableArray *tmp=nil;//[NSMutableArray array];
            if (mode.numCycle.intValue==1 || mode.numCycle.intValue==7) {
                tmp=[self createRepeatLN:mode];
            }
            else {
                tmp=[self createNORepeatLN:mode];
            }

            
            if (tmp && tmp.count>0) {
                [arr addObjectsFromArray:tmp];
            }
        }
    }
    
    [self resetLocalNotifList:arr];
}

//可循环闹钟
- (NSMutableArray *)createRepeatLN:(WYLocalNotifModel*)mode{
    NSMutableArray *arr=[NSMutableArray array];
    
    for (NSString *str in mode.listTimes) {
        NSString *tt=[NSString stringWithFormat:@"%@ %@",mode.beginDate,str];
        NSDate *dt1=[self dateFromString:tt format:nil];

        UILocalNotification *aLN = [self createLocalNotif:mode date:dt1];
        if (aLN) {
            [arr addObject:aLN];
        }
    }
    
    return arr;
}

//不可循环闹钟
- (NSMutableArray*)createNORepeatLN:(WYLocalNotifModel*)mode{
    NSMutableArray *arr=[NSMutableArray array];
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    
    if (ln == nil)
        return nil;
    
    for (NSString *str in mode.listTimes) {
        NSString *tt=[NSString stringWithFormat:@"%@ %@",mode.beginDate,str];
        
        NSInteger cycle=0;
        if (mode.numCycle.integerValue>0)
            cycle=kMaxDays/mode.numCycle.integerValue;
        

        NSDate *dt1=[self dateFromString:tt format:nil];
        NSDate *dt2=[self getNewDate:dt1 nextDay:mode.numCycle.integerValue];
        
        while (cycle-- > 0) {
            UILocalNotification *aLN = [self createLocalNotif:mode date:dt2];
            if (aLN) {
                [arr addObject:aLN];
            }
            
            dt2=[self date:dt2 nextDay:mode.numCycle.integerValue];

        }
    }
    
    return arr;
}

//创建闹钟
- (UILocalNotification *)createLocalNotif:(WYLocalNotifModel*)mode date:(NSDate*)date{
    if (mode == nil)
        return nil;
    
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    if (ln == nil)
        return nil;
    
    if (date==nil)
        date=[NSDate date];
    
    NSString *alertBody=[NSString stringWithFormat:kAlert1,mode.productUser,mode.productName];
    
    ln.fireDate = date;
    ln.timeZone = [NSTimeZone defaultTimeZone];
    ln.alertBody = alertBody;

    ln.soundName = @"LN01.caf";//UILocalNotificationDefaultSoundName;
    if ([QWUserDefault getBoolBy:APP_Alarm_SOUND_ENABLE] == NO) {
        ln.soundName =nil;
    }


    if (mode.numCycle.intValue==1) {
        ln.repeatInterval=NSDayCalendarUnit;
    }
    else if (mode.numCycle.intValue==7) {
        ln.repeatInterval=NSWeekCalendarUnit;
    }

    ln.userInfo = mode.dictionaryModel;
    
    return ln;
}

//重置
- (void)resetLocalNotifList:(NSArray*)list{
    [[UIApplication sharedApplication] setScheduledLocalNotifications:nil];
    [[UIApplication sharedApplication] setScheduledLocalNotifications:list];
}

- (void)checkAllLocalNotif{
    NSArray *arr=[[UIApplication sharedApplication] scheduledLocalNotifications];
    DDLogVerbose(@"##### checkAllLocalNotif #####: %lu",(unsigned long)arr.count);

    return;
    
}

//删除所有闹钟
- (void)removeAllLocalNotif{

    [self invokeAsyncVoidBlock:^{
        NSArray *arr=[[UIApplication sharedApplication] scheduledLocalNotifications];
        DDLogVerbose(@"准备移除闹钟: %lu",(unsigned long)arr.count);
        [[UIApplication sharedApplication] setScheduledLocalNotifications:nil];

    } success:^{
        DDLogVerbose(@"闹钟已全部移除");
    }];
    
    
}

#pragma mark - 重置闹钟
- (void)resetAllLN{
    NSArray *list=[self getLNList];
    if (list) {
        [[QWLocalNotif instance] setLocalNotifications:list ok:^{
            //重置成功
        }];
    }
}

#pragma mark db
//获取闹钟数据。先db取数据，没有在UserDefault取老数据，并保存db
- (NSArray *)getLNList{
    NSArray *list=nil;
    list= [WYLocalNotifModel getArrayFromDBWithWhere:nil];

    if (list.count==0){
        list=[QWUserDefault getObjectBy:kQWGlobalLocalNotification];
        
        if (list.count==0) {
            return nil;
        }
        else {
            //老数据6改4
            for (WYLocalNotifModel *mm in list) {
                if (mm.listTimes.count>4) {
 
                    NSMutableArray *tmp=[[NSMutableArray alloc]initWithCapacity:4];
                    for (int i =0; i<4; i++) {
                        [tmp addObject:mm.listTimes[i]];
                    }
                    mm.listTimes=[tmp mutableCopy];
                }
            }
            
            //把老数据保存db
            [self saveLNList:list];
        }
    }

    return list;
}
//保存闹钟数据
- (void)saveLNList:(NSArray*)arrList{
    [WYLocalNotifModel deleteAllObjFromDB];
    [WYLocalNotifModel insertToDBWithArray:arrList filter:^(id model, BOOL inseted, BOOL *rollback) {
        
    }];
}
#pragma mark - 时间
//比对当前时间获取下次闹钟时间
- (NSDate *)getNextLN:(WYLocalNotifModel*)mode{
    //获取开始时间
    NSString *begin=mode.beginDate;
    if (mode.numCycle.intValue==1) {
        begin=[self dateToString:[NSDate date]];
    }


    NSDate *newDt=nil;
    //以开始时间加闹钟点查下一次时间
    for (NSString *str in mode.listTimes) {
        NSString *tt=[NSString stringWithFormat:@"%@ %@",begin,str];
        NSDate *dt1=[self dateFromString:tt format:nil];
        NSComparisonResult cc=[dt1 compare:[NSDate date]];
        if (cc!=NSOrderedAscending) {
            newDt=dt1;
            break;
        }
    }
    
    //以循环周期查下一周期的闹钟时间
    if (newDt==nil) {
        for (NSString *str in mode.listTimes) {
            NSString *tt=[NSString stringWithFormat:@"%@ %@",begin,str];
            NSDate *dt1=[self dateFromString:tt format:nil];
            NSDate *dt2=[self getNewDate:dt1 nextDay:mode.numCycle.integerValue];
            NSComparisonResult cc=[dt2 compare:[NSDate date]];
            if (cc!=NSOrderedAscending) {
                newDt=dt2;
                break;
            }
        }
    }
    
    //以循环周期查下下周期的闹钟时间
    if (newDt==nil) {
        for (NSString *str in mode.listTimes) {
            NSString *tt=[NSString stringWithFormat:@"%@ %@",begin,str];
            NSDate *dt1=[self dateFromString:tt format:nil];
            NSDate *dt2=[self getNewDate:dt1 nextDay:mode.numCycle.integerValue];
            NSDate *dt3=[self date:dt2 nextDay:mode.numCycle.integerValue];
            NSComparisonResult cc=[dt3 compare:[NSDate date]];
            if (cc!=NSOrderedAscending) {
                newDt=dt3;
                break;
            }
        }
    }

    return newDt;
}
/**
 *  根据老时间和间隔天数，得到新日期
 *
 *  @param oldDate 老
 *  @param nDay    间隔
 *
 *  @return 新时间
 */
- (NSDate*)getNewDate:(NSDate*)oldDate nextDay:(NSInteger)nDay{
    NSDate *newDate=oldDate;
    
    if ([oldDate compare:[NSDate date]]<0) {
        //时间过期,需要重新计算周期
        NSInteger ds=[self intervalDay:oldDate]; //获取和现在时间间隔天数
        NSInteger dy=ds%nDay; //循环周期和现在时间差值

        if (dy) {
            newDate=[self date:oldDate nextDay:ds+(nDay-dy)];
        }
        else {
            //正好间隔是当天
            newDate=[self date:oldDate nextDay:ds];
        }
        
    }

    return newDate;
}

/**
 *  对比现在间隔多少天
 *
 *  @param aDate ;
 *
 *  @return 间隔天数
 */
- (NSInteger)intervalDay:(NSDate*)aDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];//
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:aDate
                                                 toDate:[NSDate date]
                                                options:0];
    return components.day;
}

- (NSDate *)date:(NSDate*)date nextDay:(NSInteger)day{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    NSDate *next = [gregorian dateByAddingComponents:components toDate:date options:0];
    return next;
}

- (NSString*)dateToString:(NSDate*)date{
    return [self dateToString:date format:@"yyyy-MM-dd"];
}

- (NSString*)dateToString:(NSDate*)date format:(NSString*)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone;
    
    //获取并设置时间的时区,获取系统时间
    timeZone = [NSTimeZone systemTimeZone];//
//    timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//
    [df setTimeZone:timeZone];
    
    if (format==nil)
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];//附加时区 @"yyyy-MM-dd'T'HH:mm:ssZ"
    else
        [df setDateFormat:format];
    
    return [df stringFromDate:date];
}

- (NSDate*)dateFromString:(NSString*)str {
    return [self dateFromString:str format:@"yyyy-MM-dd"];
}

- (NSDate*)dateFromString:(NSString*)str format:(NSString*)format {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if (format==nil)
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    else
        [df setDateFormat:format];
    
    NSTimeZone *timeZone;
    [df setTimeZone:[NSTimeZone systemTimeZone]];
//    timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//
    [df setTimeZone:timeZone];
    
    return [df dateFromString:str];
}


@end
