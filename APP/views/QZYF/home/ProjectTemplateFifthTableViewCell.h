//
//  ProjectTemplateFifthTableViewCell.h
//  APP
//
//  Created by garfield on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface ProjectTemplateFifthTableViewCell : QWBaseTableCell

@property (weak, nonatomic) IBOutlet QWButton *button1;
@property (weak, nonatomic) IBOutlet QWButton *button2;
@property (weak, nonatomic) IBOutlet QWButton *button3;
@property (weak, nonatomic) IBOutlet QWButton *button4;

- (void)setCell:(id)data withTarget:(id)target;

@end
