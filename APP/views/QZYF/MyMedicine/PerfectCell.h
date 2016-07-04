//
//  PerfectCell.h
//  APP
//
//  Created by carret on 15/8/19.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseCell.h"
#import "MGSwipeTableCell.h"
@interface PerfectCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet QWImageView *imgUrl;

@property (weak, nonatomic) IBOutlet QWLabel *name;
@property (weak, nonatomic) IBOutlet QWLabel *spec;
@property (weak, nonatomic) IBOutlet QWLabel *medicineTag;
@property (weak, nonatomic) IBOutlet UIButton *perfBtn;

@end
