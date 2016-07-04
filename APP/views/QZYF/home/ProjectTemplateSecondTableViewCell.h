//
//  ProjectTemplateSecondTableViewCell.h
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface ProjectTemplateSecondTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet QWButton *button1;
@property (weak, nonatomic) IBOutlet QWButton *button2;
@property (weak, nonatomic) IBOutlet QWButton *button3;
@property (weak, nonatomic) IBOutlet QWButton *button4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;

- (void)setCell:(id)data withTarget:(id)target;

@end
