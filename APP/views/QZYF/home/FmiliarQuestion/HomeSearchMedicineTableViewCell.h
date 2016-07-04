//
//  HomeSearchMedicineTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSearchMedicineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *purpose;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *specLable;


+ (CGFloat)getCellHeight:(id)data;

@end
