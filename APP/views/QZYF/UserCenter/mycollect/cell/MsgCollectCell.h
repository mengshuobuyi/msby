//
//  MsgCollectCell.h
//  wenyao
//
//  Created by chenzhipeng on 14/12/29.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"

@interface MsgCollectCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet QWLabel *title;
@property (weak, nonatomic) IBOutlet QWLabel *introduction;
@property (weak, nonatomic) IBOutlet QWImageView *iconUrl;

@end
