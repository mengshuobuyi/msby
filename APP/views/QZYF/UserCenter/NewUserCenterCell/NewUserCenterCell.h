//
//  NewUserCenterCell.h
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserCenterCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
-(void)setCellWith:(NSString *)title And:(NSString *)img;
@end
