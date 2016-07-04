//
//  InformationTableViewCell.h
//  quanzhi
//
//  Created by xiezhenghong on 14-6-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTableCell.h"

@interface InformationTableViewCell : QWBaseTableCell

//@property (nonatomic, strong) IBOutlet  QWImageView     *iconUrl;
@property (nonatomic, strong )IBOutlet QWImageView      *iconUrl;
@property (nonatomic, strong) IBOutlet  QWLabel         *title;
@property (nonatomic, strong) IBOutlet  QWLabel         *publishTime;
@property (nonatomic, strong) IBOutlet  QWLabel         *introduction;
@property (nonatomic, strong) IBOutlet  QWLabel         *readNum;
@property (nonatomic, strong) IBOutlet  QWLabel         *pariseNum;
@property (nonatomic, strong) IBOutlet UIView *seperatorLine;
//@property (nonatomic, strong) IBOutlet  UIImageView     *backImage;


@end
