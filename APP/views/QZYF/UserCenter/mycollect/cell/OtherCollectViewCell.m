//
//  OtherCollectViewCell.m
//  wenyao
//
//  Created by Meng on 14-10-2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "OtherCollectViewCell.h"
#import "FavoriteModel.h"

@implementation OtherCollectViewCell
@synthesize titleLabel=titleLabel;
@synthesize subTitleLabel=sunTitleLabel;

- (void)awakeFromNib
{
    // Initialization code
}

+ (CGFloat)getCellHeight:(id)data{
    return 80;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCell:(id)data{
    [super setCell:data];
    
    //添加其他执行代码
    MyFavSpmListModel *mod = (MyFavSpmListModel*)data;
    NSString *title=[[QWGlobalManager sharedInstance] replaceSpecialStringWith:mod.name];
    [self.titleLabel setLabelValue:title];
NSString *subTitle=[[QWGlobalManager sharedInstance] replaceSpecialStringWith:mod.desc];
    [self.subTitleLabel setLabelValue:subTitle];

    
}

- (void)setDiseaseCell:(id)data{
    [super setCell:data];
    
    //添加其他执行代码
    MyFavDiseaseListModel *mod = (MyFavDiseaseListModel*)data;
    NSString *title=[[QWGlobalManager sharedInstance] replaceSpecialStringWith:mod.cname];
    [self.titleLabel setLabelValue:title];
    NSString *subTitle=[[QWGlobalManager sharedInstance] replaceSpecialStringWith:mod.desc];
    [self.subTitleLabel setLabelValue:subTitle];
    
    
}


- (void)UIGlobal{
    [super UIGlobal];
    [self setSelectedBGColor:RGBHex(qwColor11)];
    self.titleLabel.font = fontSystem(kFontS3);
    self.titleLabel.textColor = RGBHex(qwColor7);
    self.subTitleLabel.font = fontSystem(kFontS4);
    self.subTitleLabel.textColor = RGBHex(qwColor7);
    
}



@end
