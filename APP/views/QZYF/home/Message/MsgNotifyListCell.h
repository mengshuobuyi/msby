//
//  MsgNotifyListCell.h
//  APP
//
//  Created by PerryChen on 6/16/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"
#import "MGSwipeTableCell.h"
@interface MsgNotifyListCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewRedPoint;

@end
