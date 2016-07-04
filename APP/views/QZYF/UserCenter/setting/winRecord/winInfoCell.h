//
//  winInfoCell.h
//  APP
//
//  Created by qw_imac on 15/11/10.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface winInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *winDate;
@property (weak, nonatomic) IBOutlet UILabel *winTitle;
@property (weak, nonatomic) IBOutlet UILabel *winSource;
-(void)setCell:(id)data;
@end
