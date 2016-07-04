//
//  MsgBoxOfficialCell.h
//  APP
//
//  Created by PerryChen on 8/4/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseCell.h"

@interface MsgBoxOfficialCell : QWBaseCell
@property (nonatomic, strong) IBOutlet  UILabel         *titleLabel;
@property (nonatomic, strong) IBOutlet  UIImageView     *nameIcon;
@property (nonatomic, strong) IBOutlet  QWImageView     *avatarImage;
@property (nonatomic, strong) IBOutlet  UILabel         *contentLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *dateLabel;
@property (nonatomic, weak) IBOutlet    UIImageView     *sendIndicateImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel            *lblSendStatus;
@end