//
//  ProductOrderCell.h
//  wenyao
//
//  Created by Meng on 15/1/22.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTableCell.h"
@interface ProductOrderCell : QWBaseTableCell
@property (weak, nonatomic) IBOutlet QWLabel *proName;

@property (weak, nonatomic) IBOutlet QWLabel *type;

@property (weak, nonatomic) IBOutlet QWLabel *couponStr;
@property (weak, nonatomic) IBOutlet QWLabel *date;

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;
@property (weak, nonatomic) IBOutlet UIView *bgContent;

@end
