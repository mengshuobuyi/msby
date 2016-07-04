//
//  WYLNTimeCell.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "WYLocalNotifModel.h"
@interface WYLNTimesCell : QWBaseTableCell
{
    IBOutlet UIView *vTimes;
}

@property (nonatomic, strong) IBOutlet  QWLabel         *time;
- (void)setCell:(WYLocalNotifModel*)mode;
@end
