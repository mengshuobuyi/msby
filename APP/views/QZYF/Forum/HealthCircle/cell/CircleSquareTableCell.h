//
//  CircleSquareTableCell.h
//  APP
//
//  Created by Martin.Liu on 16/6/21.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAButtonWithTouchBlock.h"

@interface CircleSquareTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet MAButtonWithTouchBlock *careCircleBtn;
- (void)setCell:(id)obj;
@end
