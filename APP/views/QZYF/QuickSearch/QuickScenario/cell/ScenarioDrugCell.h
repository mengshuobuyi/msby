//
//  ScenarioDrugCell.h
//  APP
//
//  Created by caojing on 15-3-10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface ScenarioDrugCell : QWBaseTableCell
@property (weak, nonatomic) IBOutlet QWLabel *desc;
@property (weak, nonatomic) IBOutlet QWImageView *imgPath;
@property (weak, nonatomic) IBOutlet QWLabel *name;
@property (weak, nonatomic) IBOutlet QWImageView *backImg;


- (void)setDrugCell:(id)data row:(NSInteger)number;

@end
