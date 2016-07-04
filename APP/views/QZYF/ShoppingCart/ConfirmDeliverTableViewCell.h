//
//  ConfirmDeliverTableViewCell.h
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface ConfirmDeliverTableViewCell :QWBaseTableCell

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDetail;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImage;

@end
