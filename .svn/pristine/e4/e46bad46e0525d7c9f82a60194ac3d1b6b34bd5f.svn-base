//
//  StoreGoodTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@protocol StoreGoodTableViewCellDelegate <NSObject>

- (void)addGoodWitIndexPath:(NSIndexPath *)path;

@end

@interface StoreGoodTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) UIView *line;
@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *proRule;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIImageView *couponImage;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (strong, nonatomic) NSIndexPath *path;
@property (weak, nonatomic) IBOutlet UIImageView *ticketImage;
@property (assign, nonatomic) id<StoreGoodTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *packageCountLabel;

- (IBAction)addToGoodCar:(id)sender;

+ (CGFloat)getCellHeight:(id)data;

- (void)setCell:(CartProductVoModel *)data;
- (void)setPackageCell:(ComboProductVoModel *)data;

@end
