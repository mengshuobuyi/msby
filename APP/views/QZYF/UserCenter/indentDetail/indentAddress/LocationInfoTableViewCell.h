//
//  LocationInfoTableViewCell.h
//  APP
//
//  Created by qw_imac on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface LocationInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *locationMap;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailSpace;

-(void)setCellWith:(AMapPOI *)poi AndNumber:(NSInteger)number;

@end
