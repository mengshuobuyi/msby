//
//  HomepageCollectionViewCell.m
//  APP
//
//  Created by garfield on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "HomepageCollectionViewCell.h"
#import "ConfigInfoModel.h"
#import "UIImageView+WebCache.h"

@implementation HomepageCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.itemImage.layer.cornerRadius = 20;
    self.itemImage.layer.masksToBounds = YES;
}

- (void)setCellData:(id)data
{
    TemplatePosVoModel *model = (TemplatePosVoModel *)data;
    [self.itemImage setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:model.placeHolder]];
    self.itemLabel.text = model.title;
}

@end
