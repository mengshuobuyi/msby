//
//  NewStoreTableCell.h
//  APP
//
//  Created by Meng on 15/6/11.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWRatingView.h"
#import "QWButton.h"

@protocol NewStoreTableCellDelegate <NSObject>

- (void)consultButtonClick:(QWButton *)sender;

- (void)PhoneButtonClick:(QWButton *)sender;

@end


@interface NewStoreTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *img_one;
@property (weak, nonatomic) IBOutlet UIImageView *img_two;
@property (weak, nonatomic) IBOutlet UIImageView *img_three;

@property (weak, nonatomic) IBOutlet QWRatingView *starView;

@property (weak, nonatomic) IBOutlet UIImageView *verifyLogo;

@property (weak, nonatomic) IBOutlet UIImageView *consultImageView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImageView;


@property (weak, nonatomic) IBOutlet QWButton *consultButton;
@property (weak, nonatomic) IBOutlet QWButton *PhoneButton;

@property (nonatomic ,strong) id<NewStoreTableCellDelegate>delegate;
- (void)setSelectedBGColor:(UIColor*)aColor;
@end
