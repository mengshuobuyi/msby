//
//  CreditRecordTableCell.h
//  APP
//
//  Created by Martin.Liu on 15/12/3.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditModel.h"
@interface CreditRecordTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *recordTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *recordCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *recordTimeLabel;

- (void)setCell:(CreditRecordModel*)creditRecord;

@end
