//
//  ReceiverAddressCell.h
//  APP
//
//  Created by qw_imac on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiveAddress.h"
@interface ReceiverAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *receiverName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *defaultImg;
-(void)setCellWith:(AddressVo *)vo;
@end
