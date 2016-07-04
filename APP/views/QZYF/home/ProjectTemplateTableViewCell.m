//
//  ProjectTemplateTableViewCell.m
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ProjectTemplateTableViewCell.h"
#import "ConfigInfo.h"
#import "UIImageView+WebCache.h"

@implementation ProjectTemplateTableViewCell



- (void)setCell:(id)data
{
    TemplateVoModel *area = (TemplateVoModel *)data;
    if(area.pos.count > 0) //防止越界 add by jxb
    {
        [self.contentImageView setImageWithURL:[NSURL URLWithString:((TemplatePosVoModel *)area.pos[0]).imgUrl] placeholderImage:nil];
    }
}

- (void)prepareForReuse
{
    [self.contentImageView setImage:nil];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
