//
//  WYLNOtherCell.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "WYLocalNotifModel.h"
@protocol WYLNOtherCellDelegate <NSObject>
@optional
- (void)WYLNOtherCellDelegateTimes:(NSMutableArray*)list;
@end

@interface WYLNOtherCell : QWBaseTableCell<UIPickerViewDataSource,UIPickerViewDelegate>
@property (copy, nonatomic) NSString* time1;
@property (copy, nonatomic) NSString* time2;
@property (copy, nonatomic) NSString* time3;
@property (copy, nonatomic) NSString* time4;

@end
