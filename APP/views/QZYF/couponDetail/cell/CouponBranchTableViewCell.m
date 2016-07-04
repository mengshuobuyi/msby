//
//  ChooseBranchTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CouponBranchTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CouponBranchTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    
    return 100.0f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.branchImg.image = [UIImage imageNamed:@"img_bg_pharmacy"];
    self.branchNameLabel.text = @"";
    self.addressLabel.text = @"";
    self.distanceLabel.text = @"";
    [self.rating setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
    self.rating.userInteractionEnabled = NO;
    UIView *sepatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, [CouponBranchTableViewCell getCellHeight:nil] - 0.5f, APP_W, 0.5f)];
    sepatorLine.backgroundColor = RGBHex(qwColor10);
    [self addSubview:sepatorLine];
}

- (void)setCell:(CouponBranchVoModel *)model{
    
    [self.branchImg setImageWithURL:[NSURL URLWithString:model.branchLogo] placeholderImage:[UIImage imageNamed:@"img_bg_pharmacy"]];
    self.branchNameLabel.text = model.branchName;
    self.addressLabel.text = model.address;
    self.distanceLabel.text = model.distance;
    [self.rating displayRating:[model.stars intValue]/2];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
