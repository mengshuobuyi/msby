//
//  MsgBoxListCell.h
//  APP
//
//  Created by  ChenTaiyu on 16/6/22.
//  Copyright © 2016年 carret. All rights reserved.
//
#import "QWBaseCell.h"
#import "MGSwipeTableCell.h"
@interface MsgBoxListCell : MGSwipeTableCell
@property (nonatomic, strong) IBOutlet  UILabel         *titleLabel;
@property (nonatomic, strong) IBOutlet  UIImageView     *nameIcon;
@property (nonatomic, strong) IBOutlet  UIImageView     *iconImage;
@property (nonatomic, strong) IBOutlet  UILabel         *contentLabel;
@property (nonatomic, strong) IBOutlet  UILabel         *dateLabel;
@property (nonatomic, weak) IBOutlet    UIImageView     *sendIndicateImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *unreadCountView;
@property (weak, nonatomic) IBOutlet UILabel            *lblSendStatus;
@property (weak, nonatomic) IBOutlet UIImageView        *redPoint;
@end