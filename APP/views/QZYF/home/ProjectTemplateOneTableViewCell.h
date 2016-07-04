//
//  ProjectTemplateOneTableViewCell.h
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface ProjectTemplateOneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet QWButton *button1;
@property (weak, nonatomic) IBOutlet QWButton *button2;
@property (weak, nonatomic) IBOutlet QWButton *button3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstaint;


- (void)setCell:(id)data withTarget:(id)target;

@end
