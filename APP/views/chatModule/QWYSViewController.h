//
//  QWYSViewController.h
//  APP
//
//  Created by carret on 15/5/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"

@interface QWYSViewController : QWBaseVC
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    NSIndexPath *_longPressIndexPath;
    
    NSInteger _recordingCount;
    
    dispatch_queue_t _messageQueue;
    
    NSMutableArray *_messages;
}
@property (strong, nonatomic) NSString *chatter;
@property (strong, nonatomic) NSMutableArray *dataSource;//tableView数据源
 /**
 *  消息的类型
 */
@property (nonatomic, assign) MessageShowType  showType;


- (void)reloadAvatar;
- (void)refeshingRecentMessage;

@end
