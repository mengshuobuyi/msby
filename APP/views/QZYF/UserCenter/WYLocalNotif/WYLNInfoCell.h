//
//  WYLNInfoCell.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/2.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "WYLocalNotifModel.h"
@interface WYLNInfoCell : QWBaseTableCell
{
    IBOutlet  UILabel         *lblCycleTitle;
    IBOutlet  UIButton *btnDrug,*btnUser;
}


@property (nonatomic, strong) IBOutlet  UITextField         *txtProductName;
@property (nonatomic, strong) IBOutlet  UITextField         *txtProductUser;

@property (nonatomic, strong) IBOutlet  QWLabel         *drugCycleTitle;
@property (assign) BOOL editEnabled;
@end
