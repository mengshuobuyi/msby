//
//  DetialRullCell.h
//  APP
//
//  Created by qw_imac on 15/12/2.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditModel.h"
@interface DetialRullCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *LabelOne;

-(void)setDetailUiWith:(MyLevelDetailVo *)vo;
@end
