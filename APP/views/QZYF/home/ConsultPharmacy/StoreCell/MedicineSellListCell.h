//
//  medicineTableViewCell.h
//  wenyao
//
//  Created by 李坚 on 14/12/8.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseTableCell.h"

@interface MedicineSellListCell : QWBaseTableCell
@property (weak, nonatomic) IBOutlet QWLabel *proName;
@property (weak, nonatomic) IBOutlet QWLabel *spec;
@property (weak, nonatomic) IBOutlet QWLabel *factory;
@property (weak, nonatomic) IBOutlet QWImageView *proImage;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;
@property (weak, nonatomic) IBOutlet QWLabel *tag;

@property (nonatomic ,strong) NSIndexPath *indexPath;

@end