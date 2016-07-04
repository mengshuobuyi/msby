//
//  FactoryTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/3/12.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FactoryTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation FactoryTableViewCell
@synthesize imgUrl = imgUrl;
@synthesize name = name;
@synthesize desc = desc;

+ (CGFloat)getCellHeight:(id)data{
    
    return 90.0f;
}


-(void)UIGlobal{
    [super UIGlobal];
    self.name.font = fontSystem(kFontS3);
    self.name.textColor = RGBHex(qwColor6);
    
    self.desc.font = fontSystem(kFontS4);
    self.desc.textColor = RGBHex(qwColor8);
}

- (void)setCell:(id)data{
    [super setCell:data];
    FactoryDetailModel *factory = (FactoryDetailModel*)data;
    self.desc.text=factory.desc==nil?@"":factory.desc;
    [self.imgUrl setImageWithURL:[NSURL URLWithString:factory.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
}

@end
