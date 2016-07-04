//
//  SystemGeneralCell.m
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "SystemGeneralCell.h"
#import "CircleModel.h"

@implementation SystemGeneralCell

+ (CGFloat)getCellHeight:(id)data
{
    TeamMessageModel *model = (TeamMessageModel *)data;
    //改变title视图
    CGSize size = [QWGLOBALMANAGER sizeText:model.msgContent font:fontSystem(14) limitWidth:APP_W-30];
    
    return 67-14+size.height;
}

- (void)setCell:(id)data
{
    [super setCell:data];
    
    TeamMessageModel *model = (TeamMessageModel *)data;
    
    NSString *titleStr = @"";
    if (model.msgType == 6) {
        titleStr = @"删除帖子";
    }else if (model.msgType == 10){
        titleStr = @"审核通过";
    }else if (model.msgType == 12){
        titleStr = @"审核未通过";
    }else if (model.msgType == 13){
        titleStr = @"圈主移除";
    }else if (model.msgType == 14){
        titleStr = @"圈子下线";
    }else if (model.msgType == 15){
        titleStr = @"圈子上线";
    }else if (model.msgType == 16){
        titleStr = @"用户禁言";
    }else if (model.msgType == 17){
        titleStr = @"用户解禁";
    }else if (model.msgType == 20){
        titleStr = @"帖子恢复";
    }
    self.title.text = titleStr;
    self.content.text = model.msgContent;
    self.time.text = model.createDate;
}

@end
