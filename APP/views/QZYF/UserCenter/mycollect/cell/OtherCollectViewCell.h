//
//  OtherCollectViewCell.h
//  wenyao
//
//  Created by Meng on 14-10-2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"
@interface OtherCollectViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet QWLabel *titleLabel;
@property (weak, nonatomic) IBOutlet QWLabel *subTitleLabel;
- (void)setDiseaseCell:(id)data;
@end
