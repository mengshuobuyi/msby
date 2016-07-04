//
//  OutOfDateTableCell.h
//  APP
//
//  Created by garfield on 15/6/12.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"
@interface OutOfDateTableCell : MGSwipeTableCell

@property (nonatomic, strong) IBOutlet QWLabel       *consultFormatShowTime;
@property (nonatomic, strong) IBOutlet QWLabel       *consultTitle;
@property (nonatomic, weak) IBOutlet UIImageView *sendIndicateImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
