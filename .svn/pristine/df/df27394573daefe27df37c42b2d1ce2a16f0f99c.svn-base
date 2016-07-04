//
//  MsgCollectCell.m
//  wenyao
//
//  Created by chenzhipeng on 14/12/29.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MsgCollectCell.h"
#import "FavoriteModel.h"

@implementation MsgCollectCell
@synthesize title=title;
@synthesize introduction=introduction;
@synthesize iconUrl=iconUrl;

+ (CGFloat)getCellHeight:(id)data{
    return 80;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setCell:(id)data{
    [super setCell:data];
    
    
    //添加其他执行代码
    MyFavAdviceListModel *mod = (MyFavAdviceListModel*)data;
    [self.title setLabelValue:[[QWGlobalManager sharedInstance] replaceSpecialStringWith:mod.title]];
    [self.introduction setLabelValue:[[QWGlobalManager sharedInstance] replaceSpecialStringWith:mod.introduction]];
    [self.iconUrl setPlaceholderName:@"药品默认图片.png"];
}

- (void)UIGlobal{
    [super UIGlobal];
    [self setSelectedBGColor:RGBHex(qwColor11)];
}

@end
