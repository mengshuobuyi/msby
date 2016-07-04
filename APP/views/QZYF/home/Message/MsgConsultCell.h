//
//  MsgConsultCell.h
//  APP
//
//  Created by PerryChen on 6/8/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"

@interface MsgConsultCell : QWBaseCell
@property (nonatomic, strong) IBOutlet  UILabel         *titleLabel;
@property (nonatomic, strong) IBOutlet  UIImageView     *nameIcon;
@property (nonatomic, strong) IBOutlet  QWImageView     *avatarImage;
@property (nonatomic, strong) IBOutlet  UILabel         *contentLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *dateLabel;
@property (nonatomic, weak) IBOutlet    UIImageView     *sendIndicateImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel            *lblSendStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewOutOfDate;

@end
